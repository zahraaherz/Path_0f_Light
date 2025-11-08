/// Authentication providers
enum AuthProvider {
  email('password'),
  google('google.com'),
  apple('apple.com'),
  facebook('facebook.com'),
  phone('phone');

  final String value;
  const AuthProvider(this.value);

  static AuthProvider fromString(String value) {
    return AuthProvider.values.firstWhere(
      (provider) => provider.value == value,
      orElse: () => AuthProvider.email,
    );
  }
}
