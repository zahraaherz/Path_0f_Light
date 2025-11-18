import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {
  CollectionItem,
  HabitTracker,
  CollectionItemType,
  CollectionCategory,
} from "./types";
import {sanitizeString, sanitizeText, sanitizeUrl, sanitizeStringArray} from "./inputValidation";
import {checkRateLimit, standardRateLimiter} from "./rateLimiter";

const db = admin.firestore();

/**
 * Collection management configuration
 */
const COLLECTION_CONFIG = {
  MAX_ITEMS_PER_USER: 500,
  MAX_HABIT_TRACKERS: 50,
  CHECKLIST_RETENTION_DAYS: 90,
};

// ============================================================================
// COLLECTION ITEMS MANAGEMENT
// ============================================================================

/**
 * Add a new item to user's collection
 */
export const addCollectionItem = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    // Apply rate limiting
    await checkRateLimit(standardRateLimiter, context);

    const userId = context.auth.uid;
    const {
      type,
      title,
      arabic_title,
      arabic_text,
      translation,
      transliteration,
      category,
      source,
      notes,
      tags = [],
      audio_url,
      is_favorite = false,
    } = data;

    // Validate required fields
    if (!type || !title || !arabic_text || !category) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Missing required fields: type, title, arabic_text, category"
      );
    }

    // Sanitize all user inputs
    const sanitizedTitle = sanitizeString(title, 200);
    const sanitizedArabicTitle = arabic_title ? sanitizeString(arabic_title, 200) : "";
    const sanitizedArabicText = sanitizeText(arabic_text, 10000);
    const sanitizedTranslation = translation ? sanitizeText(translation, 10000) : "";
    const sanitizedTransliteration = transliteration ? sanitizeText(transliteration, 5000) : "";
    const sanitizedCategory = sanitizeString(category, 50);
    const sanitizedSource = source ? sanitizeString(source, 200) : "";
    const sanitizedNotes = notes ? sanitizeText(notes, 5000) : "";
    const sanitizedTags = sanitizeStringArray(tags, 20, 50);
    const sanitizedAudioUrl = audio_url ? sanitizeUrl(audio_url) : "";

    try {
      // Check user's collection size limit
      const userCollectionSnapshot = await db
        .collection("collection_items")
        .where("user_id", "==", userId)
        .count()
        .get();

      if (userCollectionSnapshot.data().count >= COLLECTION_CONFIG.MAX_ITEMS_PER_USER) {
        throw new functions.https.HttpsError(
          "resource-exhausted",
          `Maximum collection size (${COLLECTION_CONFIG.MAX_ITEMS_PER_USER}) reached`
        );
      }

      // Get the highest sort_order for this user
      const lastItemSnapshot = await db
        .collection("collection_items")
        .where("user_id", "==", userId)
        .orderBy("sort_order", "desc")
        .limit(1)
        .get();

      const nextSortOrder = lastItemSnapshot.empty ?
        0 :
        (lastItemSnapshot.docs[0].data().sort_order || 0) + 1;

      const now = admin.firestore.Timestamp.now();

      // Create collection item with sanitized data
      const collectionItemData: Omit<CollectionItem, "id"> = {
        user_id: userId,
        type: type as CollectionItemType,
        title: sanitizedTitle,
        arabic_title: sanitizedArabicTitle,
        arabic_text: sanitizedArabicText,
        translation: sanitizedTranslation,
        transliteration: sanitizedTransliteration,
        category: sanitizedCategory as CollectionCategory,
        source: sanitizedSource,
        notes: sanitizedNotes,
        tags: sanitizedTags,
        audio_url: sanitizedAudioUrl,
        is_favorite,
        sort_order: nextSortOrder,
        created_at: now,
        updated_at: now,
      };

      const docRef = await db.collection("collection_items").add(collectionItemData);

      return {
        success: true,
        itemId: docRef.id,
        message: "Collection item added successfully",
      };
    } catch (error: any) {
      console.error("Error adding collection item:", error);
      throw new functions.https.HttpsError(
        "internal",
        error.message || "Failed to add collection item"
      );
    }
  }
);

/**
 * Update an existing collection item
 */
export const updateCollectionItem = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    const userId = context.auth.uid;
    const {itemId, ...updates} = data;

    if (!itemId) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Item ID is required"
      );
    }

    try {
      const itemRef = db.collection("collection_items").doc(itemId);
      const itemDoc = await itemRef.get();

      if (!itemDoc.exists) {
        throw new functions.https.HttpsError(
          "not-found",
          "Collection item not found"
        );
      }

      // Verify ownership
      const itemData = itemDoc.data();
      if (itemData?.user_id !== userId) {
        throw new functions.https.HttpsError(
          "permission-denied",
          "You don't have permission to update this item"
        );
      }

      // Filter out fields that shouldn't be updated
      const allowedUpdates = {
        title: updates.title,
        arabic_title: updates.arabic_title,
        arabic_text: updates.arabic_text,
        translation: updates.translation,
        transliteration: updates.transliteration,
        category: updates.category,
        source: updates.source,
        notes: updates.notes,
        tags: updates.tags,
        audio_url: updates.audio_url,
        is_favorite: updates.is_favorite,
        sort_order: updates.sort_order,
        updated_at: admin.firestore.Timestamp.now(),
      };

      // Remove undefined fields
      Object.keys(allowedUpdates).forEach((key) => {
        if (allowedUpdates[key as keyof typeof allowedUpdates] === undefined) {
          delete allowedUpdates[key as keyof typeof allowedUpdates];
        }
      });

      await itemRef.update(allowedUpdates);

      return {
        success: true,
        message: "Collection item updated successfully",
      };
    } catch (error: any) {
      console.error("Error updating collection item:", error);
      throw new functions.https.HttpsError(
        "internal",
        error.message || "Failed to update collection item"
      );
    }
  }
);

/**
 * Delete a collection item
 */
export const deleteCollectionItem = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    const userId = context.auth.uid;
    const {itemId} = data;

    if (!itemId) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Item ID is required"
      );
    }

    try {
      const itemRef = db.collection("collection_items").doc(itemId);
      const itemDoc = await itemRef.get();

      if (!itemDoc.exists) {
        throw new functions.https.HttpsError(
          "not-found",
          "Collection item not found"
        );
      }

      // Verify ownership
      const itemData = itemDoc.data();
      if (itemData?.user_id !== userId) {
        throw new functions.https.HttpsError(
          "permission-denied",
          "You don't have permission to delete this item"
        );
      }

      // Delete the item
      await itemRef.delete();

      // Also delete associated reminders
      const remindersSnapshot = await db
        .collection("reminders")
        .where("user_id", "==", userId)
        .where("collection_item_id", "==", itemId)
        .get();

      const batch = db.batch();
      remindersSnapshot.docs.forEach((doc) => {
        batch.delete(doc.ref);
      });

      // Delete associated habit trackers
      const habitsSnapshot = await db
        .collection("habit_trackers")
        .where("user_id", "==", userId)
        .where("collection_item_id", "==", itemId)
        .get();

      habitsSnapshot.docs.forEach((doc) => {
        batch.delete(doc.ref);
      });

      await batch.commit();

      return {
        success: true,
        message: "Collection item and associated data deleted successfully",
      };
    } catch (error: any) {
      console.error("Error deleting collection item:", error);
      throw new functions.https.HttpsError(
        "internal",
        error.message || "Failed to delete collection item"
      );
    }
  }
);

/**
 * Update last accessed time for a collection item
 */
export const updateCollectionItemAccess = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    const userId = context.auth.uid;
    const {itemId} = data;

    if (!itemId) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Item ID is required"
      );
    }

    try {
      const itemRef = db.collection("collection_items").doc(itemId);
      const itemDoc = await itemRef.get();

      if (!itemDoc.exists || itemDoc.data()?.user_id !== userId) {
        throw new functions.https.HttpsError(
          "not-found",
          "Collection item not found"
        );
      }

      await itemRef.update({
        last_accessed: admin.firestore.Timestamp.now(),
      });

      return {success: true};
    } catch (error: any) {
      console.error("Error updating collection item access:", error);
      throw new functions.https.HttpsError(
        "internal",
        error.message || "Failed to update item access"
      );
    }
  }
);

// ============================================================================
// HABIT TRACKER MANAGEMENT
// ============================================================================

/**
 * Add a new habit tracker
 */
export const addHabitTracker = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    const userId = context.auth.uid;
    const {
      collection_item_id,
      title,
      arabic_title,
      description,
      target_count = 1,
      tracking_period = "daily",
    } = data;

    if (!collection_item_id || !title) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "collection_item_id and title are required"
      );
    }

    try {
      // Check habit tracker limit
      const habitCountSnapshot = await db
        .collection("habit_trackers")
        .where("user_id", "==", userId)
        .count()
        .get();

      if (habitCountSnapshot.data().count >= COLLECTION_CONFIG.MAX_HABIT_TRACKERS) {
        throw new functions.https.HttpsError(
          "resource-exhausted",
          `Maximum habit trackers (${COLLECTION_CONFIG.MAX_HABIT_TRACKERS}) reached`
        );
      }

      // Verify collection item exists and belongs to user
      const itemDoc = await db.collection("collection_items").doc(collection_item_id).get();
      if (!itemDoc.exists || itemDoc.data()?.user_id !== userId) {
        throw new functions.https.HttpsError(
          "not-found",
          "Collection item not found"
        );
      }

      const now = admin.firestore.Timestamp.now();
      const habitData: Omit<HabitTracker, "id"> = {
        user_id: userId,
        collection_item_id,
        title,
        arabic_title,
        description,
        target_count,
        current_count: 0,
        tracking_period,
        is_completed_today: false,
        completion_history: [],
        current_streak: 0,
        longest_streak: 0,
        total_completions: 0,
        completion_rate: 0,
        weekly_completions: 0,
        monthly_completions: 0,
        created_at: now,
        updated_at: now,
      };

      const docRef = await db.collection("habit_trackers").add(habitData);

      return {
        success: true,
        habitId: docRef.id,
        message: "Habit tracker created successfully",
      };
    } catch (error: any) {
      console.error("Error adding habit tracker:", error);
      throw new functions.https.HttpsError(
        "internal",
        error.message || "Failed to add habit tracker"
      );
    }
  }
);

/**
 * Update habit progress (increment count)
 */
export const updateHabitProgress = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    const userId = context.auth.uid;
    const {habitId, increment = 1} = data;

    if (!habitId) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Habit ID is required"
      );
    }

    try {
      const habitRef = db.collection("habit_trackers").doc(habitId);
      const habitDoc = await habitRef.get();

      if (!habitDoc.exists) {
        throw new functions.https.HttpsError(
          "not-found",
          "Habit tracker not found"
        );
      }

      const habitData = habitDoc.data() as HabitTracker;

      // Verify ownership
      if (habitData.user_id !== userId) {
        throw new functions.https.HttpsError(
          "permission-denied",
          "You don't have permission to update this habit"
        );
      }

      const today = new Date().toISOString().split("T")[0];
      const newCount = habitData.current_count + increment;
      const isCompleted = newCount >= habitData.target_count;

      // Calculate streak
      let currentStreak = habitData.current_streak;
      let longestStreak = habitData.longest_streak;
      const completionHistory = habitData.completion_history || [];
      let totalCompletions = habitData.total_completions;

      if (isCompleted && !habitData.is_completed_today) {
        // Add today to completion history if not already there
        if (!completionHistory.includes(today)) {
          completionHistory.push(today);
          totalCompletions += 1;

          // Calculate streak
          const yesterday = new Date();
          yesterday.setDate(yesterday.getDate() - 1);
          const yesterdayStr = yesterday.toISOString().split("T")[0];

          if (habitData.last_completed_date === yesterdayStr) {
            currentStreak += 1;
          } else if (habitData.last_completed_date !== today) {
            currentStreak = 1;
          }

          if (currentStreak > longestStreak) {
            longestStreak = currentStreak;
          }
        }
      }

      // Calculate completion rate (last 30 days)
      const thirtyDaysAgo = new Date();
      thirtyDaysAgo.setDate(thirtyDaysAgo.getDate() - 30);
      const recentCompletions = completionHistory.filter((date) => {
        return new Date(date) >= thirtyDaysAgo;
      }).length;
      const completionRate = (recentCompletions / 30) * 100;

      // Calculate weekly and monthly completions
      const sevenDaysAgo = new Date();
      sevenDaysAgo.setDate(sevenDaysAgo.getDate() - 7);
      const weeklyCompletions = completionHistory.filter((date) => {
        return new Date(date) >= sevenDaysAgo;
      }).length;

      const monthlyCompletions = recentCompletions;

      await habitRef.update({
        current_count: newCount,
        is_completed_today: isCompleted,
        last_completed_date: isCompleted ? today : habitData.last_completed_date,
        completion_history: completionHistory,
        current_streak: currentStreak,
        longest_streak: longestStreak,
        total_completions: totalCompletions,
        completion_rate: Math.round(completionRate),
        weekly_completions: weeklyCompletions,
        monthly_completions: monthlyCompletions,
        updated_at: admin.firestore.Timestamp.now(),
      });

      return {
        success: true,
        isCompleted,
        currentCount: newCount,
        currentStreak,
        message: isCompleted ? "Habit completed for today!" : "Progress updated",
      };
    } catch (error: any) {
      console.error("Error updating habit progress:", error);
      throw new functions.https.HttpsError(
        "internal",
        error.message || "Failed to update habit progress"
      );
    }
  }
);

/**
 * Reset daily habit progress
 * Called automatically at the start of each day
 */
export const resetDailyHabits = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    const userId = context.auth.uid;

    try {
      const habitsSnapshot = await db
        .collection("habit_trackers")
        .where("user_id", "==", userId)
        .where("tracking_period", "==", "daily")
        .get();

      const batch = db.batch();
      habitsSnapshot.docs.forEach((doc) => {
        batch.update(doc.ref, {
          current_count: 0,
          is_completed_today: false,
          updated_at: admin.firestore.Timestamp.now(),
        });
      });

      await batch.commit();

      return {
        success: true,
        resetCount: habitsSnapshot.size,
        message: "Daily habits reset successfully",
      };
    } catch (error: any) {
      console.error("Error resetting daily habits:", error);
      throw new functions.https.HttpsError(
        "internal",
        error.message || "Failed to reset daily habits"
      );
    }
  }
);

/**
 * Delete a habit tracker
 */
export const deleteHabitTracker = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    const userId = context.auth.uid;
    const {habitId} = data;

    if (!habitId) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Habit ID is required"
      );
    }

    try {
      const habitRef = db.collection("habit_trackers").doc(habitId);
      const habitDoc = await habitRef.get();

      if (!habitDoc.exists) {
        throw new functions.https.HttpsError(
          "not-found",
          "Habit tracker not found"
        );
      }

      // Verify ownership
      if (habitDoc.data()?.user_id !== userId) {
        throw new functions.https.HttpsError(
          "permission-denied",
          "You don't have permission to delete this habit"
        );
      }

      await habitRef.delete();

      return {
        success: true,
        message: "Habit tracker deleted successfully",
      };
    } catch (error: any) {
      console.error("Error deleting habit tracker:", error);
      throw new functions.https.HttpsError(
        "internal",
        error.message || "Failed to delete habit tracker"
      );
    }
  }
);

// ============================================================================
// CHECKLIST MANAGEMENT
// ============================================================================

/**
 * Add a checklist item for the day
 */
export const addChecklistItem = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    const userId = context.auth.uid;
    const {
      title,
      arabic_title,
      checklist_date,
      collection_item_id,
      is_completed = false,
    } = data;

    if (!title) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Title is required"
      );
    }

    try {
      const today = checklist_date || new Date().toISOString().split("T")[0];
      const now = admin.firestore.Timestamp.now();

      const checklistData = {
        user_id: userId,
        title,
        arabic_title,
        checklist_date: today,
        collection_item_id: collection_item_id || null,
        is_completed,
        completed_at: is_completed ? now : null,
        created_at: now,
        updated_at: now,
      };

      const docRef = await db.collection("checklist_items").add(checklistData);

      return {
        success: true,
        itemId: docRef.id,
        message: "Checklist item added successfully",
      };
    } catch (error: any) {
      console.error("Error adding checklist item:", error);
      throw new functions.https.HttpsError(
        "internal",
        error.message || "Failed to add checklist item"
      );
    }
  }
);

/**
 * Toggle checklist item completion status
 */
export const toggleChecklistItem = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    const userId = context.auth.uid;
    const {itemId} = data;

    if (!itemId) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Item ID is required"
      );
    }

    try {
      const itemRef = db.collection("checklist_items").doc(itemId);
      const itemDoc = await itemRef.get();

      if (!itemDoc.exists) {
        throw new functions.https.HttpsError(
          "not-found",
          "Checklist item not found"
        );
      }

      const itemData = itemDoc.data();

      // Verify ownership
      if (itemData?.user_id !== userId) {
        throw new functions.https.HttpsError(
          "permission-denied",
          "You don't have permission to update this item"
        );
      }

      const newCompletionStatus = !itemData.is_completed;

      await itemRef.update({
        is_completed: newCompletionStatus,
        completed_at: newCompletionStatus ? admin.firestore.Timestamp.now() : null,
        updated_at: admin.firestore.Timestamp.now(),
      });

      return {
        success: true,
        is_completed: newCompletionStatus,
        message: newCompletionStatus ? "Item completed" : "Item uncompleted",
      };
    } catch (error: any) {
      console.error("Error toggling checklist item:", error);
      throw new functions.https.HttpsError(
        "internal",
        error.message || "Failed to toggle checklist item"
      );
    }
  }
);

/**
 * Delete a checklist item
 */
export const deleteChecklistItem = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    const userId = context.auth.uid;
    const {itemId} = data;

    if (!itemId) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Item ID is required"
      );
    }

    try {
      const itemRef = db.collection("checklist_items").doc(itemId);
      const itemDoc = await itemRef.get();

      if (!itemDoc.exists) {
        throw new functions.https.HttpsError(
          "not-found",
          "Checklist item not found"
        );
      }

      // Verify ownership
      if (itemDoc.data()?.user_id !== userId) {
        throw new functions.https.HttpsError(
          "permission-denied",
          "You don't have permission to delete this item"
        );
      }

      await itemRef.delete();

      return {
        success: true,
        message: "Checklist item deleted successfully",
      };
    } catch (error: any) {
      console.error("Error deleting checklist item:", error);
      throw new functions.https.HttpsError(
        "internal",
        error.message || "Failed to delete checklist item"
      );
    }
  }
);

/**
 * Scheduled function to clean up old checklist items
 * Runs daily at 2 AM UTC
 */
export const cleanupOldChecklists = functions.pubsub
  .schedule("0 2 * * *")
  .timeZone("UTC")
  .onRun(async (context) => {
    try {
      const cutoffDate = new Date();
      cutoffDate.setDate(cutoffDate.getDate() - COLLECTION_CONFIG.CHECKLIST_RETENTION_DAYS);
      const cutoffDateStr = cutoffDate.toISOString().split("T")[0];

      const oldItemsSnapshot = await db
        .collection("checklist_items")
        .where("checklist_date", "<", cutoffDateStr)
        .get();

      if (oldItemsSnapshot.empty) {
        console.log("No old checklist items to clean up");
        return null;
      }

      const batch = db.batch();
      oldItemsSnapshot.docs.forEach((doc) => {
        batch.delete(doc.ref);
      });

      await batch.commit();

      console.log(`Cleaned up ${oldItemsSnapshot.size} old checklist items`);
      return null;
    } catch (error) {
      console.error("Error cleaning up old checklists:", error);
      return null;
    }
  });
