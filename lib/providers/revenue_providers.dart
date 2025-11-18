import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/revenue_repository.dart';
import 'auth_providers.dart';

/// Provider for the RevenueRepository instance
final revenueRepositoryProvider = Provider<RevenueRepository>((ref) {
  return RevenueRepository();
});

/// Provider for user's lifetime value (LTV)
///
/// This is the secure, backend-calculated LTV from RevenueCat webhooks.
/// Automatically uses the authenticated user's ID.
final userLifetimeValueProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final authState = ref.watch(authStateProvider);
  final repository = ref.watch(revenueRepositoryProvider);

  return authState.when(
    data: (user) async {
      if (user == null) {
        return {
          'userId': null,
          'lifetimeValue': 0.0,
          'totalPurchases': 0,
          'currency': 'USD',
          'isPremium': false,
          'purchaseDetails': [],
        };
      }
      return await repository.getUserLifetimeValue();
    },
    loading: () async => {
      'userId': null,
      'lifetimeValue': 0.0,
      'totalPurchases': 0,
      'currency': 'USD',
      'isPremium': false,
      'purchaseDetails': [],
    },
    error: (_, __) async => {
      'userId': null,
      'lifetimeValue': 0.0,
      'totalPurchases': 0,
      'currency': 'USD',
      'isPremium': false,
      'purchaseDetails': [],
    },
  );
});

/// Provider for specific user's lifetime value (Admin only)
///
/// Use this when you need to query a specific user's LTV (e.g., admin dashboard)
final specificUserLifetimeValueProvider =
    FutureProvider.family<Map<String, dynamic>, String>((ref, userId) async {
  final repository = ref.watch(revenueRepositoryProvider);
  return await repository.getUserLifetimeValue(userId: userId);
});

/// Provider for total revenue metrics (Admin only)
///
/// This is the secure, backend-calculated total revenue across all users.
final totalRevenueProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final repository = ref.watch(revenueRepositoryProvider);
  return await repository.getTotalRevenue();
});

/// Provider for comprehensive revenue metrics (Admin only)
///
/// Includes:
/// - Total revenue
/// - Active subscriptions
/// - Lifetime revenue
/// - Monthly recurring revenue (MRR)
/// - Average revenue per user (ARPU)
final revenueMetricsProvider = FutureProvider<RevenueMetrics>((ref) async {
  final repository = ref.watch(revenueRepositoryProvider);
  return await repository.getRevenueMetrics();
});

/// Provider for top revenue users (Admin only)
///
/// Returns highest-value customers for analytics
final topRevenueUsersProvider =
    FutureProvider.family<List<UserRevenueData>, int>((ref, limit) async {
  final repository = ref.watch(revenueRepositoryProvider);
  return await repository.getTopRevenueUsers(limit: limit);
});

/// Provider for revenue by time period (Admin only)
///
/// Useful for trend analysis and reporting
final revenueByPeriodProvider = FutureProvider.family<
    Map<String, dynamic>,
    Map<String, DateTime>>((ref, period) async {
  final repository = ref.watch(revenueRepositoryProvider);
  return await repository.getRevenueByPeriod(
    startDate: period['startDate']!,
    endDate: period['endDate']!,
  );
});

/// Controller for revenue operations
final revenueControllerProvider = Provider<RevenueController>((ref) {
  final repository = ref.watch(revenueRepositoryProvider);
  return RevenueController(
    repository: repository,
    ref: ref,
  );
});

/// Controller class for handling revenue operations
class RevenueController {
  final RevenueRepository repository;
  final Ref ref;

  RevenueController({
    required this.repository,
    required this.ref,
  });

  /// Get current user's lifetime value
  Future<double> getMyLifetimeValue() async {
    try {
      final result = await repository.getUserLifetimeValue();
      return result['lifetimeValue'] as double? ?? 0.0;
    } catch (e) {
      print('Error getting user lifetime value: $e');
      return 0.0;
    }
  }

  /// Get total revenue (Admin only)
  Future<double> getTotalRevenue() async {
    try {
      final result = await repository.getTotalRevenue();
      return result['totalRevenue'] as double? ?? 0.0;
    } catch (e) {
      print('Error getting total revenue: $e');
      rethrow;
    }
  }

  /// Get revenue metrics (Admin only)
  Future<RevenueMetrics> getRevenueMetrics() async {
    try {
      return await repository.getRevenueMetrics();
    } catch (e) {
      print('Error getting revenue metrics: $e');
      rethrow;
    }
  }

  /// Get top revenue users (Admin only)
  Future<List<UserRevenueData>> getTopRevenueUsers({int limit = 10}) async {
    try {
      return await repository.getTopRevenueUsers(limit: limit);
    } catch (e) {
      print('Error getting top revenue users: $e');
      rethrow;
    }
  }

  /// Get revenue for specific period (Admin only)
  Future<Map<String, dynamic>> getRevenueByPeriod({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      return await repository.getRevenueByPeriod(
        startDate: startDate,
        endDate: endDate,
      );
    } catch (e) {
      print('Error getting revenue by period: $e');
      rethrow;
    }
  }

  /// Recalculate user LTV (Admin only)
  Future<Map<String, dynamic>> recalculateUserLTV(String userId) async {
    try {
      final result = await repository.recalculateUserLTV(userId);

      // Invalidate relevant providers to refresh data
      ref.invalidate(userLifetimeValueProvider);
      ref.invalidate(specificUserLifetimeValueProvider(userId));

      return result;
    } catch (e) {
      print('Error recalculating user LTV: $e');
      rethrow;
    }
  }

  /// Refresh all revenue data
  void refreshAll() {
    ref.invalidate(userLifetimeValueProvider);
    ref.invalidate(totalRevenueProvider);
    ref.invalidate(revenueMetricsProvider);
  }
}
