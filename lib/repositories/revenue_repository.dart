import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';

/// Repository for secure, backend-calculated revenue analytics
///
/// All revenue calculations are performed on the server to prevent
/// client-side manipulation and ensure data integrity.
class RevenueRepository {
  final FirebaseFunctions _functions;

  RevenueRepository({FirebaseFunctions? functions})
      : _functions = functions ?? FirebaseFunctions.instance;

  /// Get total revenue across all users (Admin only)
  ///
  /// Returns revenue calculated from purchase_history in Firestore
  /// which is populated by RevenueCat webhooks (source of truth)
  Future<Map<String, dynamic>> getTotalRevenue() async {
    try {
      final result = await _functions.httpsCallable('getTotalRevenue').call();

      return {
        'totalRevenue': result.data['totalRevenue'] ?? 0.0,
        'activePurchasesCount': result.data['activePurchasesCount'] ?? 0,
        'currencies': result.data['currencies'] ?? {},
        'timestamp': result.data['timestamp'],
      };
    } catch (e) {
      debugPrint('Error getting total revenue: $e');
      rethrow;
    }
  }

  /// Get user's lifetime value (LTV)
  ///
  /// This is the authoritative backend calculation from RevenueCat webhooks.
  /// Users can access their own data, admins can access any user's data.
  Future<Map<String, dynamic>> getUserLifetimeValue({String? userId}) async {
    try {
      final result = await _functions.httpsCallable('getUserLifetimeValue').call({
        if (userId != null) 'userId': userId,
      });

      return {
        'userId': result.data['userId'],
        'lifetimeValue': result.data['lifetimeValue'] ?? 0.0,
        'totalPurchases': result.data['totalPurchases'] ?? 0,
        'currency': result.data['currency'] ?? 'USD',
        'isPremium': result.data['isPremium'] ?? false,
        'purchaseDetails': result.data['purchaseDetails'] ?? [],
      };
    } catch (e) {
      debugPrint('Error getting user lifetime value: $e');
      rethrow;
    }
  }

  /// Get comprehensive revenue metrics (Admin only)
  ///
  /// Returns dashboard analytics including:
  /// - Total revenue
  /// - Active subscriptions
  /// - Lifetime revenue
  /// - Monthly recurring revenue (MRR)
  /// - Average revenue per user (ARPU)
  Future<RevenueMetrics> getRevenueMetrics() async {
    try {
      final result = await _functions.httpsCallable('getRevenueMetrics').call();

      return RevenueMetrics.fromJson(result.data as Map<String, dynamic>);
    } catch (e) {
      debugPrint('Error getting revenue metrics: $e');
      rethrow;
    }
  }

  /// Get top revenue users (Admin only)
  ///
  /// Returns a list of highest-value customers for analytics
  Future<List<UserRevenueData>> getTopRevenueUsers({int limit = 10}) async {
    try {
      final result = await _functions.httpsCallable('getTopRevenueUsers').call({
        'limit': limit,
      });

      final users = result.data['users'] as List;
      return users
          .map((user) => UserRevenueData.fromJson(user as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint('Error getting top revenue users: $e');
      rethrow;
    }
  }

  /// Get revenue by time period (Admin only)
  ///
  /// Useful for trend analysis and reporting
  Future<Map<String, dynamic>> getRevenueByPeriod({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final result = await _functions.httpsCallable('getRevenueByPeriod').call({
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
      });

      return {
        'totalRevenue': result.data['totalRevenue'] ?? 0.0,
        'purchaseCount': result.data['purchaseCount'] ?? 0,
        'revenueByDay': result.data['revenueByDay'] ?? {},
        'period': result.data['period'],
      };
    } catch (e) {
      debugPrint('Error getting revenue by period: $e');
      rethrow;
    }
  }

  /// Recalculate user lifetime value (Admin only)
  ///
  /// Use this for data integrity checks or to fix discrepancies
  Future<Map<String, dynamic>> recalculateUserLTV(String userId) async {
    try {
      final result = await _functions.httpsCallable('recalculateUserLTV').call({
        'userId': userId,
      });

      return {
        'userId': result.data['userId'],
        'recalculatedLTV': result.data['recalculatedLTV'] ?? 0.0,
        'totalPurchases': result.data['totalPurchases'] ?? 0,
        'message': result.data['message'],
      };
    } catch (e) {
      debugPrint('Error recalculating user LTV: $e');
      rethrow;
    }
  }
}

/// Revenue metrics model
class RevenueMetrics {
  final double totalRevenue;
  final int activeSubscriptions;
  final double lifetimeRevenue;
  final double monthlyRecurringRevenue;
  final double averageRevenuePerUser;
  final String currency;

  RevenueMetrics({
    required this.totalRevenue,
    required this.activeSubscriptions,
    required this.lifetimeRevenue,
    required this.monthlyRecurringRevenue,
    required this.averageRevenuePerUser,
    required this.currency,
  });

  factory RevenueMetrics.fromJson(Map<String, dynamic> json) {
    return RevenueMetrics(
      totalRevenue: (json['totalRevenue'] as num?)?.toDouble() ?? 0.0,
      activeSubscriptions: json['activeSubscriptions'] as int? ?? 0,
      lifetimeRevenue: (json['lifetimeRevenue'] as num?)?.toDouble() ?? 0.0,
      monthlyRecurringRevenue:
          (json['monthlyRecurringRevenue'] as num?)?.toDouble() ?? 0.0,
      averageRevenuePerUser:
          (json['averageRevenuePerUser'] as num?)?.toDouble() ?? 0.0,
      currency: json['currency'] as String? ?? 'USD',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalRevenue': totalRevenue,
      'activeSubscriptions': activeSubscriptions,
      'lifetimeRevenue': lifetimeRevenue,
      'monthlyRecurringRevenue': monthlyRecurringRevenue,
      'averageRevenuePerUser': averageRevenuePerUser,
      'currency': currency,
    };
  }
}

/// User revenue data model
class UserRevenueData {
  final String userId;
  final double lifetimeValue;
  final int totalPurchases;
  final bool activeSubscription;
  final DateTime? lastPurchaseDate;
  final String currency;

  UserRevenueData({
    required this.userId,
    required this.lifetimeValue,
    required this.totalPurchases,
    required this.activeSubscription,
    this.lastPurchaseDate,
    required this.currency,
  });

  factory UserRevenueData.fromJson(Map<String, dynamic> json) {
    return UserRevenueData(
      userId: json['userId'] as String,
      lifetimeValue: (json['lifetimeValue'] as num?)?.toDouble() ?? 0.0,
      totalPurchases: json['totalPurchases'] as int? ?? 0,
      activeSubscription: json['activeSubscription'] as bool? ?? false,
      lastPurchaseDate: json['lastPurchaseDate'] != null
          ? DateTime.parse(json['lastPurchaseDate'] as String)
          : null,
      currency: json['currency'] as String? ?? 'USD',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'lifetimeValue': lifetimeValue,
      'totalPurchases': totalPurchases,
      'activeSubscription': activeSubscription,
      'lastPurchaseDate': lastPurchaseDate?.toIso8601String(),
      'currency': currency,
    };
  }
}
