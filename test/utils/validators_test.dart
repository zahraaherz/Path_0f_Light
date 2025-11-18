import 'package:flutter_test/flutter_test.dart';
import 'package:path_of_light/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:path_of_light/utils/validators.dart';

void main() {
  late AppLocalizations l10n;

  setUpAll(() async {
    // Initialize localizations for testing
    l10n = await AppLocalizations.delegate.load(const Locale('en'));
  });

  group('Validators - Email', () {
    test('should accept valid email addresses', () {
      expect(Validators.email('test@example.com', l10n), isNull);
      expect(Validators.email('user.name+tag@example.co.uk', l10n), isNull);
      expect(Validators.email('test123@test-domain.com', l10n), isNull);
    });

    test('should reject invalid email addresses', () {
      expect(Validators.email('invalid.email', l10n), isNotNull);
      expect(Validators.email('@example.com', l10n), isNotNull);
      expect(Validators.email('test@', l10n), isNotNull);
      expect(Validators.email('test @example.com', l10n), isNotNull);
    });

    test('should reject empty email', () {
      expect(Validators.email('', l10n), isNotNull);
      expect(Validators.email(null, l10n), isNotNull);
    });
  });

  group('Validators - Password', () {
    test('should accept passwords with minimum 8 characters by default', () {
      expect(Validators.password('12345678', l10n), isNull);
      expect(Validators.password('abcdefgh', l10n), isNull);
      expect(Validators.password('Test1234', l10n), isNull);
    });

    test('should reject passwords shorter than 8 characters', () {
      expect(Validators.password('1234567', l10n), isNotNull);
      expect(Validators.password('abc', l10n), isNotNull);
      expect(Validators.password('12345', l10n), isNotNull);
    });

    test('should reject empty password', () {
      expect(Validators.password('', l10n), isNotNull);
      expect(Validators.password(null, l10n), isNotNull);
    });

    test('should accept custom minimum length', () {
      expect(Validators.password('12345', l10n, minLength: 5), isNull);
      expect(Validators.password('1234', l10n, minLength: 5), isNotNull);
    });
  });

  group('Validators - Strong Password', () {
    test('should accept strong passwords', () {
      expect(Validators.strongPassword('Test1234!', l10n), isNull);
      expect(Validators.strongPassword('MyP@ssw0rd', l10n), isNull);
      expect(Validators.strongPassword('Secure#123', l10n), isNull);
    });

    test('should reject password without uppercase', () {
      expect(Validators.strongPassword('test1234!', l10n), isNotNull);
    });

    test('should reject password without lowercase', () {
      expect(Validators.strongPassword('TEST1234!', l10n), isNotNull);
    });

    test('should reject password without number', () {
      expect(Validators.strongPassword('TestPassword!', l10n), isNotNull);
    });

    test('should reject password without special character', () {
      expect(Validators.strongPassword('Test1234', l10n), isNotNull);
    });

    test('should reject password shorter than 8 characters', () {
      expect(Validators.strongPassword('Test1!', l10n), isNotNull);
    });
  });

  group('Validators - Confirm Password', () {
    test('should accept matching passwords', () {
      expect(
        Validators.confirmPassword('Test1234', 'Test1234', l10n),
        isNull,
      );
    });

    test('should reject non-matching passwords', () {
      expect(
        Validators.confirmPassword('Test1234', 'Different123', l10n),
        isNotNull,
      );
    });

    test('should reject empty confirmation', () {
      expect(
        Validators.confirmPassword('', 'Test1234', l10n),
        isNotNull,
      );
      expect(
        Validators.confirmPassword(null, 'Test1234', l10n),
        isNotNull,
      );
    });
  });

  group('Validators - Display Name', () {
    test('should accept valid display names', () {
      expect(Validators.displayName('John Doe', l10n), isNull);
      expect(Validators.displayName('محمد علي', l10n), isNull);
      expect(Validators.displayName('Al-Hassan', l10n), isNull);
    });

    test('should reject names that are too short', () {
      expect(Validators.displayName('A', l10n), isNotNull);
    });

    test('should reject names that are too long', () {
      final longName = 'A' * 51;
      expect(Validators.displayName(longName, l10n), isNotNull);
    });

    test('should reject empty names', () {
      expect(Validators.displayName('', l10n), isNotNull);
      expect(Validators.displayName(null, l10n), isNotNull);
    });
  });

  group('Validators - Username', () {
    test('should accept valid usernames', () {
      expect(Validators.username('john_doe', l10n), isNull);
      expect(Validators.username('user123', l10n), isNull);
      expect(Validators.username('test_user', l10n), isNull);
    });

    test('should reject usernames not starting with letter', () {
      expect(Validators.username('123user', l10n), isNotNull);
      expect(Validators.username('_user', l10n), isNotNull);
    });

    test('should reject usernames with invalid characters', () {
      expect(Validators.username('user-name', l10n), isNotNull);
      expect(Validators.username('user name', l10n), isNotNull);
      expect(Validators.username('user@name', l10n), isNotNull);
    });

    test('should reject usernames that are too short or too long', () {
      expect(Validators.username('ab', l10n), isNotNull);
      final longUsername = 'a' * 21;
      expect(Validators.username(longUsername, l10n), isNotNull);
    });
  });

  group('Validators - URL', () {
    test('should accept valid URLs', () {
      expect(Validators.url('https://example.com', l10n), isNull);
      expect(Validators.url('http://test.org/path', l10n), isNull);
    });

    test('should reject invalid URLs', () {
      expect(Validators.url('not-a-url', l10n), isNotNull);
      expect(Validators.url('ftp://example.com', l10n), isNotNull);
    });

    test('should accept empty URL when not required', () {
      expect(Validators.url('', l10n), isNull);
      expect(Validators.url(null, l10n), isNull);
    });
  });

  group('Validators - Required Field', () {
    test('should accept non-empty values', () {
      expect(Validators.required('test', l10n), isNull);
      expect(Validators.required('123', l10n), isNull);
    });

    test('should reject empty values', () {
      expect(Validators.required('', l10n), isNotNull);
      expect(Validators.required('   ', l10n), isNotNull);
      expect(Validators.required(null, l10n), isNotNull);
    });
  });

  group('Validators - Number', () {
    test('should accept valid numbers', () {
      expect(Validators.number('123', l10n), isNull);
      expect(Validators.number('45.67', l10n), isNull);
      expect(Validators.number('-10', l10n), isNull);
    });

    test('should reject invalid numbers', () {
      expect(Validators.number('abc', l10n), isNotNull);
      expect(Validators.number('12.34.56', l10n), isNotNull);
    });

    test('should validate number range', () {
      expect(Validators.number('5', l10n, min: 1, max: 10), isNull);
      expect(Validators.number('0', l10n, min: 1, max: 10), isNotNull);
      expect(Validators.number('11', l10n, min: 1, max: 10), isNotNull);
    });
  });

  group('Validators - Arabic Text', () {
    test('should accept text with Arabic characters', () {
      expect(Validators.arabicText('السلام عليكم', l10n), isNull);
      expect(Validators.arabicText('مرحبا', l10n), isNull);
    });

    test('should reject text without Arabic characters', () {
      expect(Validators.arabicText('Hello World', l10n), isNotNull);
      expect(Validators.arabicText('123', l10n), isNotNull);
    });
  });
}
