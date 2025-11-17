# My Collection Feature - Implementation Guide

## Overview
This document provides implementation details for the "My Collection" (User's Personal Library) feature in the Path of Light app.

## ✅ Completed Features

### 1. Data Models (`lib/models/collection/`)

#### Collection Item Model (`collection_item.dart`)
- **Purpose**: Represents a spiritual content item in the user's collection
- **Types Supported**: Du'as, Surahs, Ayahs, Ziyarats, Hadiths, Passages, Dhikr, Custom
- **Categories**: Morning, Evening, Friday, Ramadhan, Muharram, Safar, Rajab, Sha'ban, Daily, Weekly, Monthly, Special, Protection, Forgiveness, Gratitude, Healing, Guidance, Custom
- **Features**:
  - Bilingual support (Arabic & English)
  - Audio URL support
  - Favorites marking
  - Tags and notes
  - Source references
  - Last accessed tracking

#### Reminder Model (`reminder.dart`)
- **Purpose**: Schedule reminders for collection items
- **Trigger Types**:
  - Specific time of day
  - Prayer times (Fajr, Sunrise, Dhuhr, Asr, Maghrib, Isha)
  - Specific dates
  - Days of the week
  - Islamic calendar dates
- **Frequency**: Once, Daily, Weekly, Monthly, Custom
- **Features**:
  - Minutes before/after prayer time
  - Recurring reminders
  - Inspirational text (hadith or verse)
  - Sound and vibration settings
  - Next trigger calculation

#### Habit Tracker Model (`habit_tracker.dart`)
- **Purpose**: Track spiritual habits and daily practices
- **Features**:
  - Target count and current progress
  - Streak tracking (current and longest)
  - Completion history
  - Progress statistics (daily, weekly, monthly)
  - Completion rate calculation
  - Performance levels

### 2. Data Repository (`lib/repositories/collection_repository.dart`)

#### Collection Items Operations
- `getUserCollectionItems()` - Get all items for current user
- `getCollectionItemsByCategory(category)` - Filter by category
- `getCollectionItemsByType(type)` - Filter by type
- `getFavoriteCollectionItems()` - Get favorites only
- `getRecentlyAccessedItems(limit)` - Recently viewed items
- `searchCollectionItems(query)` - Full-text search
- `addCollectionItem(item)` - Add new item
- `updateCollectionItem(item)` - Update existing item
- `deleteCollectionItem(itemId)` - Delete item
- `toggleFavorite(itemId, isFavorite)` - Toggle favorite status
- `updateLastAccessed(itemId)` - Track access time
- `updateSortOrder(itemId, sortOrder)` - Custom ordering

#### Reminders Operations
- `getRemindersForItem(collectionItemId)` - Get item reminders
- `getActiveReminders()` - All active reminders
- `addReminder(reminder)` - Create reminder
- `updateReminder(reminder)` - Update reminder
- `deleteReminder(reminderId)` - Delete reminder
- `toggleReminderEnabled(reminderId, isEnabled)` - Enable/disable

#### Habit Trackers Operations
- `getHabitTrackerForItem(collectionItemId)` - Get habit tracker
- `getAllHabitTrackers()` - All user's habits
- `addHabitTracker(tracker)` - Create habit
- `updateHabitTracker(tracker)` - Update habit
- `incrementHabitCount(trackerId)` - Mark as done
- `deleteHabitTracker(trackerId)` - Delete habit

#### Checklist Operations
- `getChecklistItemsForDate(date)` - Daily checklist
- `addChecklistItem(item)` - Add to checklist
- `toggleChecklistItemCompletion(itemId, isCompleted)` - Mark done
- `deleteChecklistItem(itemId)` - Remove from checklist
- `getCompletionStats(startDate, endDate)` - Statistics

### 3. State Management (`lib/providers/collection_providers.dart`)

#### Collection Providers
- `userCollectionItemsProvider` - All user items
- `collectionItemsByCategoryProvider` - Filtered by category
- `collectionItemsByTypeProvider` - Filtered by type
- `favoriteCollectionItemsProvider` - Favorites only
- `recentlyAccessedItemsProvider` - Recently viewed
- `searchCollectionItemsProvider` - Search results

#### Reminder Providers
- `remindersForItemProvider` - Item-specific reminders
- `activeRemindersProvider` - All active reminders
- Action providers for add, update, delete, toggle

#### Habit Tracker Providers
- `habitTrackerForItemProvider` - Item-specific tracker
- `allHabitTrackersProvider` - All trackers
- Action providers for CRUD operations
- `incrementHabitCountProvider` - Mark as done

#### Checklist Providers
- `todayChecklistItemsProvider` - Today's checklist
- `checklistItemsForDateProvider` - Date-specific checklist
- Action providers for add, toggle, delete

#### Statistics Providers
- `completionStatsProvider` - Custom date range
- `todayCompletionStatsProvider` - Today's stats
- `weekCompletionStatsProvider` - This week
- `monthCompletionStatsProvider` - This month

#### UI State Providers
- `selectedCategoryProvider` - Current category filter
- `selectedTypeProvider` - Current type filter
- `collectionSearchQueryProvider` - Search query
- `collectionViewModeProvider` - View mode (list, grid, checklist)
- `collectionSortOrderProvider` - Sort preference
- `showCompletedItemsProvider` - Show/hide completed
- `selectedChecklistDateProvider` - Checklist date

### 4. UI Components

#### Main Screen (`lib/screens/home/collection_screen.dart`)
- **Features**:
  - Tab navigation (All, Favorites, Morning, Evening, Friday, Ramadhan)
  - View mode toggle (List, Grid, Checklist)
  - Search functionality
  - Pull-to-refresh
  - Empty states
  - Add button (FAB)
- **Views**:
  - List view with cards
  - Grid view (2 columns)
  - Checklist view with progress

#### Collection Item Card (`lib/widgets/collection/collection_item_card.dart`)
- **List Card Features**:
  - Swipe actions (favorite, delete)
  - Type icon with color coding
  - Category badge
  - Arabic text preview
  - Tags display
  - Source reference
  - Favorite star button
- **Grid Card Features**:
  - Compact layout
  - Type icon
  - Category badge
  - Arabic text preview
  - Favorite button

#### Add to Collection Dialog (`lib/widgets/collection/add_to_collection_dialog.dart`)
- **Form Fields**:
  - Type selection dropdown
  - Category selection dropdown
  - Title (English)
  - Title (Arabic)
  - Arabic text (required)
  - Translation
  - Transliteration
  - Source
  - Personal notes
  - Tags (comma-separated)
- **Features**:
  - Form validation
  - Loading state
  - Error handling
  - Success feedback

#### Checklist View Widget (`lib/widgets/collection/checklist_view_widget.dart`)
- **Components**:
  - Progress header with circular indicator
  - Linear progress bar
  - Completion percentage
  - Checklist items with checkboxes
  - Empty state
- **Features**:
  - Real-time completion tracking
  - Visual progress indicators
  - Strike-through completed items

### 5. Dependencies Added

```yaml
dependencies:
  firebase_messaging: ^14.7.10  # For push notifications
  flutter_slidable: ^3.0.1      # For swipe actions
```

## 🚧 Pending Implementation

### 1. Build Generated Files
Run this command to generate freezed and json_serializable files:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 2. Firebase Cloud Functions (Backend)
Location: `functions/src/`

#### Reminder Scheduling Function
```typescript
// Schedule reminders based on trigger type
export const scheduleReminders = functions.pubsub
  .schedule('every 5 minutes')
  .onRun(async (context) => {
    // 1. Get all active reminders with nextTrigger <= now
    // 2. For each reminder:
    //    - Send push notification
    //    - Update lastTriggered
    //    - Calculate and update nextTrigger
    // 3. Handle recurring vs one-time reminders
  });

// Prayer time reminders
export const schedulePrayerReminders = functions.pubsub
  .schedule('every 1 hours')
  .onRun(async (context) => {
    // 1. Get all prayer-based reminders
    // 2. For each user:
    //    - Calculate prayer times based on location
    //    - Schedule notifications
  });

// Update next trigger when reminder is modified
export const updateReminderTrigger = functions.firestore
  .document('reminders/{reminderId}')
  .onWrite(async (change, context) => {
    // Calculate next trigger based on trigger type and frequency
  });
```

### 3. Push Notifications Service
Location: `lib/services/notification_service.dart`

```dart
class NotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  // Initialize notifications
  Future<void> initialize() async {
    // Request permissions
    // Get FCM token
    // Save token to Firestore
    // Handle foreground messages
    // Handle background messages
    // Handle notification taps
  }

  // Show local notification
  Future<void> showLocalNotification({
    required String title,
    required String body,
    String? inspirationalText,
  }) async {
    // Display notification with custom layout
    // Include inspirational hadith/verse if provided
  }

  // Schedule local notification
  Future<void> scheduleLocalNotification({
    required DateTime scheduledDate,
    required String title,
    required String body,
  }) async {
    // Use flutter_local_notifications package
  }
}
```

### 4. Reminder Settings Dialog
Location: `lib/widgets/collection/reminder_settings_dialog.dart`

**Features to implement**:
- Trigger type selection (time, prayer, date, day of week, Islamic date)
- Time picker for specific time
- Prayer selection with before/after minutes
- Date picker for one-time reminders
- Day of week multi-select
- Islamic calendar date picker
- Frequency selection
- Inspirational text input
- Sound/vibration toggles
- Preview of next trigger time

### 5. Additional UI Screens

#### Item Details Screen
- Full content display
- Edit button
- Delete button
- Set reminder button
- Add to checklist button
- Share functionality
- Audio playback (if available)
- Related items

#### Reminder Management Screen
- List of all reminders
- Edit reminder
- Delete reminder
- Enable/disable toggle
- Sort by next trigger
- Filter by type

#### Habit Progress Screen
- Streak visualization
- Calendar heatmap
- Progress charts
- Completion history
- Performance insights
- Motivational messages

### 6. Firebase Configuration

#### Android Configuration
1. Update `android/app/build.gradle`:
```gradle
dependencies {
    implementation 'com.google.firebase:firebase-messaging:23.0.0'
}
```

2. Add to `android/app/src/main/AndroidManifest.xml`:
```xml
<service
    android:name="io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingService"
    android:exported="false">
    <intent-filter>
        <action android:name="com.google.firebase.MESSAGING_EVENT" />
    </intent-filter>
</service>
```

#### iOS Configuration
1. Enable Push Notifications in Xcode
2. Add to `ios/Runner/Info.plist`:
```xml
<key>UIBackgroundModes</key>
<array>
    <string>fetch</string>
    <string>remote-notification</string>
</array>
```

## 📊 Firestore Data Structure

### Collection: `collection_items`
```javascript
{
  id: string,
  user_id: string,
  type: string, // dua, surah, ayah, ziyarat, hadith, passage, dhikr, custom
  title: string,
  arabic_title: string?,
  arabic_text: string,
  translation: string?,
  transliteration: string?,
  category: string,
  source: string?,
  notes: string?,
  tags: string[],
  audio_url: string?,
  is_favorite: boolean,
  sort_order: number,
  created_at: timestamp,
  updated_at: timestamp,
  last_accessed: timestamp?
}
```

### Collection: `reminders`
```javascript
{
  id: string,
  user_id: string,
  collection_item_id: string,
  title: string,
  message: string?,
  inspirational_text: string?,
  trigger_type: string,
  frequency: string,
  trigger_time: string?,
  trigger_date: timestamp?,
  days_of_week: string[],
  prayer_time: string?,
  minutes_before_prayer: number,
  minutes_after_prayer: number,
  hijri_month: number?,
  hijri_day: number?,
  is_enabled: boolean,
  sound_enabled: boolean,
  vibration_enabled: boolean,
  last_triggered: timestamp?,
  next_trigger: timestamp?,
  total_triggers: number,
  created_at: timestamp,
  updated_at: timestamp
}
```

### Collection: `habit_trackers`
```javascript
{
  id: string,
  user_id: string,
  collection_item_id: string,
  title: string,
  arabic_title: string?,
  description: string?,
  target_count: number,
  current_count: number,
  tracking_period: string, // daily, weekly, monthly
  is_completed_today: boolean,
  last_completed_date: string,
  completion_history: string[],
  current_streak: number,
  longest_streak: number,
  total_completions: number,
  completion_rate: number,
  weekly_completions: number,
  monthly_completions: number,
  created_at: timestamp,
  updated_at: timestamp
}
```

### Collection: `checklist_items`
```javascript
{
  id: string,
  user_id: string,
  collection_item_id: string?,
  title: string,
  arabic_title: string?,
  description: string?,
  is_completed: boolean,
  completed_at: timestamp?,
  sort_order: number,
  checklist_date: string, // YYYY-MM-DD
  created_at: timestamp
}
```

## 🔐 Security Rules

Add to `firestore.rules`:
```javascript
// Collection Items
match /collection_items/{itemId} {
  allow read, write: if request.auth != null
    && request.auth.uid == resource.data.user_id;
  allow create: if request.auth != null
    && request.auth.uid == request.resource.data.user_id;
}

// Reminders
match /reminders/{reminderId} {
  allow read, write: if request.auth != null
    && request.auth.uid == resource.data.user_id;
  allow create: if request.auth != null
    && request.auth.uid == request.resource.data.user_id;
}

// Habit Trackers
match /habit_trackers/{trackerId} {
  allow read, write: if request.auth != null
    && request.auth.uid == resource.data.user_id;
  allow create: if request.auth != null
    && request.auth.uid == request.resource.data.user_id;
}

// Checklist Items
match /checklist_items/{itemId} {
  allow read, write: if request.auth != null
    && request.auth.uid == resource.data.user_id;
  allow create: if request.auth != null
    && request.auth.uid == request.resource.data.user_id;
}
```

## 🧪 Testing Checklist

### Unit Tests
- [ ] Collection item model serialization
- [ ] Reminder model serialization
- [ ] Habit tracker model serialization
- [ ] Extension methods

### Integration Tests
- [ ] Add collection item to Firestore
- [ ] Retrieve user collection items
- [ ] Update collection item
- [ ] Delete collection item
- [ ] Search functionality
- [ ] Reminder CRUD operations
- [ ] Habit tracker CRUD operations
- [ ] Checklist CRUD operations

### Widget Tests
- [ ] Collection screen rendering
- [ ] View mode switching
- [ ] Add dialog validation
- [ ] Collection item card display
- [ ] Checklist view completion
- [ ] Search functionality

### E2E Tests
- [ ] User authentication flow
- [ ] Add item to collection
- [ ] Mark item as favorite
- [ ] Create reminder
- [ ] Complete habit
- [ ] Check off checklist item
- [ ] Cloud sync verification

## 📱 Platform Support

### Tested Platforms
- [ ] Android
- [ ] iOS
- [ ] Web
- [ ] Windows
- [ ] macOS
- [ ] Linux

## 🎯 Future Enhancements

1. **Audio Recitation**
   - Record personal recitations
   - Play audio for du'as and surahs
   - Download for offline use

2. **Social Features**
   - Share collection items
   - Community collections
   - Recommended items

3. **Advanced Analytics**
   - Completion trends
   - Best performing habits
   - Insights and recommendations

4. **Widgets**
   - Home screen widget for daily checklist
   - Lock screen widget for quick access

5. **Backup & Restore**
   - Export collection to JSON
   - Import from backup
   - Cross-device sync

6. **Accessibility**
   - Screen reader support
   - Font size controls
   - High contrast mode

## 📝 Notes

- All text fields support both Arabic (RTL) and English (LTR)
- Firestore indexes may need to be created for complex queries
- Consider implementing pagination for large collections
- Use cloud sync to ensure data is backed up
- Authentication is handled by existing Firebase Auth setup
- All CRUD operations invalidate relevant providers for real-time updates

## 🔄 Next Steps

1. Run `flutter pub get` to install new dependencies
2. Run `flutter pub run build_runner build --delete-conflicting-outputs`
3. Implement Firebase Cloud Functions for reminders
4. Set up Firebase Cloud Messaging
5. Create Firestore security rules
6. Test on all platforms
7. Deploy Cloud Functions
8. Test notifications end-to-end
