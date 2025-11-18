import { describe, it, expect, beforeEach } from '@jest/globals';
import { RateLimiterMemory } from 'rate-limiter-flexible';
import * as functions from 'firebase-functions';

// Mock the rate limiter
describe('Rate Limiter', () => {
  let rateLimiter: RateLimiterMemory;

  beforeEach(() => {
    // Create a new rate limiter for each test
    rateLimiter = new RateLimiterMemory({
      points: 5,
      duration: 60,
    });
  });

  it('should allow requests within limit', async () => {
    const userId = 'test-user-1';

    // Should allow 5 requests
    for (let i = 0; i < 5; i++) {
      await expect(rateLimiter.consume(userId)).resolves.toBeDefined();
    }
  });

  it('should block requests exceeding limit', async () => {
    const userId = 'test-user-2';

    // Consume all points
    for (let i = 0; i < 5; i++) {
      await rateLimiter.consume(userId);
    }

    // 6th request should be blocked
    await expect(rateLimiter.consume(userId)).rejects.toThrow();
  });

  it('should track different users separately', async () => {
    const user1 = 'test-user-3';
    const user2 = 'test-user-4';

    // User 1 uses all points
    for (let i = 0; i < 5; i++) {
      await rateLimiter.consume(user1);
    }

    // User 2 should still have points available
    await expect(rateLimiter.consume(user2)).resolves.toBeDefined();
  });

  it('should reset points after duration', async () => {
    const userId = 'test-user-5';
    const quickLimiter = new RateLimiterMemory({
      points: 2,
      duration: 1, // 1 second
    });

    // Consume all points
    await quickLimiter.consume(userId);
    await quickLimiter.consume(userId);

    // Should be blocked immediately
    await expect(quickLimiter.consume(userId)).rejects.toThrow();

    // Wait for reset
    await new Promise(resolve => setTimeout(resolve, 1100));

    // Should work again
    await expect(quickLimiter.consume(userId)).resolves.toBeDefined();
  });
});

describe('Input Validation', () => {
  it('should sanitize HTML in strings', () => {
    const validator = require('validator');
    const input = '<script>alert("xss")</script>Hello';
    const sanitized = validator.escape(input);

    expect(sanitized).not.toContain('<script>');
    expect(sanitized).toContain('&lt;script&gt;');
  });

  it('should validate email addresses', () => {
    const validator = require('validator');

    expect(validator.isEmail('test@example.com')).toBe(true);
    expect(validator.isEmail('invalid.email')).toBe(false);
    expect(validator.isEmail('test @example.com')).toBe(false);
  });

  it('should validate URLs', () => {
    const validator = require('validator');

    expect(validator.isURL('https://example.com')).toBe(true);
    expect(validator.isURL('http://test.org/path')).toBe(true);
    expect(validator.isURL('not-a-url')).toBe(false);
    expect(validator.isURL('javascript:alert(1)')).toBe(false);
  });

  it('should trim whitespace', () => {
    const validator = require('validator');
    const input = '  test  ';
    const trimmed = validator.trim(input);

    expect(trimmed).toBe('test');
  });

  it('should enforce maximum string length', () => {
    const longString = 'a'.repeat(1000);
    const maxLength = 500;
    const truncated = longString.substring(0, maxLength);

    expect(truncated.length).toBe(maxLength);
  });
});
