import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/guest_access_service.dart';

/// Guest access service provider
final guestAccessServiceProvider = Provider<GuestAccessService>((ref) {
  return GuestAccessService();
});

/// Check if current user is a guest
final isGuestUserProvider = Provider<bool>((ref) {
  final service = ref.watch(guestAccessServiceProvider);
  return service.isGuestUser;
});

/// Guest session statistics
final guestStatsProvider = FutureProvider<GuestSessionStats>((ref) async {
  final service = ref.watch(guestAccessServiceProvider);
  return service.getGuestStats();
});

/// Whether to show upgrade prompt
final shouldShowUpgradePromptProvider = FutureProvider<bool>((ref) async {
  final service = ref.watch(guestAccessServiceProvider);
  return service.shouldPromptUpgrade();
});

/// Personalized upgrade message
final upgradeMessageProvider = FutureProvider<String>((ref) async {
  final service = ref.watch(guestAccessServiceProvider);
  return service.getUpgradeMessage();
});
