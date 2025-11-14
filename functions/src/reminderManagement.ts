import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {Reminder, PrayerTimeOption} from "./types";
import {sendNotification} from "./notificationService";

const db = admin.firestore();

/**
 * Scheduled function to process reminders every 5 minutes
 * Checks for reminders that need to be triggered and sends notifications
 */
export const processReminders = functions.pubsub
  .schedule("every 5 minutes")
  .onRun(async (context) => {
    console.log("Processing reminders...");

    try {
      const now = admin.firestore.Timestamp.now();

      // Query reminders that need to be triggered
      const remindersSnapshot = await db
        .collection("reminders")
        .where("is_enabled", "==", true)
        .where("next_trigger", "<=", now)
        .limit(100) // Process 100 reminders at a time
        .get();

      console.log(`Found ${remindersSnapshot.size} reminders to process`);

      const batch = db.batch();
      const notifications: Array<Promise<void>> = [];

      for (const doc of remindersSnapshot.docs) {
        const reminder = doc.data() as Reminder;
        reminder.id = doc.id;

        // Send notification
        notifications.push(sendReminderNotification(reminder));

        // Calculate next trigger
        const nextTrigger = calculateNextTrigger(reminder);

        // Update reminder
        const updates: any = {
          last_triggered: now,
          total_triggers: admin.firestore.FieldValue.increment(1),
        };

        if (nextTrigger) {
          updates.next_trigger = nextTrigger;
        } else if (reminder.frequency === "once") {
          // Disable one-time reminders after triggering
          updates.is_enabled = false;
          updates.next_trigger = admin.firestore.FieldValue.delete();
        }

        batch.update(doc.ref, updates);
      }

      // Commit batch update
      await batch.commit();

      // Send all notifications
      await Promise.allSettled(notifications);

      console.log(
        `Successfully processed ${remindersSnapshot.size} reminders`
      );
      return null;
    } catch (error) {
      console.error("Error processing reminders:", error);
      throw error;
    }
  });

/**
 * Scheduled function to calculate prayer-based reminders
 * Runs every hour to check and schedule prayer time reminders
 */
export const processPrayerReminders = functions.pubsub
  .schedule("every 1 hours")
  .onRun(async (context) => {
    console.log("Processing prayer time reminders...");

    try {
      // Get all prayer-based reminders
      const remindersSnapshot = await db
        .collection("reminders")
        .where("is_enabled", "==", true)
        .where("trigger_type", "==", "prayerTime")
        .get();

      console.log(
        `Found ${remindersSnapshot.size} prayer reminders to update`
      );

      const batch = db.batch();

      for (const doc of remindersSnapshot.docs) {
        const reminder = doc.data() as Reminder;

        // Calculate next prayer time trigger
        // Note: This requires user's location (stored in user profile)
        const nextTrigger = await calculatePrayerTimeTrigger(reminder);

        if (nextTrigger) {
          batch.update(doc.ref, {
            next_trigger: nextTrigger,
            updated_at: admin.firestore.Timestamp.now(),
          });
        }
      }

      await batch.commit();

      console.log("Successfully updated prayer time reminders");
      return null;
    } catch (error) {
      console.error("Error processing prayer reminders:", error);
      throw error;
    }
  });

/**
 * Firestore trigger when a reminder is created or updated
 * Automatically calculates the next trigger time
 */
export const onReminderWrite = functions.firestore
  .document("reminders/{reminderId}")
  .onWrite(async (change, context) => {
    // Skip if reminder is deleted
    if (!change.after.exists) {
      return null;
    }

    const reminder = change.after.data() as Reminder;
    reminder.id = context.params.reminderId;

    // Skip if next_trigger is already set and not changed
    const before = change.before.data();
    if (
      before &&
      before.next_trigger &&
      !hasScheduleChanged(before as Reminder, reminder)
    ) {
      return null;
    }

    // Calculate next trigger
    const nextTrigger = reminder.trigger_type === "prayerTime" ?
      await calculatePrayerTimeTrigger(reminder) :
      calculateNextTrigger(reminder);

    if (nextTrigger) {
      await change.after.ref.update({
        next_trigger: nextTrigger,
        updated_at: admin.firestore.Timestamp.now(),
      });
    }

    return null;
  });

/**
 * Send notification for a reminder
 */
async function sendReminderNotification(reminder: Reminder): Promise<void> {
  try {
    // Get collection item details
    const itemDoc = await db
      .collection("collection_items")
      .doc(reminder.collection_item_id)
      .get();

    if (!itemDoc.exists) {
      console.warn(
        `Collection item ${reminder.collection_item_id} not found`
      );
      return;
    }

    const item = itemDoc.data();
    const title = reminder.title;
    let body = reminder.message || item?.title || "Time for your reminder";

    // Add inspirational text if available
    if (reminder.inspirational_text) {
      body += `\n\n${reminder.inspirational_text}`;
    }

    await sendNotification({
      userId: reminder.user_id,
      title,
      body,
      data: {
        type: "reminder",
        reminderId: reminder.id,
        collectionItemId: reminder.collection_item_id,
      },
      sound: reminder.sound_enabled ? "default" : undefined,
    });

    console.log(`Sent notification for reminder ${reminder.id}`);
  } catch (error) {
    console.error(`Error sending reminder notification:`, error);
  }
}

/**
 * Calculate the next trigger time for a reminder
 */
function calculateNextTrigger(
  reminder: Reminder
): admin.firestore.Timestamp | null {
  const now = new Date();

  switch (reminder.trigger_type) {
    case "time":
      return calculateTimeTrigger(reminder, now);

    case "date":
      return calculateDateTrigger(reminder, now);

    case "dayOfWeek":
      return calculateDayOfWeekTrigger(reminder, now);

    case "islamicDate":
      return calculateIslamicDateTrigger(reminder, now);

    default:
      return null;
  }
}

/**
 * Calculate trigger for time-based reminders
 */
function calculateTimeTrigger(
  reminder: Reminder,
  now: Date
): admin.firestore.Timestamp | null {
  if (!reminder.trigger_time) return null;

  const [hours, minutes] = reminder.trigger_time.split(":").map(Number);
  const trigger = new Date(now);
  trigger.setHours(hours, minutes, 0, 0);

  // If the time has passed today, schedule for tomorrow (or next occurrence)
  if (trigger <= now) {
    switch (reminder.frequency) {
      case "once":
        return null; // One-time reminders don't repeat

      case "daily":
        trigger.setDate(trigger.getDate() + 1);
        break;

      case "weekly":
        trigger.setDate(trigger.getDate() + 7);
        break;

      case "monthly":
        trigger.setMonth(trigger.getMonth() + 1);
        break;

      default:
        return null;
    }
  }

  return admin.firestore.Timestamp.fromDate(trigger);
}

/**
 * Calculate trigger for date-based reminders
 */
function calculateDateTrigger(
  reminder: Reminder,
  now: Date
): admin.firestore.Timestamp | null {
  if (!reminder.trigger_date) return null;

  const triggerDate = reminder.trigger_date.toDate();

  // If date has passed
  if (triggerDate <= now) {
    if (reminder.frequency === "once") {
      return null;
    }

    // For recurring reminders, calculate next occurrence
    const next = new Date(triggerDate);
    switch (reminder.frequency) {
      case "daily":
        while (next <= now) {
          next.setDate(next.getDate() + 1);
        }
        break;

      case "weekly":
        while (next <= now) {
          next.setDate(next.getDate() + 7);
        }
        break;

      case "monthly":
        while (next <= now) {
          next.setMonth(next.getMonth() + 1);
        }
        break;

      default:
        return null;
    }

    return admin.firestore.Timestamp.fromDate(next);
  }

  return reminder.trigger_date;
}

/**
 * Calculate trigger for day-of-week reminders
 */
function calculateDayOfWeekTrigger(
  reminder: Reminder,
  now: Date
): admin.firestore.Timestamp | null {
  if (!reminder.days_of_week || reminder.days_of_week.length === 0) {
    return null;
  }
  if (!reminder.trigger_time) return null;

  const [hours, minutes] = reminder.trigger_time.split(":").map(Number);
  const dayMap: {[key: string]: number} = {
    sunday: 0,
    monday: 1,
    tuesday: 2,
    wednesday: 3,
    thursday: 4,
    friday: 5,
    saturday: 6,
  };

  const targetDays = reminder.days_of_week
    .map((day) => dayMap[day])
    .sort((a, b) => a - b);

  const trigger = new Date(now);
  trigger.setHours(hours, minutes, 0, 0);

  const currentDay = now.getDay();

  // Find next matching day
  let daysToAdd = 0;
  let found = false;

  for (const targetDay of targetDays) {
    if (targetDay > currentDay) {
      daysToAdd = targetDay - currentDay;
      found = true;
      break;
    } else if (targetDay === currentDay && trigger > now) {
      daysToAdd = 0;
      found = true;
      break;
    }
  }

  if (!found) {
    // Wrap to next week
    daysToAdd = 7 - currentDay + targetDays[0];
  }

  trigger.setDate(trigger.getDate() + daysToAdd);
  return admin.firestore.Timestamp.fromDate(trigger);
}

/**
 * Calculate trigger for Islamic date reminders
 */
function calculateIslamicDateTrigger(
  reminder: Reminder,
  now: Date
): admin.firestore.Timestamp | null {
  if (!reminder.hijri_month || !reminder.hijri_day) return null;

  // This is a simplified calculation
  // In production, you should use a proper Hijri calendar library
  // For now, we'll schedule it approximately 354 days from now (Islamic year)

  const next = new Date(now);

  if (reminder.frequency === "once") {
    // Set to next occurrence of this Islamic date
    // This requires proper Hijri-to-Gregorian conversion
    next.setDate(next.getDate() + 30); // Placeholder
  } else {
    // Recurring annual Islamic date
    next.setDate(next.getDate() + 354); // Islamic year length
  }

  return admin.firestore.Timestamp.fromDate(next);
}

/**
 * Calculate trigger for prayer-time based reminders
 */
async function calculatePrayerTimeTrigger(
  reminder: Reminder
): Promise<admin.firestore.Timestamp | null> {
  if (!reminder.prayer_time) return null;

  try {
    // Get user's location from profile
    const userDoc = await db.collection("users").doc(reminder.user_id).get();

    if (!userDoc.exists) {
      console.warn(`User ${reminder.user_id} not found`);
      return null;
    }

    const userData = userDoc.data();
    const location = userData?.location;

    if (!location || !location.latitude || !location.longitude) {
      console.warn(
        `Location not found for user ${reminder.user_id}`
      );
      return null;
    }

    // Calculate prayer times for the location
    // This requires the adhan library which would need to be added to package.json
    // For now, we'll use placeholder times
    const prayerTimes = getPrayerTimesForLocation(
      location.latitude,
      location.longitude
    );

    const prayerTime = prayerTimes[reminder.prayer_time];
    if (!prayerTime) return null;

    // Apply offset (minutes before/after)
    const offset =
      reminder.minutes_before_prayer > 0 ?
        -reminder.minutes_before_prayer :
        reminder.minutes_after_prayer;

    prayerTime.setMinutes(prayerTime.getMinutes() + offset);

    // If time has passed, calculate for tomorrow
    const now = new Date();
    if (prayerTime <= now) {
      prayerTime.setDate(prayerTime.getDate() + 1);
      // Recalculate prayer times for tomorrow
      const tomorrowPrayers = getPrayerTimesForLocation(
        location.latitude,
        location.longitude,
        prayerTime
      );
      const nextPrayer = tomorrowPrayers[reminder.prayer_time];
      if (nextPrayer) {
        nextPrayer.setMinutes(nextPrayer.getMinutes() + offset);
        return admin.firestore.Timestamp.fromDate(nextPrayer);
      }
    }

    return admin.firestore.Timestamp.fromDate(prayerTime);
  } catch (error) {
    console.error("Error calculating prayer time trigger:", error);
    return null;
  }
}

/**
 * Get prayer times for a location
 * This is a placeholder - in production, use a proper prayer times library
 */
function getPrayerTimesForLocation(
  latitude: number,
  longitude: number,
  date: Date = new Date()
): {[key in PrayerTimeOption]: Date} {
  // Placeholder times - in production, use the adhan package
  const today = new Date(date);
  return {
    fajr: new Date(today.setHours(5, 30, 0, 0)),
    sunrise: new Date(today.setHours(6, 45, 0, 0)),
    dhuhr: new Date(today.setHours(12, 30, 0, 0)),
    asr: new Date(today.setHours(15, 45, 0, 0)),
    maghrib: new Date(today.setHours(18, 30, 0, 0)),
    isha: new Date(today.setHours(20, 0, 0, 0)),
  };
}

/**
 * Check if reminder schedule has changed
 */
function hasScheduleChanged(before: Reminder, after: Reminder): boolean {
  return (
    before.trigger_type !== after.trigger_type ||
    before.frequency !== after.frequency ||
    before.trigger_time !== after.trigger_time ||
    before.trigger_date?.toMillis() !== after.trigger_date?.toMillis() ||
    JSON.stringify(before.days_of_week) !==
      JSON.stringify(after.days_of_week) ||
    before.prayer_time !== after.prayer_time ||
    before.minutes_before_prayer !== after.minutes_before_prayer ||
    before.minutes_after_prayer !== after.minutes_after_prayer ||
    before.hijri_month !== after.hijri_month ||
    before.hijri_day !== after.hijri_day
  );
}
