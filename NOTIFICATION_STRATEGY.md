# Notification Strategy - Path of Light

## Overview

Path of Light uses a **HYBRID notification approach** combining **Local Notifications** and **FCM Push Notifications** to provide the best user experience while optimizing costs and reliability.

## Architecture

### 🔔 Local Notifications (On-Device)

**What:** Scheduled notifications that run entirely on the user's device using `flutter_local_notifications`.

**Used For:**
- ✅ **Prayer time reminders** (5 daily prayers)
- ✅ **Collection reminders** (du'as, dhikr, ziyarats)
- ✅ **Daily/weekly/monthly recurring reminders**
- ✅ **User-scheduled notifications**

**Benefits:**
- ⚡ Works completely offline
- 🎯 Precise timing (down to the second)
- 🔋 Better battery life (no server polling)
- 💰 Lower Firebase costs (no Cloud Functions running every 5 minutes)
- 📱 Instant scheduling (no latency)

**Implementation:**
- **Frontend:** `lib/services/notification_service.dart`
- **Methods:** `scheduleCollectionReminder()`, `schedulePrayerTimeNotification()`, `scheduleDailyPrayerNotifications()`

### 📨 FCM Push Notifications (Backend-Triggered)

**What:** Server-initiated notifications sent via Firebase Cloud Messaging.

**Used For:**
- 📢 **Admin announcements** (new features, maintenance)
- 🎉 **Special Islamic events** (Ramadan, Eid, Ashura)
- 👥 **Community notifications** (challenges, leaderboard updates)
- 🔄 **Cross-device sync** (backup notifications)
- 🚨 **Important updates** requiring immediate delivery

**Benefits:**
- 🌐 Centralized control from admin dashboard
- 📲 Cross-device notification delivery
- 🔄 Can update notification logic without app updates
- 🎯 Targeted audience (all users, premium only, specific segments)

**Implementation:**
- **Backend:** `functions/src/notificationService.ts`, `functions/src/reminderManagement.ts`
- **Functions:** `sendAdminAnnouncement()`, `processReminders()`, `processPrayerReminders()`

---

## How It Works

### Local Notifications Flow

```
User enables reminder in app
    ↓
Calculate exact trigger time (using adhan library for prayer times)
    ↓
Schedule local notification on device (timezone-aware)
    ↓
OS handles notification delivery (even when app is closed)
    ↓
User taps notification → Navigate to relevant screen
```

**Prayer Time Example:**
```dart
// Schedule all 5 daily prayers
await notificationService.scheduleDailyPrayerNotifications(
  fajr: DateTime(2025, 11, 15, 5, 30),
  dhuhr: DateTime(2025, 11, 15, 12, 30),
  asr: DateTime(2025, 11, 15, 15, 45),
  maghrib: DateTime(2025, 11, 15, 18, 30),
  isha: DateTime(2025, 11, 15, 20, 00),
  minutesBefore: 10, // Notify 10 minutes before each prayer
);
```

### FCM Push Notifications Flow

```
Admin creates announcement in dashboard
    ↓
Backend function validates admin role
    ↓
Query all/targeted user FCM tokens from Firestore
    ↓
Send notification via Firebase Cloud Messaging
    ↓
FCM delivers to all user devices
    ↓
App handles foreground/background notification
```

**Admin Announcement Example:**
```typescript
// Backend function call
const result = await functions.httpsCallable('sendAdminAnnouncement')({
  title: 'Ramadan Mubarak! 🌙',
  body: 'Special Ramadan features are now live',
  targetAudience: 'all', // or 'premium'
  imageUrl: 'https://...',
});
```

---

## Data Model

### Reminder Document (Firestore)

```typescript
{
  id: string;
  user_id: string;
  collection_item_id: string;
  title: string;
  message: string;

  // Notification strategy flag
  use_fcm: boolean; // false = local notification, true = FCM

  // Trigger configuration
  trigger_type: 'time' | 'date' | 'dayOfWeek' | 'prayerTime' | 'islamicDate';
  trigger_time?: string; // "08:30"
  trigger_date?: Timestamp;
  days_of_week?: string[]; // ["monday", "friday"]
  prayer_time?: 'fajr' | 'dhuhr' | 'asr' | 'maghrib' | 'isha';
  minutes_before_prayer?: number;

  // Recurrence
  frequency: 'once' | 'daily' | 'weekly' | 'monthly';
  next_trigger?: Timestamp; // Only for FCM reminders

  // Customization
  sound_enabled: boolean;
  vibration_enabled: boolean;
  inspirational_text?: string;

  // Status
  is_enabled: boolean;
  created_at: Timestamp;
  updated_at: Timestamp;
}
```

### FCM Token Document

```typescript
{
  userId: string;
  token: string; // FCM registration token
  platform: 'android' | 'ios' | 'web';
  createdAt: Timestamp;
  lastUsed: Timestamp;
}
```

---

## Decision Matrix

### When to Use Local Notifications

✅ **Use when:**
- User schedules their own reminder
- Prayer time notifications
- Daily recurring reminders
- Offline functionality is important
- Precise timing is required (±1 minute)

### When to Use FCM

✅ **Use when:**
- Admin sends broadcast announcement
- Special event notification (Ramadan, Eid)
- Community updates (new challenge, leaderboard)
- Notification content changes dynamically
- Need to reach users who reinstalled the app
- Cross-device synchronization needed

---

## Backend Functions

### Reminder Processing (FCM Only)

```typescript
// Runs every 5 minutes
export const processReminders = functions.pubsub
  .schedule("every 5 minutes")
  .onRun(async (context) => {
    // ONLY processes reminders with use_fcm: true
    const remindersSnapshot = await db
      .collection("reminders")
      .where("is_enabled", "==", true)
      .where("use_fcm", "==", true) // Critical filter!
      .where("next_trigger", "<=", now)
      .get();

    // Send FCM notifications
    // ...
  });
```

### Prayer Time Calculation

Both frontend and backend use the **`adhan`** library for accurate prayer times:

**Frontend:**
```dart
import 'package:adhan/adhan.dart';

final coordinates = Coordinates(latitude, longitude);
final params = CalculationMethod.muslim_world_league.getParameters();
final prayerTimes = PrayerTimes.today(coordinates, params);
```

**Backend:**
```typescript
import {Coordinates, CalculationMethod, PrayerTimes} from 'adhan';

const coordinates = new Coordinates(latitude, longitude);
const params = CalculationMethod.MuslimWorldLeague();
const prayerTimes = new PrayerTimes(coordinates, date, params);
```

---

## Setup Guide

### 1. Frontend Setup (Flutter)

**Add packages:**
```yaml
dependencies:
  flutter_local_notifications: ^17.0.0
  timezone: ^0.9.2
  firebase_messaging: ^14.7.10
```

**Initialize in `main.dart`:**
```dart
// Initialize notification service
await NotificationService().initialize();

// Request permissions
await NotificationService().areNotificationsEnabled();
```

### 2. Backend Setup (Firebase Functions)

**Install dependencies:**
```bash
cd functions
npm install
```

**Deploy functions:**
```bash
firebase deploy --only functions
```

### 3. Android Configuration

**`AndroidManifest.xml`:**
```xml
<uses-permission android:name="android.permission.POST_NOTIFICATIONS" />
<uses-permission android:name="android.permission.SCHEDULE_EXACT_ALARM" />
<uses-permission android:name="android.permission.USE_EXACT_ALARM" />

<application>
  <!-- Notification channels -->
  <meta-data
    android:name="com.google.firebase.messaging.default_notification_channel_id"
    android:value="reminders" />
</application>
```

### 4. iOS Configuration

**`Info.plist`:**
```xml
<key>UIBackgroundModes</key>
<array>
  <string>remote-notification</string>
</array>
```

---

## Testing

### Test Local Notifications

```dart
// Test prayer time notification
await NotificationService().schedulePrayerTimeNotification(
  prayerName: 'Fajr',
  prayerTime: DateTime.now().add(Duration(seconds: 10)),
  minutesBefore: 0,
);
```

### Test FCM Notifications

```dart
// Test via Firebase console or backend function
await FirebaseFunctions.instance
  .httpsCallable('sendTestNotification')
  .call();
```

---

## Cost Analysis

### Local Notifications
- **Firebase Cost:** $0 (runs on device)
- **Cloud Functions:** $0 (no functions needed)
- **Total:** **FREE** ✅

### FCM Notifications
- **FCM:** Free (unlimited)
- **Cloud Functions:**
  - `processReminders`: ~8,640 invocations/month (every 5 min) = ~$0.35/month
  - `processPrayerReminders`: ~720 invocations/month (every hour) = ~$0.03/month
- **Firestore Reads:** Depends on user count
- **Total:** **~$0.40/month + storage** 💰

**Savings with Hybrid:** ~90% cost reduction by using local notifications for routine reminders!

---

## Monitoring

### Metrics to Track

**Local Notifications:**
- Scheduled count per user
- Permission grant rate
- Tap-through rate

**FCM:**
- Delivery success rate
- Token invalidation rate
- Announcement reach

### Firestore Collections

```
/reminders/{reminderId}        # All reminders
/fcm_tokens/{tokenId}          # Device tokens
/announcements/{announcementId} # Admin announcements log
/users/{userId}/notification_preferences # User settings
```

---

## Troubleshooting

### Local Notifications Not Appearing

1. ✅ Check notification permissions
2. ✅ Verify timezone initialization
3. ✅ Ensure trigger time is in the future
4. ✅ Check device battery optimization settings

### FCM Not Received

1. ✅ Verify FCM token is registered
2. ✅ Check token is valid (not expired)
3. ✅ Ensure app is not force-stopped (Android)
4. ✅ Verify backend function logs

---

## Future Enhancements

- [ ] User-configurable calculation methods (MWL, Karachi, ISNA)
- [ ] Smart notification timing (avoid late night)
- [ ] Notification history and analytics
- [ ] A/B testing for notification content
- [ ] Quiet hours configuration
- [ ] Notification grouping and channels

---

## References

- **flutter_local_notifications:** https://pub.dev/packages/flutter_local_notifications
- **adhan (Dart):** https://pub.dev/packages/adhan
- **adhan (JS/TS):** https://www.npmjs.com/package/adhan
- **Firebase Cloud Messaging:** https://firebase.google.com/docs/cloud-messaging
- **Firebase Functions:** https://firebase.google.com/docs/functions

---

**Last Updated:** November 2025
**Maintained By:** Development Team
