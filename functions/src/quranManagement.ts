import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

const db = admin.firestore();

/**
 * Quran Management Functions
 * Provides backend support for Quran reading features
 */

// ============================================================================
// QURAN DATA RETRIEVAL FUNCTIONS
// ============================================================================

/**
 * Get all Surahs (chapters) metadata
 * Returns basic info for all 114 Surahs
 */
export const getAllSurahs = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "User must be authenticated"
    );
  }

  try {
    const surahsSnapshot = await db
      .collection("quran_surahs")
      .orderBy("number", "asc")
      .get();

    if (surahsSnapshot.empty) {
      return {
        success: false,
        message: "No Surah data found. Please import Quran data first.",
        surahs: [],
      };
    }

    const surahs = surahsSnapshot.docs.map((doc) => ({
      id: doc.id,
      number: doc.data().number,
      name: doc.data().name,
      englishName: doc.data().englishName,
      englishNameTranslation: doc.data().englishNameTranslation,
      revelationType: doc.data().revelationType,
      numberOfAyahs: doc.data().numberOfAyahs,
    }));

    return {
      success: true,
      surahs,
      total: surahs.length,
    };
  } catch (error: any) {
    console.error("Error in getAllSurahs:", error);
    throw new functions.https.HttpsError(
      "internal",
      error.message || "Failed to get Surahs"
    );
  }
});

/**
 * Get a specific Surah with all its verses
 */
export const getSurah = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "User must be authenticated"
    );
  }

  const {surahNumber} = data;

  if (!surahNumber || surahNumber < 1 || surahNumber > 114) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Valid surahNumber (1-114) is required"
    );
  }

  try {
    // Get Surah metadata
    const surahSnapshot = await db
      .collection("quran_surahs")
      .where("number", "==", surahNumber)
      .limit(1)
      .get();

    if (surahSnapshot.empty) {
      throw new functions.https.HttpsError(
        "not-found",
        `Surah ${surahNumber} not found`
      );
    }

    const surahDoc = surahSnapshot.docs[0];
    const surahData = surahDoc.data();

    return {
      success: true,
      surah: {
        id: surahDoc.id,
        number: surahData.number,
        name: surahData.name,
        englishName: surahData.englishName,
        englishNameTranslation: surahData.englishNameTranslation,
        revelationType: surahData.revelationType,
        numberOfAyahs: surahData.numberOfAyahs,
      },
    };
  } catch (error: any) {
    console.error("Error in getSurah:", error);
    throw new functions.https.HttpsError(
      "internal",
      error.message || "Failed to get Surah"
    );
  }
});

/**
 * Get verses (ayahs) for a specific Surah
 * Supports pagination for performance
 */
export const getVersesForSurah = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    const {
      surahNumber,
      startVerse = 1,
      limit = 50,
      includeTranslation = true,
      includeTransliteration = false,
    } = data;

    if (!surahNumber || surahNumber < 1 || surahNumber > 114) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Valid surahNumber (1-114) is required"
      );
    }

    try {
      // Get verses for this Surah
      let versesQuery = db
        .collection("quran_verses")
        .where("surahNumber", "==", surahNumber)
        .where("verseNumber", ">=", startVerse)
        .orderBy("verseNumber", "asc")
        .limit(limit);

      const versesSnapshot = await versesQuery.get();

      if (versesSnapshot.empty) {
        return {
          success: true,
          verses: [],
          total: 0,
          message: "No verses found for this Surah",
        };
      }

      const verses = versesSnapshot.docs.map((doc) => {
        const verseData = doc.data();
        const verse: any = {
          id: doc.id,
          surahNumber: verseData.surahNumber,
          verseNumber: verseData.verseNumber,
          text: verseData.text,
          numberInSurah: verseData.numberInSurah,
          juz: verseData.juz,
          page: verseData.page,
        };

        if (includeTranslation && verseData.translation) {
          verse.translation = verseData.translation;
        }

        if (includeTransliteration && verseData.transliteration) {
          verse.transliteration = verseData.transliteration;
        }

        if (verseData.audioUrl) {
          verse.audioUrl = verseData.audioUrl;
        }

        return verse;
      });

      return {
        success: true,
        verses,
        total: verses.length,
        hasMore: verses.length === limit,
      };
    } catch (error: any) {
      console.error("Error in getVersesForSurah:", error);
      throw new functions.https.HttpsError(
        "internal",
        error.message || "Failed to get verses"
      );
    }
  }
);

/**
 * Get a specific verse by Surah and verse number
 */
export const getVerse = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "User must be authenticated"
    );
  }

  const {surahNumber, verseNumber} = data;

  if (!surahNumber || surahNumber < 1 || surahNumber > 114) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Valid surahNumber (1-114) is required"
    );
  }

  if (!verseNumber || verseNumber < 1) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Valid verseNumber is required"
    );
  }

  try {
    const verseSnapshot = await db
      .collection("quran_verses")
      .where("surahNumber", "==", surahNumber)
      .where("verseNumber", "==", verseNumber)
      .limit(1)
      .get();

    if (verseSnapshot.empty) {
      throw new functions.https.HttpsError(
        "not-found",
        `Verse ${surahNumber}:${verseNumber} not found`
      );
    }

    const verseDoc = verseSnapshot.docs[0];
    const verseData = verseDoc.data();

    return {
      success: true,
      verse: {
        id: verseDoc.id,
        surahNumber: verseData.surahNumber,
        verseNumber: verseData.verseNumber,
        text: verseData.text,
        translation: verseData.translation,
        transliteration: verseData.transliteration,
        numberInSurah: verseData.numberInSurah,
        juz: verseData.juz,
        page: verseData.page,
        audioUrl: verseData.audioUrl,
      },
    };
  } catch (error: any) {
    console.error("Error in getVerse:", error);
    throw new functions.https.HttpsError(
      "internal",
      error.message || "Failed to get verse"
    );
  }
});

/**
 * Search Quran verses by text
 * Searches in Arabic text and translation
 */
export const searchQuranVerses = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    const {query, searchIn = "both", limit = 50} = data;

    if (!query || query.trim().length < 3) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Search query must be at least 3 characters"
      );
    }

    try {
      // Note: For production, consider using Algolia or Elasticsearch
      // Firestore doesn't support full-text search natively
      // This is a basic implementation using array-contains

      const searchTerm = query.trim().toLowerCase();

      // For now, we'll do a simple contains search
      // In production, you'd want to use a proper search service
      const versesSnapshot = await db
        .collection("quran_verses")
        .limit(limit * 3)
        .get();

      const matchingVerses = versesSnapshot.docs
        .filter((doc) => {
          const verseData = doc.data();
          const arabicText = verseData.text?.toLowerCase() || "";
          const translation = verseData.translation?.toLowerCase() || "";

          if (searchIn === "arabic") {
            return arabicText.includes(searchTerm);
          } else if (searchIn === "translation") {
            return translation.includes(searchTerm);
          } else {
            return arabicText.includes(searchTerm) ||
              translation.includes(searchTerm);
          }
        })
        .slice(0, limit)
        .map((doc) => {
          const verseData = doc.data();
          return {
            id: doc.id,
            surahNumber: verseData.surahNumber,
            verseNumber: verseData.verseNumber,
            text: verseData.text,
            translation: verseData.translation,
            numberInSurah: verseData.numberInSurah,
          };
        });

      return {
        success: true,
        results: matchingVerses,
        total: matchingVerses.length,
        query: searchTerm,
      };
    } catch (error: any) {
      console.error("Error in searchQuranVerses:", error);
      throw new functions.https.HttpsError(
        "internal",
        error.message || "Failed to search verses"
      );
    }
  }
);

// ============================================================================
// ADMIN FUNCTIONS - DATA IMPORT
// ============================================================================

/**
 * Import Surah metadata (Admin only)
 * Populates the quran_surahs collection
 */
export const importSurahMetadata = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    // Check admin role
    const userDoc = await db
      .collection("users")
      .doc(context.auth.uid)
      .get();
    const userRole = userDoc.data()?.profile?.role;

    if (userRole !== "admin") {
      throw new functions.https.HttpsError(
        "permission-denied",
        "Only admins can import Quran data"
      );
    }

    const {surahs} = data;

    if (!Array.isArray(surahs) || surahs.length === 0) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Surahs array is required"
      );
    }

    try {
      const batch = db.batch();
      let count = 0;

      for (const surah of surahs) {
        if (!surah.number || !surah.name) {
          continue;
        }

        const surahRef = db.collection("quran_surahs").doc(`surah_${surah.number}`);
        batch.set(surahRef, {
          number: surah.number,
          name: surah.name,
          englishName: surah.englishName || "",
          englishNameTranslation: surah.englishNameTranslation || "",
          revelationType: surah.revelationType || "Meccan",
          numberOfAyahs: surah.numberOfAyahs || 0,
          createdAt: admin.firestore.Timestamp.now(),
          updatedAt: admin.firestore.Timestamp.now(),
        });

        count++;

        // Firestore batch limit is 500
        if (count % 500 === 0) {
          await batch.commit();
        }
      }

      // Commit remaining
      if (count % 500 !== 0) {
        await batch.commit();
      }

      return {
        success: true,
        imported: count,
        message: `Successfully imported ${count} Surahs`,
      };
    } catch (error: any) {
      console.error("Error in importSurahMetadata:", error);
      throw new functions.https.HttpsError(
        "internal",
        error.message || "Failed to import Surah metadata"
      );
    }
  }
);

/**
 * Import Quran verses (Admin only)
 * Populates the quran_verses collection
 * Should be called in batches due to Firestore limits
 */
export const importQuranVerses = functions.https.onCall(
  async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated"
      );
    }

    // Check admin role
    const userDoc = await db
      .collection("users")
      .doc(context.auth.uid)
      .get();
    const userRole = userDoc.data()?.profile?.role;

    if (userRole !== "admin") {
      throw new functions.https.HttpsError(
        "permission-denied",
        "Only admins can import Quran data"
      );
    }

    const {verses} = data;

    if (!Array.isArray(verses) || verses.length === 0) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Verses array is required"
      );
    }

    // Limit batch size
    if (verses.length > 500) {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "Maximum 500 verses per batch. Please split into multiple calls."
      );
    }

    try {
      const batch = db.batch();
      let count = 0;

      for (const verse of verses) {
        if (!verse.surahNumber || !verse.verseNumber || !verse.text) {
          continue;
        }

        const verseId = `${verse.surahNumber}_${verse.verseNumber}`;
        const verseRef = db.collection("quran_verses").doc(verseId);

        batch.set(verseRef, {
          surahNumber: verse.surahNumber,
          verseNumber: verse.verseNumber,
          numberInSurah: verse.numberInSurah || verse.verseNumber,
          text: verse.text,
          translation: verse.translation || null,
          transliteration: verse.transliteration || null,
          juz: verse.juz || null,
          page: verse.page || null,
          sajda: verse.sajda || false,
          audioUrl: verse.audioUrl || null,
          createdAt: admin.firestore.Timestamp.now(),
          updatedAt: admin.firestore.Timestamp.now(),
        });

        count++;
      }

      await batch.commit();

      return {
        success: true,
        imported: count,
        message: `Successfully imported ${count} verses`,
      };
    } catch (error: any) {
      console.error("Error in importQuranVerses:", error);
      throw new functions.https.HttpsError(
        "internal",
        error.message || "Failed to import verses"
      );
    }
  }
);

/**
 * Get Quran data statistics (Admin only)
 */
export const getQuranStats = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "User must be authenticated"
    );
  }

  // Check admin role
  const userDoc = await db
    .collection("users")
    .doc(context.auth.uid)
    .get();
  const userRole = userDoc.data()?.profile?.role;

  if (userRole !== "admin") {
    throw new functions.https.HttpsError(
      "permission-denied",
      "Only admins can view Quran stats"
    );
  }

  try {
    const [surahsCount, versesCount] = await Promise.all([
      db.collection("quran_surahs").count().get(),
      db.collection("quran_verses").count().get(),
    ]);

    return {
      success: true,
      stats: {
        totalSurahs: surahsCount.data().count,
        totalVerses: versesCount.data().count,
        expectedSurahs: 114,
        expectedVerses: 6236,
        isComplete:
          surahsCount.data().count === 114 &&
          versesCount.data().count === 6236,
      },
    };
  } catch (error: any) {
    console.error("Error in getQuranStats:", error);
    throw new functions.https.HttpsError(
      "internal",
      error.message || "Failed to get Quran stats"
    );
  }
});
