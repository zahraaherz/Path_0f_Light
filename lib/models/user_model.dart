import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String email;
  final String displayName;
  final String? photoUrl;
  final String preferredLanguage;
  final DateTime createdAt;
  final DateTime lastLoginAt;
  final bool isActive;

  UserModel({
    required this.id,
    required this.email,
    required this.displayName,
    this.photoUrl,
    this.preferredLanguage = 'ar',
    required this.createdAt,
    required this.lastLoginAt,
    this.isActive = true,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      email: data['email'] ?? '',
      displayName: data['display_name'] ?? '',
      photoUrl: data['photo_url'],
      preferredLanguage: data['preferred_language'] ?? 'ar',
      createdAt: (data['created_at'] as Timestamp?)?.toDate() ?? DateTime.now(),
      lastLoginAt: (data['last_login_at'] as Timestamp?)?.toDate() ?? DateTime.now(),
      isActive: data['is_active'] ?? true,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
      'preferred_language': preferredLanguage,
      'created_at': Timestamp.fromDate(createdAt),
      'last_login_at': Timestamp.fromDate(lastLoginAt),
      'is_active': isActive,
    };
  }
}
