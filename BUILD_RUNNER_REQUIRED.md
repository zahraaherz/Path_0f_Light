# Build Runner Required

## Important: Code Generation Needed

This project uses `freezed` for immutable data classes. After pulling this branch, you **MUST** run the code generation command to generate the required `.freezed.dart` and `.g.dart` files.

### Commands to Run:

```bash
# Clean previous build artifacts (optional but recommended)
flutter clean

# Get dependencies
flutter pub get

# Run code generation
flutter pub run build_runner build --delete-conflicting-outputs
```

### New Models Added:

The following models require code generation:

1. **Prayer Times** (`lib/models/prayer/prayer_times.dart`)
   - `PrayerTime`
   - `DailyPrayerTimes`

2. **Islamic Events** (`lib/models/islamic_events/islamic_event.dart`)
   - `IslamicEvent`
   - `HijriDate`

3. **Du'a Models** (`lib/models/dua/dua_model.dart`)
   - `Dua`
   - `AudioRecitation`
   - `SpiritualChecklistItem`

### Expected Generated Files:

After running the build_runner command, you should see:
- `lib/models/prayer/prayer_times.freezed.dart`
- `lib/models/prayer/prayer_times.g.dart`
- `lib/models/islamic_events/islamic_event.freezed.dart`
- `lib/models/islamic_events/islamic_event.g.dart`
- `lib/models/dua/dua_model.freezed.dart`
- `lib/models/dua/dua_model.g.dart`

### If You Encounter Errors:

1. Make sure you have the latest version of build_runner:
   ```bash
   flutter pub upgrade build_runner
   ```

2. If you see conflicts, use the `--delete-conflicting-outputs` flag:
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

3. If issues persist, try a clean rebuild:
   ```bash
   flutter clean
   flutter pub get
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

## New Features in This Update:

✅ Prayer Times with live countdown
✅ Hijri & Gregorian Date Display
✅ Islamic Events Calendar
✅ Daily Du'a Slider with full details
✅ Spiritual Checklist (interactive)
✅ Audio Library for recitations
✅ All features with bilingual support (Arabic + English)
