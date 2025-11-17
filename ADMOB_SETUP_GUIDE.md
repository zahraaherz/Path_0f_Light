# AdMob Integration Guide - Path of Light

This guide explains how the AdMob integration has been set up with G-rating filters for family-safe, Islamic-appropriate advertising.

## ✅ What Has Been Implemented

### 1. **Google Mobile Ads Package**
- Added `google_mobile_ads: ^5.1.0` to `pubspec.yaml`

### 2. **G-Rating Content Filter**
- **MaxAdContentRating.g** - Only shows G-rated ads (General Audiences)
- **TagForChildDirectedTreatment.yes** - COPPA compliant, child-directed
- **Blocks**: Violence, nudity, alcohol, gambling, mature content

### 3. **Platform Configuration**

#### Android (`android/app/src/main/AndroidManifest.xml`)
```xml
<meta-data
    android:name="com.google.android.gms.ads.APPLICATION_ID"
    android:value="ca-app-pub-3940256099942544~3347511713"/>
```

#### iOS (`ios/Runner/Info.plist`)
```xml
<key>GADApplicationIdentifier</key>
<string>ca-app-pub-3940256099942544~1458002511</string>
```

**⚠️ Note**: These are TEST IDs. Replace with your real AdMob App IDs before publishing.

### 4. **Reusable Ad Widget**
Created `lib/widgets/halal_banner_ad.dart` - A reusable banner ad component that can be used in any screen.

### 5. **Home Screen Integration**
Updated `lib/screens/home/home_screen.dart` with banner ad at the bottom.

---

## 🚀 Next Steps to Go Live

### Step 1: Create AdMob Account
1. Go to https://admob.google.com/
2. Sign up with your Google account
3. Create a new app in AdMob dashboard

### Step 2: Get Your Real Ad Unit IDs

#### For Android:
1. In AdMob dashboard → Apps → Add App
2. Select "Android" platform
3. Enter app name: "Path of Light"
4. Create **Banner** ad unit
5. Copy your **Android App ID** (format: `ca-app-pub-XXXXXXXXXXXXXXXX~YYYYYYYYYY`)
6. Copy your **Android Banner Ad Unit ID** (format: `ca-app-pub-XXXXXXXXXXXXXXXX/YYYYYYYYYY`)

#### For iOS:
1. In AdMob dashboard → Apps → Add App
2. Select "iOS" platform
3. Enter app name: "Path of Light"
4. Create **Banner** ad unit
5. Copy your **iOS App ID**
6. Copy your **iOS Banner Ad Unit ID**

### Step 3: Replace Test IDs with Real IDs

#### Update Android Manifest
File: `android/app/src/main/AndroidManifest.xml`
```xml
<meta-data
    android:name="com.google.android.gms.ads.APPLICATION_ID"
    android:value="YOUR_ANDROID_APP_ID"/>
```

#### Update iOS Info.plist
File: `ios/Runner/Info.plist`
```xml
<key>GADApplicationIdentifier</key>
<string>YOUR_IOS_APP_ID</string>
```

#### Update Banner Ad Widget
File: `lib/widgets/halal_banner_ad.dart`

Replace this line:
```dart
static const String _adUnitId = 'ca-app-pub-3940256099942544/6300978111';
```

With platform-specific ad unit IDs:
```dart
import 'dart:io';

// In the _HalalBannerAdState class
static String get _adUnitId {
  if (Platform.isAndroid) {
    return 'YOUR_ANDROID_BANNER_AD_UNIT_ID';
  } else if (Platform.isIOS) {
    return 'YOUR_IOS_BANNER_AD_UNIT_ID';
  } else {
    throw UnsupportedError('Unsupported platform');
  }
}
```

### Step 4: Enable Content Filtering in AdMob Dashboard

1. Go to AdMob → **Blocking controls**
2. Enable **Sensitive categories** blocking:
   - ✅ Alcohol
   - ✅ Gambling & betting
   - ✅ Dating
   - ✅ Get rich quick
   - ✅ Occult/astrology
   - ✅ Politics
   - ✅ Religion (if showing non-Islamic content)
   - ✅ Weapons/military
   - ✅ Any other inappropriate categories

3. Set **Maximum ad content rating** to **G** (General audiences)

### Step 5: Test Your Ads

1. Run the app on a real device (ads don't always show in simulators)
2. Check that ads are displaying correctly
3. Verify ads are family-friendly and appropriate

### Step 6: Publish to App Stores

Make sure to comply with:
- **Google Play**: Set target audience to include children in your app listing
- **App Store**: Set age rating appropriately

---

## 📱 How to Use the Banner Ad in Other Screens

To add banner ads to other screens:

```dart
import '../widgets/halal_banner_ad.dart';

class YourScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your Screen')),
      body: Column(
        children: [
          Expanded(
            child: YourContent(),
          ),
          const HalalBannerAd(), // Add banner at bottom
        ],
      ),
    );
  }
}
```

---

## 🔒 Content Safety Features

### What's Filtered:
✅ Violence and weapons
✅ Nudity and sexual content
✅ Alcohol and drugs
✅ Gambling
✅ Mature/adult content
✅ Profanity

### What's Allowed:
✅ G-rated content only
✅ Family-friendly products
✅ Educational content
✅ General consumer products

---

## ⚠️ Important Notes

1. **Revenue Expectations**: G-rated ads typically have lower CPM (cost per thousand impressions) than unrestricted ads, but they ensure halal compliance.

2. **Not 100% Halal Guaranteed**: While AdMob's G-rating filter blocks most inappropriate content, it's not specifically Islamic. For 100% halal ads:
   - Sign up for **Halal.Ad** (https://halal.ad/) as a Publisher
   - When their Android SDK is released, you can switch or use both

3. **Testing**: During development, you'll see test ads. Real ads will only show when you:
   - Use real AdMob Ad Unit IDs
   - Publish to app stores (or use a release build)
   - Have actual users

4. **Ad Performance**: Banner ads at the bottom of screens typically have the best performance without disrupting user experience.

---

## 📊 Expected Revenue

With G-rated content filtering:
- **CPM**: $0.50 - $2.00 (varies by country)
- **Click-through rate**: 0.5% - 2%
- **Revenue per 1000 users/day**: $1 - $10 (approximate)

---

## 🆘 Troubleshooting

### Ads not showing?
1. Make sure you're using a real device (not simulator)
2. Check internet connection
3. Wait a few minutes (first ad load can be slow)
4. Check AdMob dashboard for any issues
5. Verify Ad Unit IDs are correct

### Seeing inappropriate ads?
1. Double-check G-rating is set in code (`main.dart`)
2. Verify content filtering in AdMob dashboard
3. Report the ad in AdMob dashboard

---

## 📞 Support

- **AdMob Help**: https://support.google.com/admob
- **Halal.Ad Contact**: Sign up at https://halal.ad/

---

## 🎯 Future Improvements

1. **Add Interstitial Ads** - Full-screen ads between content
2. **Add Rewarded Ads** - Users watch ads for rewards/premium features
3. **Implement Halal.Ad SDK** - When Android SDK is released
4. **Add Analytics** - Track ad performance and revenue

---

**Last Updated**: November 2025
**Integration Status**: ✅ Complete and Ready for Testing
