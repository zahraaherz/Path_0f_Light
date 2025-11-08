/// User roles for access control
enum UserRole {
  user('user'),
  scholar('scholar'),
  admin('admin'),
  moderator('moderator');

  final String value;
  const UserRole(this.value);

  static UserRole fromString(String value) {
    return UserRole.values.firstWhere(
      (role) => role.value == value,
      orElse: () => UserRole.user,
    );
  }
}
