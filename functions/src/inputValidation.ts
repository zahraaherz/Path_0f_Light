import * as validator from 'validator';
import * as functions from 'firebase-functions';

/**
 * Input Validation and Sanitization Utilities
 * Protects against XSS, injection attacks, and data pollution
 */

/**
 * Sanitize a string input by escaping HTML and trimming whitespace
 * @param input - Raw string input
 * @param maxLength - Optional maximum length (default: 1000)
 * @returns Sanitized string
 */
export function sanitizeString(input: string | undefined, maxLength = 1000): string {
  if (!input) return '';

  // Trim whitespace
  let sanitized = validator.trim(input);

  // Escape HTML to prevent XSS
  sanitized = validator.escape(sanitized);

  // Enforce maximum length
  if (sanitized.length > maxLength) {
    sanitized = sanitized.substring(0, maxLength);
  }

  return sanitized;
}

/**
 * Sanitize text content (allows more characters for content fields)
 * @param input - Raw text input
 * @param maxLength - Optional maximum length (default: 50000)
 * @returns Sanitized text
 */
export function sanitizeText(input: string | undefined, maxLength = 50000): string {
  if (!input) return '';

  // Trim whitespace but preserve internal formatting
  let sanitized = input.trim();

  // Escape HTML to prevent XSS
  sanitized = validator.escape(sanitized);

  // Enforce maximum length
  if (sanitized.length > maxLength) {
    sanitized = sanitized.substring(0, maxLength);
  }

  return sanitized;
}

/**
 * Validate and sanitize email addresses
 * @param email - Email to validate
 * @returns Sanitized email
 * @throws HttpsError if email is invalid
 */
export function sanitizeEmail(email: string | undefined): string {
  if (!email) {
    throw new functions.https.HttpsError(
      'invalid-argument',
      'Email is required'
    );
  }

  const normalized = validator.normalizeEmail(email) || '';

  if (!validator.isEmail(normalized)) {
    throw new functions.https.HttpsError(
      'invalid-argument',
      'Invalid email address'
    );
  }

  return normalized;
}

/**
 * Validate and sanitize URLs
 * @param url - URL to validate
 * @param required - Whether URL is required (default: false)
 * @returns Sanitized URL or empty string if not required and empty
 * @throws HttpsError if URL is invalid
 */
export function sanitizeUrl(url: string | undefined, required = false): string {
  if (!url) {
    if (required) {
      throw new functions.https.HttpsError(
        'invalid-argument',
        'URL is required'
      );
    }
    return '';
  }

  const trimmed = validator.trim(url);

  if (!validator.isURL(trimmed, {
    protocols: ['http', 'https'],
    require_protocol: true,
  })) {
    throw new functions.https.HttpsError(
      'invalid-argument',
      'Invalid URL format'
    );
  }

  return trimmed;
}

/**
 * Sanitize alphanumeric input (usernames, IDs, etc.)
 * @param input - Alphanumeric input
 * @param maxLength - Maximum length (default: 50)
 * @returns Sanitized alphanumeric string
 * @throws HttpsError if contains invalid characters
 */
export function sanitizeAlphanumeric(
  input: string | undefined,
  maxLength = 50
): string {
  if (!input) return '';

  const trimmed = validator.trim(input);

  // Allow alphanumeric, underscores, and hyphens
  if (!/^[a-zA-Z0-9_-]+$/.test(trimmed)) {
    throw new functions.https.HttpsError(
      'invalid-argument',
      'Input must contain only letters, numbers, underscores, and hyphens'
    );
  }

  if (trimmed.length > maxLength) {
    throw new functions.https.HttpsError(
      'invalid-argument',
      `Input must be ${maxLength} characters or less`
    );
  }

  return trimmed;
}

/**
 * Sanitize numeric input
 * @param input - Numeric input
 * @param min - Minimum value (optional)
 * @param max - Maximum value (optional)
 * @returns Validated number
 * @throws HttpsError if not a valid number or out of range
 */
export function sanitizeNumber(
  input: number | undefined,
  min?: number,
  max?: number
): number {
  if (input === undefined || input === null) {
    throw new functions.https.HttpsError(
      'invalid-argument',
      'Number is required'
    );
  }

  if (typeof input !== 'number' || isNaN(input)) {
    throw new functions.https.HttpsError(
      'invalid-argument',
      'Invalid number'
    );
  }

  if (min !== undefined && input < min) {
    throw new functions.https.HttpsError(
      'invalid-argument',
      `Number must be at least ${min}`
    );
  }

  if (max !== undefined && input > max) {
    throw new functions.https.HttpsError(
      'invalid-argument',
      `Number must be at most ${max}`
    );
  }

  return input;
}

/**
 * Validate array of strings and sanitize each element
 * @param input - Array of strings
 * @param maxItems - Maximum number of items (default: 100)
 * @param maxLength - Maximum length per item (default: 100)
 * @returns Sanitized array
 */
export function sanitizeStringArray(
  input: string[] | undefined,
  maxItems = 100,
  maxLength = 100
): string[] {
  if (!input || !Array.isArray(input)) {
    return [];
  }

  if (input.length > maxItems) {
    throw new functions.https.HttpsError(
      'invalid-argument',
      `Array must contain at most ${maxItems} items`
    );
  }

  return input.map(item => sanitizeString(item, maxLength)).filter(item => item.length > 0);
}

/**
 * Sanitize display name (allows Unicode characters for names in different languages)
 * @param input - Display name
 * @param maxLength - Maximum length (default: 100)
 * @returns Sanitized display name
 */
export function sanitizeDisplayName(input: string | undefined, maxLength = 100): string {
  if (!input) return '';

  // Trim but don't escape (to preserve Unicode characters)
  let sanitized = input.trim();

  // Remove control characters but preserve Unicode letters and marks
  sanitized = sanitized.replace(/[\x00-\x1F\x7F-\x9F]/g, '');

  // Enforce maximum length
  if (sanitized.length > maxLength) {
    sanitized = sanitized.substring(0, maxLength);
  }

  return sanitized;
}
