# In-App Purchase Setup Guide

This guide will help you configure in-app purchases for the Path of Light app on both iOS (App Store) and Android (Google Play).

## Overview

The app now supports premium subscriptions with the following tiers:
- **Monthly Premium** (`premium_monthly`) - $4.99/month
- **Yearly Premium** (`premium_yearly`) - $39.99/year (30% savings)
- **Lifetime Premium** (`premium_lifetime`) - $29.99 one-time

### Premium Features Include:
- 200 max energy (double the free tier)
- 10 energy per hour refill rate (2x faster)
- Ad-free experience
- Exclusive premium badges
- Priority support

## iOS Configuration (App Store Connect)

### Prerequisites
- An active Apple Developer account ($99/year)
- Your app must be registered in App Store Connect
- You need your app's Bundle ID

### Step 1: Create In-App Purchase Products

1. Log in to [App Store Connect](https://appstoreconnect.apple.com/)
2. Navigate to **My Apps** → Select your app
3. Go to **Features** → **In-App Purchases**
4. Click the **+** button to create a new product

#### Create Auto-Renewable Subscriptions

**For Monthly Premium:**
- Type: Auto-Renewable Subscription
- Reference Name: Premium Monthly
- Product ID: `premium_monthly`
- Subscription Group: Create new group named "Premium"
- Subscription Duration: 1 Month
- Price: $4.99 USD (Tier 10)
- Localization (English - U.S.):
  - Display Name: "Premium Monthly"
  - Description: "Monthly access to all premium features including double energy, faster refill, and ad-free experience"

**For Yearly Premium:**
- Type: Auto-Renewable Subscription
- Reference Name: Premium Yearly
- Product ID: `premium_yearly`
- Subscription Group: Use the same "Premium" group
- Subscription Duration: 1 Year
- Price: $39.99 USD (Tier 40)
- Localization (English - U.S.):
  - Display Name: "Premium Yearly"
  - Description: "Yearly access to all premium features including double energy, faster refill, and ad-free experience. Save 30%!"

**For Lifetime Premium:**
- Type: Non-Consumable
- Reference Name: Lifetime Premium
- Product ID: `premium_lifetime`
- Price: $29.99 USD (Tier 30)
- Localization (English - U.S.):
  - Display Name: "Lifetime Premium"
  - Description: "Lifetime access to all premium features"

### Step 2: App Store Connect Agreement

1. Ensure you have accepted the **Paid Applications Agreement**
2. Fill out all required banking and tax information
3. This is required before you can test or sell in-app purchases

### Step 3: Testing on iOS

#### Local Testing with StoreKit Configuration

The project includes a `Configuration.storekit` file in the `ios` folder for local testing:

1. Open the project in Xcode
2. Go to **Product** → **Scheme** → **Edit Scheme**
3. Select **Run** → **Options**
4. Under "StoreKit Configuration", select "Configuration.storekit"
5. Now you can test purchases without real transactions

#### Sandbox Testing

1. In App Store Connect, go to **Users and Access** → **Sandbox Testers**
2. Create test user accounts (use valid email format, but they don't need to be real emails)
3. On your iOS device:
   - Go to **Settings** → **App Store** → **Sandbox Account**
   - Sign in with your test account
4. Run the app and test purchases (no real money will be charged)

### Step 4: Production Release

1. Ensure all in-app purchase products are approved
2. Submit your app for review (in-app purchases are reviewed with the app)
3. Once approved, purchases will be live

## Android Configuration (Google Play Console)

### Prerequisites
- A Google Play Developer account ($25 one-time fee)
- Your app must be registered in Google Play Console
- You need your app's package name (`com.example.path_of_light`)

### Step 1: Create In-App Products

1. Log in to [Google Play Console](https://play.google.com/console/)
2. Select your app
3. Navigate to **Monetize** → **Products** → **Subscriptions**

#### Create Subscriptions

**For Monthly Premium:**
1. Click **Create subscription**
2. Product ID: `premium_monthly`
3. Name: "Premium Monthly"
4. Description: "Monthly access to all premium features including double energy, faster refill, and ad-free experience"
5. Billing period: 1 Month
6. Default price: $4.99 USD
7. Free trial: Optional (you can offer 7 days free)
8. Grace period: 3 days (recommended)
9. Click **Save**

**For Yearly Premium:**
1. Click **Create subscription**
2. Product ID: `premium_yearly`
3. Name: "Premium Yearly"
4. Description: "Yearly access to all premium features including double energy, faster refill, and ad-free experience. Save 30%!"
5. Billing period: 1 Year
6. Default price: $39.99 USD
7. Subscription benefits: Add "Save 30% compared to monthly"
8. Click **Save**

#### Create One-Time Product

**For Lifetime Premium:**
1. Navigate to **Monetize** → **Products** → **In-app products**
2. Click **Create product**
3. Product ID: `premium_lifetime`
4. Name: "Lifetime Premium"
5. Description: "Lifetime access to all premium features"
6. Default price: $29.99 USD
7. Click **Save** and then **Activate**

### Step 2: Set Up License Testing

1. In Google Play Console, go to **Setup** → **License testing**
2. Add test Gmail accounts that you'll use for testing
3. Choose the license response: "RESPOND_NORMALLY" for testing purchases

### Step 3: Testing on Android

#### Internal Testing Track

1. In Google Play Console, go to **Testing** → **Internal testing**
2. Create a new release and upload your app
3. Add your test email addresses to the internal testers list
4. Testers will receive an email with a link to download the test version
5. Test purchases will be charged, but will be automatically refunded after ~30 minutes

#### License Testers (Recommended for Development)

1. Add your test Google accounts to the license testing list
2. These accounts can make test purchases immediately without real charges
3. Purchases will go through the full flow but won't be charged

### Step 4: Production Release

1. Ensure all in-app products are activated
2. Create a production release
3. Submit for review
4. Once approved, purchases will be live

## Code Integration

### Product IDs

The following product IDs are used in the code (`lib/services/in_app_purchase_service.dart`):

```dart
static const String premiumMonthlyId = 'premium_monthly';
static const String premiumYearlyId = 'premium_yearly';
static const String premiumLifetimeId = 'premium_lifetime';
```

**Important:** These product IDs in the code MUST match exactly with the product IDs you create in App Store Connect and Google Play Console.

### Purchase Flow

1. User taps "Upgrade to Premium" from the Energy screen
2. App navigates to Premium screen (`lib/screens/premium/premium_screen.dart`)
3. Available products are loaded from the store
4. User selects a subscription tier
5. Platform-specific purchase dialog appears
6. Upon successful purchase, premium status is activated
7. User gets immediate access to premium features

### Premium Status Detection

The app checks for premium status using the `hasPremiumAccessProvider` in `lib/providers/purchase_providers.dart`. This provider:
- Checks if user has an active subscription or lifetime purchase
- Updates the energy system to use premium limits
- Removes ad requirements
- Shows premium badge

### Backend Verification (Recommended for Production)

For production, you should verify purchases on your backend server:

1. When a purchase is completed, the app receives a receipt/token
2. Send this receipt to your backend server
3. Your server verifies the receipt with Apple/Google servers
4. Update user's premium status in your database (Firestore)
5. App checks premium status from your backend

**Current Implementation:** The app currently trusts the platform's verification. For production, implement server-side verification in the `_verifyPurchase` method in `in_app_purchase_service.dart`.

## Testing Checklist

### iOS Testing
- [ ] Products load correctly in the app
- [ ] Monthly subscription can be purchased
- [ ] Yearly subscription can be purchased
- [ ] Lifetime purchase can be completed
- [ ] Premium features are unlocked after purchase
- [ ] Restore purchases works correctly
- [ ] Subscription auto-renewal works
- [ ] Subscription cancellation works

### Android Testing
- [ ] Products load correctly in the app
- [ ] Monthly subscription can be purchased
- [ ] Yearly subscription can be purchased
- [ ] Lifetime purchase can be completed
- [ ] Premium features are unlocked after purchase
- [ ] Restore purchases works correctly
- [ ] Subscription auto-renewal works
- [ ] Subscription cancellation works

## Troubleshooting

### Products Not Loading

**iOS:**
- Ensure you're signed in with a sandbox account on device
- Check that products are approved in App Store Connect
- Verify product IDs match exactly
- Wait a few minutes after creating products (can take time to propagate)

**Android:**
- Ensure app is uploaded to at least internal testing track
- Check that products are activated in Play Console
- Verify package name matches
- Sign APK/AAB with the correct signing key

### Purchase Fails

**iOS:**
- Check sandbox tester account is valid
- Ensure device is set to use sandbox account
- Try logging out and back into sandbox account

**Android:**
- Ensure test account has access to the testing track
- Check that billing permission is in AndroidManifest.xml
- Verify Google Play Services are updated on device

### Premium Features Not Unlocking

- Check the `hasPremiumAccessProvider` is properly refreshed
- Verify purchase completion is being called
- Check Firebase logs for any errors
- Test restore purchases functionality

## Support

For issues with:
- **App Store Connect**: [Apple Developer Support](https://developer.apple.com/support/)
- **Google Play Console**: [Google Play Console Help](https://support.google.com/googleplay/android-developer/)
- **in_app_purchase plugin**: [Flutter Documentation](https://pub.dev/packages/in_app_purchase)

## Additional Resources

- [Apple In-App Purchase Guide](https://developer.apple.com/in-app-purchase/)
- [Google Play Billing Guide](https://developer.android.com/google/play/billing)
- [Flutter in_app_purchase Package](https://pub.dev/packages/in_app_purchase)
- [Revenue Cat - Comprehensive Guide](https://www.revenuecat.com/blog/) (optional alternative)

## Privacy & Compliance

### App Store Requirements
- Update privacy policy to mention subscriptions
- Implement restore purchases (✓ already implemented)
- Provide clear subscription terms
- Show price and duration before purchase (✓ already implemented)

### Google Play Requirements
- Update privacy policy to mention subscriptions
- Provide clear cancellation instructions
- Show price and duration before purchase (✓ already implemented)
- Handle subscription lifecycle events

## Next Steps

1. Create products in App Store Connect and Google Play Console
2. Test purchases using sandbox/test accounts
3. Implement backend verification (recommended)
4. Update privacy policy
5. Submit app for review
6. Monitor subscription metrics

---

**Note:** This implementation provides a complete in-app purchase system. Make sure to thoroughly test all scenarios before releasing to production.
