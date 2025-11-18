import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import * as crypto from 'crypto';

/**
 * RevenueCat Webhook Handler
 *
 * This Cloud Function handles webhooks from RevenueCat for:
 * - Purchase events
 * - Subscription renewals
 * - Cancellations
 * - Refunds
 * - Trial conversions
 *
 * Configure this webhook URL in your RevenueCat dashboard:
 * https://YOUR_PROJECT_ID.cloudfunctions.net/revenueCatWebhook
 *
 * IMPORTANT: Set the webhook authorization header in RevenueCat dashboard
 * and store the secret in Firebase config:
 * firebase functions:config:set revenuecat.webhook_secret="YOUR_SECRET_KEY"
 */

interface RevenueCatWebhookEvent {
  event: {
    type: string;
    app_user_id: string;
    product_id: string;
    period_type: string;
    purchased_at_ms: number;
    expiration_at_ms?: number;
    store: string;
    environment: string;
    is_trial_period: boolean;
    price?: number;
    currency?: string;
    transaction_id?: string;
    original_transaction_id?: string;
    cancellation_reason?: string;
  };
  api_version: string;
}

/**
 * Verify webhook signature to ensure request is from RevenueCat
 */
function verifyWebhookSignature(
  body: string,
  signature: string | undefined,
  secret: string
): boolean {
  if (!signature) {
    return false;
  }

  try {
    // RevenueCat uses HMAC SHA256 for webhook signatures
    const hmac = crypto.createHmac('sha256', secret);
    hmac.update(body);
    const expectedSignature = hmac.digest('hex');

    // Use timing-safe comparison to prevent timing attacks
    return crypto.timingSafeEqual(
      Buffer.from(signature),
      Buffer.from(expectedSignature)
    );
  } catch (error) {
    console.error('Error verifying webhook signature:', error);
    return false;
  }
}

export const revenueCatWebhook = functions.https.onRequest(async (req, res) => {
  // Verify it's a POST request
  if (req.method !== 'POST') {
    res.status(405).send('Method Not Allowed');
    return;
  }

  // Verify webhook signature for security
  const webhookSecret = functions.config().revenuecat?.webhook_secret;

  if (!webhookSecret) {
    console.error('RevenueCat webhook secret not configured');
    res.status(500).send('Server configuration error');
    return;
  }

  const signature = req.headers['x-revenuecat-signature'] as string | undefined;
  const rawBody = JSON.stringify(req.body);

  if (!verifyWebhookSignature(rawBody, signature, webhookSecret)) {
    console.error('Invalid webhook signature');
    res.status(401).send('Unauthorized - Invalid signature');
    return;
  }

  try {
    const webhookEvent: RevenueCatWebhookEvent = req.body;
    const { event } = webhookEvent;

    console.log('RevenueCat Webhook Event:', event.type, 'for user:', event.app_user_id);

    // Get Firestore reference
    const db = admin.firestore();
    const userId = event.app_user_id;

    // Handle different event types
    switch (event.type) {
      case 'INITIAL_PURCHASE':
      case 'RENEWAL':
        await handlePurchaseOrRenewal(db, userId, event);
        break;

      case 'CANCELLATION':
        await handleCancellation(db, userId, event);
        break;

      case 'UNCANCELLATION':
        await handleUncancellation(db, userId, event);
        break;

      case 'NON_RENEWING_PURCHASE':
        await handleNonRenewingPurchase(db, userId, event);
        break;

      case 'EXPIRATION':
        await handleExpiration(db, userId, event);
        break;

      case 'BILLING_ISSUE':
        await handleBillingIssue(db, userId, event);
        break;

      case 'PRODUCT_CHANGE':
        await handleProductChange(db, userId, event);
        break;

      case 'TRANSFER':
        await handleTransfer(db, userId, event);
        break;

      default:
        console.log('Unhandled event type:', event.type);
    }

    // Log the event
    await logPurchaseEvent(db, userId, event);

    res.status(200).send('OK');
  } catch (error) {
    console.error('Error processing webhook:', error);
    res.status(500).send('Internal Server Error');
  }
});

async function handlePurchaseOrRenewal(
  db: admin.firestore.Firestore,
  userId: string,
  event: any
) {
  const purchaseData = {
    id: event.transaction_id || `${userId}_${Date.now()}`,
    userId,
    productId: event.product_id,
    packageId: event.product_id, // RevenueCat uses same ID
    type: event.period_type === 'normal' ? 'subscription' : 'trial',
    price: event.price || 0,
    currency: event.currency || 'USD',
    purchaseDate: admin.firestore.Timestamp.fromMillis(event.purchased_at_ms),
    status: 'active',
    transactionId: event.transaction_id,
    originalTransactionId: event.original_transaction_id,
    expirationDate: event.expiration_at_ms
      ? admin.firestore.Timestamp.fromMillis(event.expiration_at_ms)
      : null,
    isInTrialPeriod: event.is_trial_period,
    store: event.store,
    metadata: {
      environment: event.environment,
      periodType: event.period_type,
    },
  };

  // Save purchase history
  await db.collection('purchase_history').doc(purchaseData.id).set(purchaseData, { merge: true });

  // Update user subscription status
  const subscriptionData = {
    userId,
    isPremium: true,
    currentProductId: event.product_id,
    currentPackageId: event.product_id,
    subscriptionStartDate: admin.firestore.Timestamp.fromMillis(event.purchased_at_ms),
    subscriptionExpiryDate: event.expiration_at_ms
      ? admin.firestore.Timestamp.fromMillis(event.expiration_at_ms)
      : null,
    willRenew: true,
    store: event.store,
    lastPurchaseDate: admin.firestore.FieldValue.serverTimestamp(),
  };

  await db.collection('user_subscriptions').doc(userId).set(subscriptionData, { merge: true });

  // Increment total purchases
  await db.collection('user_subscriptions').doc(userId).update({
    totalPurchases: admin.firestore.FieldValue.increment(1),
    lifetimeValue: admin.firestore.FieldValue.increment(event.price || 0),
  });

  console.log('Purchase/Renewal processed for user:', userId);
}

async function handleCancellation(
  db: admin.firestore.Firestore,
  userId: string,
  event: any
) {
  // Update subscription to not renew
  await db.collection('user_subscriptions').doc(userId).update({
    willRenew: false,
  });

  // Update purchase history if transaction ID exists
  if (event.transaction_id) {
    await db.collection('purchase_history').doc(event.transaction_id).update({
      cancellationDate: admin.firestore.FieldValue.serverTimestamp(),
      cancellationReason: event.cancellation_reason || 'user_cancelled',
      metadata: admin.firestore.FieldValue.arrayUnion({
        cancelledAt: Date.now(),
        reason: event.cancellation_reason,
      }),
    });
  }

  console.log('Cancellation processed for user:', userId);
}

async function handleUncancellation(
  db: admin.firestore.Firestore,
  userId: string,
  event: any
) {
  // Re-enable renewal
  await db.collection('user_subscriptions').doc(userId).update({
    willRenew: true,
  });

  console.log('Uncancellation processed for user:', userId);
}

async function handleNonRenewingPurchase(
  db: admin.firestore.Firestore,
  userId: string,
  event: any
) {
  const purchaseData = {
    id: event.transaction_id || `${userId}_${Date.now()}`,
    userId,
    productId: event.product_id,
    packageId: event.product_id,
    type: 'lifetime',
    price: event.price || 0,
    currency: event.currency || 'USD',
    purchaseDate: admin.firestore.Timestamp.fromMillis(event.purchased_at_ms),
    status: 'active',
    transactionId: event.transaction_id,
    originalTransactionId: event.original_transaction_id,
    store: event.store,
    metadata: {
      environment: event.environment,
    },
  };

  await db.collection('purchase_history').doc(purchaseData.id).set(purchaseData);

  // Update user subscription for lifetime access
  await db.collection('user_subscriptions').doc(userId).set({
    userId,
    isPremium: true,
    currentProductId: event.product_id,
    currentPackageId: event.product_id,
    subscriptionStartDate: admin.firestore.Timestamp.fromMillis(event.purchased_at_ms),
    willRenew: false, // Lifetime doesn't renew
    store: event.store,
    lastPurchaseDate: admin.firestore.FieldValue.serverTimestamp(),
    totalPurchases: admin.firestore.FieldValue.increment(1),
    lifetimeValue: admin.firestore.FieldValue.increment(event.price || 0),
  }, { merge: true });

  console.log('Non-renewing purchase processed for user:', userId);
}

async function handleExpiration(
  db: admin.firestore.Firestore,
  userId: string,
  event: any
) {
  // Update subscription to expired
  await db.collection('user_subscriptions').doc(userId).update({
    isPremium: false,
    willRenew: false,
  });

  // Update purchase history
  if (event.transaction_id) {
    await db.collection('purchase_history').doc(event.transaction_id).update({
      status: 'expired',
    });
  }

  console.log('Expiration processed for user:', userId);
}

async function handleBillingIssue(
  db: admin.firestore.Firestore,
  userId: string,
  event: any
) {
  // Log billing issue but don't immediately cancel premium
  // Give grace period for user to fix billing
  await db.collection('user_subscriptions').doc(userId).update({
    metadata: admin.firestore.FieldValue.arrayUnion({
      billingIssue: true,
      billingIssueDate: Date.now(),
    }),
  });

  console.log('Billing issue logged for user:', userId);
}

async function handleProductChange(
  db: admin.firestore.Firestore,
  userId: string,
  event: any
) {
  // Update to new product
  await db.collection('user_subscriptions').doc(userId).update({
    currentProductId: event.product_id,
    currentPackageId: event.product_id,
  });

  console.log('Product change processed for user:', userId);
}

async function handleTransfer(
  db: admin.firestore.Firestore,
  userId: string,
  event: any
) {
  // Transfer purchase to new user (family sharing, etc.)
  console.log('Transfer event for user:', userId);
  // Implement transfer logic as needed
}

async function logPurchaseEvent(
  db: admin.firestore.Firestore,
  userId: string,
  event: any
) {
  const eventData = {
    id: `${userId}_${Date.now()}`,
    userId,
    eventType: mapEventType(event.type),
    timestamp: admin.firestore.FieldValue.serverTimestamp(),
    productId: event.product_id,
    packageId: event.product_id,
    price: event.price,
    currency: event.currency,
    transactionId: event.transaction_id,
    metadata: {
      store: event.store,
      environment: event.environment,
      rawEventType: event.type,
    },
  };

  await db.collection('purchase_events').add(eventData);
}

function mapEventType(revenueCatEventType: string): string {
  const eventMap: Record<string, string> = {
    'INITIAL_PURCHASE': 'purchase_completed',
    'RENEWAL': 'subscription_renewed',
    'CANCELLATION': 'purchase_cancelled',
    'EXPIRATION': 'subscription_expired',
    'BILLING_ISSUE': 'purchase_failed',
    'NON_RENEWING_PURCHASE': 'purchase_completed',
  };

  return eventMap[revenueCatEventType] || 'purchase_initiated';
}
