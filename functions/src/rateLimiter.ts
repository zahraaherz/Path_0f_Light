import * as functions from 'firebase-functions';
import { RateLimiterMemory, RateLimiterRes } from 'rate-limiter-flexible';

/**
 * Rate Limiter Configuration
 * Prevents abuse and controls costs by limiting requests per user
 */

// Standard rate limiter: 20 requests per minute
export const standardRateLimiter = new RateLimiterMemory({
  points: 20, // Number of requests
  duration: 60, // Per 60 seconds
  blockDuration: 60, // Block for 60 seconds if exceeded
});

// Strict rate limiter for sensitive operations: 5 requests per minute
export const strictRateLimiter = new RateLimiterMemory({
  points: 5,
  duration: 60,
  blockDuration: 300, // Block for 5 minutes if exceeded
});

// Quiz submission rate limiter: 10 submissions per minute
export const quizRateLimiter = new RateLimiterMemory({
  points: 10,
  duration: 60,
  blockDuration: 120,
});

// Authentication rate limiter: 3 attempts per minute
export const authRateLimiter = new RateLimiterMemory({
  points: 3,
  duration: 60,
  blockDuration: 600, // Block for 10 minutes if exceeded
});

/**
 * Rate limit a callable function
 * @param limiter - The rate limiter to use
 * @param context - Firebase callable context
 * @param identifier - Optional custom identifier (defaults to user ID)
 */
export async function checkRateLimit(
  limiter: RateLimiterMemory,
  context: functions.https.CallableContext,
  identifier?: string
): Promise<void> {
  // Determine the identifier (user ID or custom identifier)
  const key = identifier || context.auth?.uid;

  if (!key) {
    throw new functions.https.HttpsError(
      'unauthenticated',
      'Authentication required'
    );
  }

  try {
    await limiter.consume(key);
  } catch (rateLimiterRes) {
    const res = rateLimiterRes as RateLimiterRes;
    const retryAfter = Math.round(res.msBeforeNext / 1000) || 1;

    throw new functions.https.HttpsError(
      'resource-exhausted',
      `Too many requests. Please try again in ${retryAfter} seconds.`,
      { retryAfter }
    );
  }
}

/**
 * Rate limit an HTTP request
 * @param limiter - The rate limiter to use
 * @param req - HTTP request
 * @param identifier - Identifier for rate limiting (IP or user ID)
 */
export async function checkHttpRateLimit(
  limiter: RateLimiterMemory,
  req: functions.Request,
  identifier: string
): Promise<void> {
  try {
    await limiter.consume(identifier);
  } catch (rateLimiterRes) {
    const res = rateLimiterRes as RateLimiterRes;
    const retryAfter = Math.round(res.msBeforeNext / 1000) || 1;

    throw new Error(`Rate limit exceeded. Retry after ${retryAfter} seconds.`);
  }
}
