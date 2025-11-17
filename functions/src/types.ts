import * as admin from "firebase-admin";

/**
 * Shared type definitions for Firebase Functions
 */

// Battery System Types
export interface BatteryData {
  currentHearts: number;
  maxHearts: number;
  lastRefillTime: admin.firestore.Timestamp;
  lastDailyResetDate: string;
  totalHeartsUsed: number;
  totalHeartsRefilled: number;
}

export interface BatteryConfig {
  MAX_HEARTS: number;
  REFILL_INTERVAL_HOURS: number;
  REFILL_INTERVAL_MS: number;
  DAILY_RESET_HOUR: number;
  DAILY_BONUS_HEARTS: number;
}

// Quiz Types
export type DifficultyLevel = "basic" | "intermediate" | "advanced" | "expert";
export type AnswerOption = "A" | "B" | "C" | "D";
export type Language = "en" | "ar";

export interface QuestionOption {
  text_ar: string;
  text_en: string;
}

export interface QuestionOptions {
  A: QuestionOption;
  B: QuestionOption;
  C: QuestionOption;
  D: QuestionOption;
}

export interface QuestionSource {
  paragraph_id: string;
  book_id: string;
  exact_quote_ar: string;
  page_number: number;
}

export interface Question {
  id: string;
  category: string;
  difficulty: DifficultyLevel;
  question_ar: string;
  question_en: string;
  options: QuestionOptions;
  correct_answer: AnswerOption;
  source: QuestionSource;
  explanation_ar: string;
  explanation_en: string;
  points: number;
}

export interface QuizConfig {
  POINTS: {
    basic: number;
    intermediate: number;
    advanced: number;
    expert: number;
  };
  QUESTIONS_PER_SESSION: number;
  STREAK_BONUS_MULTIPLIER: number;
  MAX_STREAK_BONUS: number;
}

export interface CategoryProgress {
  answered: number;
  correct: number;
  points: number;
}

export interface DifficultyProgress {
  answered: number;
  correct: number;
}

export interface QuizProgress {
  totalQuestionsAnswered: number;
  correctAnswers: number;
  wrongAnswers: number;
  currentStreak: number;
  longestStreak: number;
  totalPoints: number;
  categoryProgress: {
    [category: string]: CategoryProgress;
  };
  difficultyProgress: {
    basic: DifficultyProgress;
    intermediate: DifficultyProgress;
    advanced: DifficultyProgress;
    expert: DifficultyProgress;
  };
}

export interface QuizAnswer {
  questionId: string;
  userAnswer: AnswerOption;
  isCorrect: boolean;
  pointsEarned: number;
  timestamp: admin.firestore.Timestamp;
}

export interface QuizSession {
  sessionId: string;
  startTime: admin.firestore.Timestamp;
  endTime?: admin.firestore.Timestamp;
  questions: string[];
  answers?: QuizAnswer[];
  category?: string;
  difficulty?: DifficultyLevel;
  language: Language;
  status: "active" | "completed" | "abandoned";
  summary?: QuizSessionSummary;
}

export interface QuizSessionSummary {
  sessionId: string;
  totalQuestions: number;
  correctAnswers: number;
  wrongAnswers: number;
  totalPoints: number;
  accuracy: string;
  duration: number;
}

// User Types
export interface PremiumSubscription {
  active: boolean;
  expiryDate: admin.firestore.Timestamp;
  plan: "monthly" | "yearly" | "lifetime";
  startDate: admin.firestore.Timestamp;
}

export interface DailyStats {
  lastLoginDate: string;
  loginStreak: number;
  longestLoginStreak: number;
  totalLoginDays: number;
}

export interface UserProfile {
  uid: string;
  displayName: string;
  email: string;
  photoURL?: string;
  language: Language;
  battery: BatteryData;
  quizProgress: QuizProgress;
  premium?: PremiumSubscription;
  dailyStats: DailyStats;
  createdAt: admin.firestore.Timestamp;
  lastActive: admin.firestore.Timestamp;
}

// Book Types
export interface Book {
  id: string;
  title_ar: string;
  title_en: string;
  author_ar: string;
  author_en: string;
  total_sections: number;
  total_paragraphs: number;
  language: string;
  pdf_url?: string;
  version: string;
  verified_by: string;
  content_status: "draft" | "verified" | "published";
}

export interface Section {
  id: string;
  book_id: string;
  book_title_ar: string;
  section_number: number;
  title_ar: string;
  title_en: string;
  paragraph_count: number;
  page_range: string;
  difficulty_level: DifficultyLevel;
  topics: string[];
}

export interface ParagraphContent {
  text_ar: string;
  text_en: string;
}

export interface ParagraphEntities {
  people: string[];
  places: string[];
  events: string[];
  dates: string[];
}

export interface ParagraphSearchData {
  keywords_ar: string[];
  keywords_en: string[];
}

export interface ParagraphReferences {
  referenced_in_questions: string[];
  related_paragraphs: string[];
}

export interface ParagraphMetadata {
  difficulty: DifficultyLevel;
  reading_time_seconds: number;
  question_potential: {
    facts_count: number;
    can_generate_questions: boolean;
  };
  content_priority: "high" | "medium" | "low";
}

export interface Paragraph {
  id: string;
  book_id: string;
  section_id: string;
  section_title_ar: string;
  paragraph_number: number;
  page_number: number;
  content: ParagraphContent;
  entities: ParagraphEntities;
  search_data: ParagraphSearchData;
  references: ParagraphReferences;
  metadata: ParagraphMetadata;
}

// Analytics Types
export interface AnalyticsEvent {
  userId: string;
  eventType: string;
  timestamp: admin.firestore.Timestamp;
  data: {[key: string]: any};
}

// API Request/Response Types
export interface GetQuizQuestionsRequest {
  category?: string;
  difficulty?: DifficultyLevel;
  language?: Language;
  count?: number;
}

export interface GetQuizQuestionsResponse {
  sessionId: string;
  questions: Array<{
    id: string;
    category: string;
    difficulty: string;
    question: string;
    options: {
      A: string;
      B: string;
      C: string;
      D: string;
    };
    points: number;
  }>;
  totalQuestions: number;
}

export interface SubmitQuizAnswerRequest {
  questionId: string;
  answer: AnswerOption;
  sessionId: string;
  language?: Language;
}

export interface SubmitQuizAnswerResponse {
  isCorrect: boolean;
  correctAnswer: AnswerOption;
  explanation: string;
  pointsEarned: number;
  currentStreak: number;
  source: {
    bookId: string;
    paragraphId: string;
    pageNumber: number;
    quote: string;
  };
  heartsRemaining: number;
}

export interface RestoreHeartsRequest {
  method: "ad" | "premium" | "purchase";
  heartsToAdd: number;
}

export interface RestoreHeartsResponse {
  success: boolean;
  currentHearts: number;
  message: string;
}

// Collection Types
export type CollectionItemType =
  | "dua"
  | "surah"
  | "ayah"
  | "ziyarat"
  | "hadith"
  | "passage"
  | "dhikr"
  | "custom";

export type CollectionCategory =
  | "morning"
  | "evening"
  | "friday"
  | "ramadhan"
  | "muharram"
  | "safar"
  | "rajab"
  | "shaban"
  | "daily"
  | "weekly"
  | "monthly"
  | "special"
  | "protection"
  | "forgiveness"
  | "gratitude"
  | "healing"
  | "guidance"
  | "custom";

export interface CollectionItem {
  id: string;
  user_id: string;
  type: CollectionItemType;
  title: string;
  arabic_title?: string;
  arabic_text: string;
  translation?: string;
  transliteration?: string;
  category: CollectionCategory;
  source?: string;
  notes?: string;
  tags: string[];
  audio_url?: string;
  is_favorite: boolean;
  sort_order: number;
  created_at: admin.firestore.Timestamp;
  updated_at: admin.firestore.Timestamp;
  last_accessed?: admin.firestore.Timestamp;
}

// Reminder Types
export type ReminderTriggerType =
  | "time"
  | "prayerTime"
  | "date"
  | "dayOfWeek"
  | "islamicDate";

export type ReminderFrequency =
  | "once"
  | "daily"
  | "weekly"
  | "monthly"
  | "custom";

export type PrayerTimeOption =
  | "fajr"
  | "sunrise"
  | "dhuhr"
  | "asr"
  | "maghrib"
  | "isha";

export type DayOfWeek =
  | "monday"
  | "tuesday"
  | "wednesday"
  | "thursday"
  | "friday"
  | "saturday"
  | "sunday";

export interface Reminder {
  id: string;
  user_id: string;
  collection_item_id: string;
  title: string;
  message?: string;
  inspirational_text?: string;
  trigger_type: ReminderTriggerType;
  frequency: ReminderFrequency;
  trigger_time?: string; // HH:mm format
  trigger_date?: admin.firestore.Timestamp;
  days_of_week: DayOfWeek[];
  prayer_time?: PrayerTimeOption;
  minutes_before_prayer: number;
  minutes_after_prayer: number;
  hijri_month?: number;
  hijri_day?: number;
  is_enabled: boolean;
  sound_enabled: boolean;
  vibration_enabled: boolean;
  last_triggered?: admin.firestore.Timestamp;
  next_trigger?: admin.firestore.Timestamp;
  total_triggers: number;
  created_at: admin.firestore.Timestamp;
  updated_at: admin.firestore.Timestamp;
}

// Habit Tracker Types
export interface HabitTracker {
  id: string;
  user_id: string;
  collection_item_id: string;
  title: string;
  arabic_title?: string;
  description?: string;
  target_count: number;
  current_count: number;
  tracking_period: string; // daily, weekly, monthly
  is_completed_today: boolean;
  last_completed_date?: string;
  completion_history: string[];
  current_streak: number;
  longest_streak: number;
  total_completions: number;
  completion_rate: number;
  weekly_completions: number;
  monthly_completions: number;
  created_at: admin.firestore.Timestamp;
  updated_at: admin.firestore.Timestamp;
}

// Notification Types
export interface NotificationPayload {
  userId: string;
  title: string;
  body: string;
  data?: {[key: string]: string};
  imageUrl?: string;
  sound?: string;
}

export interface FCMToken {
  userId: string;
  token: string;
  platform: "android" | "ios" | "web";
  createdAt: admin.firestore.Timestamp;
  lastUsed: admin.firestore.Timestamp;
}
