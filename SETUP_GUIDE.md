# Path of Light - Complete Setup Guide

This guide covers the complete setup process for the "My Collection" feature with Firebase Anonymous Authentication, Cloud Functions, and Push Notifications.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Frontend Setup](#frontend-setup)
3. [Backend Setup](#backend-setup)
4. [Firebase Configuration](#firebase-configuration)
5. [Testing](#testing)
6. [Troubleshooting](#troubleshooting)

---

## Prerequisites

Before you begin, ensure you have:

- Flutter SDK (3.0.0 or higher)
- Node.js (18.x or higher) for Cloud Functions
- Firebase CLI installed: `npm install -g firebase-tools`
- A Firebase project set up
- Android Studio / Xcode for mobile testing

---

## Frontend Setup

### 1. Install Dependencies

```bash
# Install Flutter dependencies
flutter pub get
```

The following packages have been added to `pubspec.yaml`:
- `firebase_messaging: ^14.7.10` - Push notifications
- `flutter_slidable: ^3.0.1` - Swipe actions on collection cards
- `freezed` and `freezed_annotation` - Immutable data models
- `build_runner` - Code generation

### 2. Generate Freezed Models

Run the code generator to create the necessary model files:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

This will generate:
- `lib/models/collection/collection_item.freezed.dart`
- `lib/models/collection/reminder.freezed.dart`
- `lib/models/collection/habit_tracker.freezed.dart`

**Note:** You need to run this command whenever you modify any `@freezed` model classes.

### 3. Firebase Configuration

If you haven't already, configure Firebase for your Flutter app:

```bash
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Configure Firebase
flutterfire configure
```

This will:
- Create/update `firebase_options.dart`
- Set up Firebase for all platforms (Android, iOS, Web)

### 4. Platform-Specific Setup

#### Android

Add the following to `android/app/src/main/AndroidManifest.xml`:

```xml
<!-- Inside <application> tag -->
<meta-data
    android:name="com.google.firebase.messaging.default_notification_channel_id"
    android:value="collection_reminders" />

<!-- Request notification permission (Android 13+) -->
<uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
```

#### iOS

1. Add notification capability in Xcode:
   - Open `ios/Runner.xcworkspace`
   - Select your target → Capabilities
   - Enable "Push Notifications"
   - Enable "Background Modes" → Check "Remote notifications"

2. Add to `ios/Runner/Info.plist`:

```xml
<key>UIBackgroundModes</key>
<array>
    <string>remote-notification</string>
</array>
```

3. Request APNs certificate from Apple Developer Portal and upload to Firebase Console.

---

## Backend Setup

### 1. Install Dependencies

```bash
cd functions
npm install
```

New dependencies added:
- `adhan: ^4.4.3` - Islamic prayer time calculations

### 2. Build TypeScript

```bash
npm run build
```

This compiles TypeScript to JavaScript in the `lib/` directory.

### 3. Deploy Cloud Functions

```bash
# Deploy all functions and Firestore rules
firebase deploy --only functions,firestore:rules

# Or deploy specific functions
firebase deploy --only functions:processReminders
firebase deploy --only functions:processPrayerReminders
firebase deploy --only functions:onReminderWrite
firebase deploy --only functions:registerFCMToken
firebase deploy --only functions:sendTestNotification
```

### 4. Verify Deployment

Check the Firebase Console:
- Go to **Functions** tab
- Verify all functions are deployed:
  - `processReminders` (scheduled every 5 minutes)
  - `processPrayerReminders` (scheduled every 1 hour)
  - `onReminderWrite` (Firestore trigger)
  - `registerFCMToken` (callable)
  - `unregisterFCMToken` (callable)
  - `sendTestNotification` (callable)
  - `cleanupOldTokens` (scheduled daily)

---

## Firebase Configuration

### 1. Enable Anonymous Authentication

1. Go to Firebase Console → **Authentication**
2. Click **Sign-in method** tab
3. Enable **Anonymous** provider
4. Click **Save**

### 2. Configure Firestore Security Rules

The `firestore.rules` file has been updated to support:
- Anonymous users (guests)
- User-specific collections
- Public read access for books/content

Deploy rules:
```bash
firebase deploy --only firestore:rules
```

### 3. Enable Cloud Messaging

1. Go to Firebase Console → **Cloud Messaging**
2. Enable Cloud Messaging API (if not already enabled)
3. For iOS: Upload APNs certificate

### 4. Set Up Firestore Indexes (if needed)

If you get index errors, Firebase will provide a link to auto-create them. Common indexes needed:

```
Collection: collection_items
- user_id (Ascending) + created_at (Descending)
- user_id (Ascending) + category (Ascending)
- user_id (Ascending) + is_favorite (Ascending)

Collection: reminders
- user_id (Ascending) + is_active (Ascending) + next_trigger (Ascending)
```

---

## Testing

### 1. Test Guest Access

1. **Launch the app**
2. **On Login Screen:** Tap "Continue as Guest"
3. **Verify:**
   - User is signed in anonymously
   - Can navigate to "My Collection"
   - Can add items to collection
4. **Check Firestore:**
   - Go to Firebase Console → Firestore
   - Verify `collection_items` collection has documents with the guest's `user_id`
   - Verify `guest_metadata` collection has tracking data

### 2. Test Account Linking

1. **While signed in as guest:**
   - Add some items to collection (3-5 items)
2. **Tap "Sign Up" button** in the collection screen
3. **Create an account** with email/password or social sign-in
4. **Verify:**
   - All collection items are still there
   - Can sign out and sign back in with the new account
   - All data is preserved
5. **Check Firestore:**
   - `guest_metadata` document should be updated with conversion info

### 3. Test Reminders

1. **Create a collection item** with a reminder
2. **Set reminder for 5 minutes from now**
3. **Wait 5-10 minutes**
4. **Verify:**
   - Push notification received
   - Check Cloud Function logs in Firebase Console
5. **Test prayer-based reminders:**
   - Create reminder for "Fajr + 10 minutes"
   - Verify next_trigger is calculated correctly

### 4. Test Push Notifications

1. **Send test notification:**
   ```dart
   // In the app, call:
   ref.read(sendTestNotificationProvider);
   ```
2. **Verify:**
   - Notification appears when app is in foreground
   - Notification appears when app is in background
   - Tapping notification navigates to collection

### 5. Test Habit Tracking

1. **Create a collection item**
2. **Enable habit tracking** (daily recitation)
3. **Mark as complete** several times
4. **Verify:**
   - Current count increases
   - Streak is calculated correctly
   - Completion history is saved

---

## Troubleshooting

### Frontend Issues

#### Issue: "freezed files not found"

**Solution:**
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

#### Issue: "Firebase not initialized"

**Solution:**
```bash
flutterfire configure
flutter clean
flutter pub get
```

#### Issue: Notifications not working on Android 13+

**Solution:**
- Ensure `POST_NOTIFICATIONS` permission is in AndroidManifest.xml
- App must explicitly request permission at runtime (handled by NotificationService)

#### Issue: Notifications not working on iOS

**Solution:**
- Verify APNs certificate is uploaded to Firebase
- Check that "Push Notifications" capability is enabled in Xcode
- Test on a real device (notifications don't work on simulator)

### Backend Issues

#### Issue: Cloud Functions deployment fails

**Solution:**
```bash
cd functions
npm install
npm run build
firebase deploy --only functions
```

#### Issue: "adhan package not found"

**Solution:**
```bash
cd functions
npm install adhan@^4.4.3
npm run build
```

#### Issue: Scheduled functions not running

**Solution:**
- Check Firebase Console → Functions → Logs
- Verify Cloud Scheduler is enabled in Google Cloud Console
- Ensure billing is enabled (scheduled functions require Blaze plan)

#### Issue: Reminders not sending

**Solution:**
1. Check Cloud Function logs for errors
2. Verify FCM token is registered:
   ```javascript
   // In Firestore, check fcm_tokens collection
   ```
3. Test manually:
   ```bash
   firebase functions:shell
   processReminders()
   ```

### Firestore Issues

#### Issue: Permission denied

**Solution:**
- Verify user is authenticated (even anonymously)
- Check Firestore rules are deployed:
  ```bash
  firebase deploy --only firestore:rules
  ```
- Verify `user_id` matches authenticated user's UID

#### Issue: Index required

**Solution:**
- Click the link in the error message to auto-create index
- Or manually create in Firebase Console → Firestore → Indexes

---

## Feature Checklist

Use this checklist to verify everything is working:

### Authentication
- [ ] Guest sign-in works
- [ ] Guest can use all features
- [ ] Guest → Email account linking works
- [ ] Guest → Google account linking works
- [ ] Guest → Apple account linking works
- [ ] Guest data is preserved after linking

### Collection
- [ ] Can add items to collection
- [ ] Can view items in list/grid/checklist mode
- [ ] Can search collection
- [ ] Can favorite items
- [ ] Can delete items
- [ ] Categories work (Morning, Evening, Friday, Ramadhan)
- [ ] Tags and notes are saved

### Reminders
- [ ] Can create time-based reminders
- [ ] Can create prayer-based reminders
- [ ] Can create date-based reminders
- [ ] Can create recurring reminders
- [ ] Reminders trigger on time
- [ ] Push notifications are received

### Habit Tracking
- [ ] Can enable habit tracking on items
- [ ] Can mark habits as complete
- [ ] Streaks are calculated correctly
- [ ] Completion history is saved
- [ ] Statistics are accurate

### Push Notifications
- [ ] Foreground notifications work
- [ ] Background notifications work
- [ ] Tapping notification navigates to collection
- [ ] Notification content is correct (with hadith/verse)

### Upgrade Prompts
- [ ] "Sign Up" button appears for guests
- [ ] Upgrade dialog shows personalized message
- [ ] Guest stats are calculated correctly
- [ ] Upgrade prompt appears at right time (3+ days or 10+ items)

---

## Next Steps

After setup is complete:

1. **Customize upgrade prompts** in `lib/services/guest_access_service.dart`
   - Adjust thresholds for when to show prompts
   - Customize messages based on your app's voice

2. **Add more categories** in `lib/models/collection/collection_item.dart`
   - Add custom Islamic occasions
   - Add seasonal categories

3. **Enhance notifications**
   - Add more inspirational content to notifications
   - Customize notification sounds
   - Add notification actions (mark as done, snooze)

4. **Analytics**
   - Track conversion rates (guest → account)
   - Monitor reminder engagement
   - Measure feature usage

5. **Advanced features**
   - Collection sharing
   - Import/export functionality
   - Social features (community du'as)
   - Audio recitations

---

## Need Help?

If you encounter issues not covered in this guide:

1. **Check logs:**
   - Flutter: `flutter logs`
   - Cloud Functions: Firebase Console → Functions → Logs
   - Firestore: Firebase Console → Firestore → Usage tab

2. **Common resources:**
   - [Firebase Documentation](https://firebase.google.com/docs)
   - [FlutterFire Documentation](https://firebase.flutter.dev/)
   - [Cloud Functions Documentation](https://firebase.google.com/docs/functions)

3. **Debug mode:**
   - Enable verbose logging in NotificationService
   - Add debug prints in Cloud Functions
   - Use Firebase Emulator Suite for local testing

---

## Summary

You've successfully set up:
- ✅ Firebase Anonymous Authentication (guest access)
- ✅ My Collection feature (user's personal library)
- ✅ Reminders with multiple trigger types
- ✅ Push notifications with FCM
- ✅ Habit tracking with streaks
- ✅ Cloud Functions for automated reminder processing
- ✅ Firestore security rules
- ✅ Account linking (guest → permanent account)
- ✅ Upgrade prompts for guest users

Your users can now:
1. Try the app instantly as guests
2. Build their personal Islamic library
3. Set up intelligent reminders
4. Track their spiritual habits
5. Seamlessly upgrade to permanent accounts
6. Sync across all devices

May your app benefit many on their spiritual journey! 🌙
