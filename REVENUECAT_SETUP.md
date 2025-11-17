# RevenueCat In-App Purchase Setup Guide

This comprehensive guide will help you set up RevenueCat for secure in-app purchases with complete purchase history tracking in Firestore.

## Table of Contents
1. [Overview](#overview)
2. [RevenueCat Setup](#revenuecat-setup)
3. [iOS Configuration](#ios-configuration)
4. [Android Configuration](#android-configuration)
5. [Backend Integration](#backend-integration)
6. [Testing](#testing)
7. [Purchase History & Analytics](#purchase-history--analytics)
8. [Troubleshooting](#troubleshooting)

## Overview

### What We've Implemented

✅ **RevenueCat SDK Integration** - Secure, server-side verified purchases
✅ **Three Subscription Tiers**:
- Monthly Premium ($4.99/month)
- Yearly Premium ($39.99/year) - Save 30%
- Lifetime Premium ($29.99 one-time)

✅ **Premium Features**:
- 200 max energy (2x capacity)
- 10 energy/hour refill (2x speed)
- Ad-free experience
- Exclusive badges
- Priority support

✅ **Complete Purchase Tracking**:
- Purchase history in Firestore
- Purchase events logging
- User subscription status
- Lifetime value tracking
- Real-time webhook integration

### Architecture

```
┌─────────────┐
│   Flutter   │
│     App     │
└──────┬──────┘
       │
       ├──► RevenueCat SDK ──► App Store / Play Store
       │
       └──► Firestore (Local tracking)
             ▲
             │
      RevenueCat Webhooks ──► Cloud Functions
```

## RevenueCat Setup

### 1. Create RevenueCat Account

1. Go to [revenuecat.com](https://www.revenuecat.com/)
2. Sign up for free account
3. Create a new project: "Path of Light"

### 2. Get API Keys

1. In RevenueCat dashboard, go to **Project Settings** → **API Keys**
2. Copy your API keys:
   - **Apple App Store API Key** (starts with `appl_`)
   - **Google Play Store API Key** (starts with `goog_`)

3. Update `lib/services/revenue_cat_service.dart`:
```dart
// TODO: Replace with your actual API keys
static const String _appleApiKey = 'appl_YOUR_APPLE_API_KEY';
static const String _googleApiKey = 'goog_YOUR_GOOGLE_API_KEY';
```

### 3. Create Entitlement

1. In RevenueCat, go to **Entitlements**
2. Click **New Entitlement**
3. Name: `premium`
4. Identifier: `premium` (must match code)

### 4. Create Products

In RevenueCat, go to **Products** and create:

**Monthly Subscription:**
- Product ID: Create in App Store Connect / Play Console first
- Add to `premium` entitlement

**Yearly Subscription:**
- Product ID: Create in App Store Connect / Play Console first
- Add to `premium` entitlement

**Lifetime Purchase:**
- Product ID: Create in App Store Connect / Play Console first
- Add to `premium` entitlement

### 5. Create Offering

1. Go to **Offerings**
2. Create offering named "default"
3. Add all three products to the offering
4. Set package identifiers:
   - Monthly: `$rc_monthly`
   - Yearly: `$rc_annual`
   - Lifetime: `lifetime`

## iOS Configuration

### 1. App Store Connect Setup

1. Log in to [App Store Connect](https://appstoreconnect.apple.com/)
2. Select your app
3. Go to **Features** → **In-App Purchases**

**Create Monthly Subscription:**
- Type: Auto-Renewable Subscription
- Product ID: `com.pathoflight.premium.monthly` (or your choice)
- Subscription Group: "Premium"
- Duration: 1 Month
- Price: $4.99
- Display Name: "Monthly Premium"
- Description: "Monthly access to all premium features"

**Create Yearly Subscription:**
- Type: Auto-Renewable Subscription
- Product ID: `com.pathoflight.premium.yearly`
- Same subscription group
- Duration: 1 Year
- Price: $39.99
- Display Name: "Yearly Premium"

**Create Lifetime Purchase:**
- Type: Non-Consumable
- Product ID: `com.pathoflight.premium.lifetime`
- Price: $29.99
- Display Name: "Lifetime Premium"

### 2. RevenueCat iOS Integration

1. In RevenueCat, go to **Project Settings** → **Apple App Store**
2. Click **Add App**
3. Enter your Bundle ID
4. Upload App Store Connect API Key (In-App Purchase Key)

### 3. Configure Webhooks

1. In RevenueCat, go to **Integrations** → **Webhooks**
2. Add webhook URL: `https://YOUR_PROJECT_ID.cloudfunctions.net/revenueCatWebhook`
3. Select all event types
4. Save

## Android Configuration

### 1. Google Play Console Setup

1. Log in to [Google Play Console](https://play.google.com/console/)
2. Select your app
3. Go to **Monetize** → **Subscriptions**

**Create Monthly Subscription:**
- Product ID: `premium_monthly`
- Name: "Monthly Premium"
- Description: "Monthly access to all premium features"
- Billing period: 1 Month
- Price: $4.99

**Create Yearly Subscription:**
- Product ID: `premium_yearly`
- Name: "Yearly Premium"
- Billing period: 1 Year
- Price: $39.99

**Create Lifetime Product:**
- Go to **In-app products**
- Product ID: `premium_lifetime`
- Name: "Lifetime Premium"
- Price: $29.99

### 2. RevenueCat Android Integration

1. In RevenueCat, go to **Project Settings** → **Google Play Store**
2. Click **Add App**
3. Enter your package name
4. Upload Service Account JSON (from Google Cloud Console)

## Backend Integration

### 1. Firestore Collections

The following collections are automatically created:

**`purchase_history`** - All purchase records
```typescript
{
  id: string
  userId: string
  productId: string
  packageId: string
  type: 'subscription' | 'lifetime'
  price: number
  currency: string
  purchaseDate: Timestamp
  status: 'active' | 'expired' | 'cancelled'
  transactionId: string
  expirationDate?: Timestamp
  store: 'app_store' | 'play_store'
  metadata: {}
}
```

**`user_subscriptions`** - Current subscription status
```typescript
{
  userId: string
  isPremium: boolean
  currentProductId: string
  subscriptionStartDate: Timestamp
  subscriptionExpiryDate?: Timestamp
  willRenew: boolean
  store: string
  totalPurchases: number
  lifetimeValue: number
  ownedProducts: string[]
}
```

**`purchase_events`** - Event log
```typescript
{
  id: string
  userId: string
  eventType: string
  timestamp: Timestamp
  productId: string
  price?: number
  metadata: {}
}
```

### 2. Security Rules

Add to `firestore.rules`:
```javascript
// Purchase history - users can only read their own
match /purchase_history/{purchaseId} {
  allow read: if request.auth != null && resource.data.userId == request.auth.uid;
  allow write: if false; // Only server can write
}

// User subscriptions - users can only read their own
match /user_subscriptions/{userId} {
  allow read: if request.auth != null && request.auth.uid == userId;
  allow write: if false; // Only server can write
}

// Purchase events - users can only read their own
match /purchase_events/{eventId} {
  allow read: if request.auth != null && resource.data.userId == request.auth.uid;
  allow write: if false; // Only server can write
}
```

### 3. Cloud Functions

The webhook handler (`functions/src/revenueCatWebhooks.ts`) automatically:
- Processes purchase events
- Updates Firestore
- Tracks subscription renewals
- Handles cancellations
- Logs all events

## Testing

### iOS Testing

**1. Sandbox Testing:**
- Create sandbox tester in App Store Connect
- Sign in with sandbox account on device
- Test purchases (no real money charged)

**2. StoreKit Configuration:**
- Use `ios/Configuration.storekit` for local testing
- In Xcode: Edit Scheme → Run → Options → StoreKit Configuration

### Android Testing

**1. License Testing:**
- Add test account in Play Console → Setup → License testing
- Test purchases (auto-refunded in 5 minutes)

**2. Internal Testing:**
- Upload to internal testing track
- Add testers
- Full purchase flow testing

### RevenueCat Testing

1. In RevenueCat dashboard, go to **Customer History**
2. Search for your test user ID
3. Verify purchases appear correctly

## Purchase History & Analytics

### Viewing Purchase History

Users can view their complete purchase history:
1. Tap Premium icon → History icon
2. See all purchases with:
   - Purchase date
   - Product/package name
   - Price
   - Status (active/expired/cancelled)
   - Transaction details

### Admin Analytics

Query Firestore for analytics:

**Total Revenue:**
```typescript
const snapshot = await db.collection('purchase_history')
  .where('status', '==', 'active')
  .get();

let total = 0;
snapshot.docs.forEach(doc => total += doc.data().price);
```

**Active Subscribers:**
```typescript
const count = await db.collection('user_subscriptions')
  .where('isPremium', '==', true)
  .count()
  .get();
```

**User Lifetime Value:**
```typescript
const doc = await db.collection('user_subscriptions')
  .doc(userId)
  .get();

const ltv = doc.data().lifetimeValue;
```

## Troubleshooting

### Products Not Loading

**Check:**
1. API keys are correct in `revenue_cat_service.dart`
2. Products exist in App Store Connect / Play Console
3. Products are added to RevenueCat
4. Products are in an offering
5. Internet connection is working

**Debug:**
```dart
await Purchases.setLogLevel(LogLevel.debug);
```

### Purchase Fails

**iOS:**
- Check sandbox tester is signed in
- Verify product IDs match exactly
- Ensure app is signed correctly

**Android:**
- Verify app is uploaded to at least internal testing
- Check service account has correct permissions
- Ensure billing permission is in manifest

### Webhook Not Working

**Check:**
1. Cloud Function is deployed: `firebase deploy --only functions:revenueCatWebhook`
2. Webhook URL is correct in RevenueCat
3. Check Cloud Function logs for errors

### Premium Not Activating

**Verify:**
1. Check RevenueCat dashboard for purchase
2. Verify `premium` entitlement is active
3. Check Firestore `user_subscriptions` collection
4. Verify Cloud Function processed webhook

## Security Best Practices

### ✅ Implemented
- ✅ Server-side receipt validation (RevenueCat)
- ✅ Secure Firestore rules (users can only read own data)
- ✅ Webhook verification
- ✅ Transaction logging

### 🔒 Recommended
- Set up RevenueCat webhook authentication
- Monitor for unusual purchase patterns
- Implement rate limiting on Cloud Functions
- Regular security audits

## Cost Breakdown

### RevenueCat Pricing
- **Free**: Up to $10k/month tracked revenue
- After $10k/month: Starting at $250/month

### Firebase Costs
- **Firestore**: ~$0.18/100k reads
- **Cloud Functions**: ~$0.40/million invocations
- Estimated monthly cost for 1000 purchases: ~$5

## Support Resources

- **RevenueCat Docs**: https://docs.revenuecat.com/
- **RevenueCat Support**: support@revenuecat.com
- **Flutter Plugin**: https://pub.dev/packages/purchases_flutter
- **Community**: https://community.revenuecat.com/

## Next Steps

1. ✅ Complete RevenueCat setup
2. ✅ Create products in App Store Connect / Play Console
3. ✅ Configure webhooks
4. ✅ Test purchases with sandbox accounts
5. ✅ Monitor Firestore for purchase data
6. ✅ Review analytics in RevenueCat dashboard
7. ✅ Submit app for review

---

**Implementation Complete!** Your app now has:
- ✅ Secure server-side purchase verification
- ✅ Complete purchase history tracking
- ✅ Real-time webhook integration
- ✅ Premium feature unlocking
- ✅ Subscription management

All purchases are automatically tracked in Firestore with complete history and analytics.
