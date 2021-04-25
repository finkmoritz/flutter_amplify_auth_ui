class AuthConfig {
  final bool allowUnauthenticatedIdentities;
  final List<String> requiredAttributes;

  const AuthConfig({required this.allowUnauthenticatedIdentities, required this.requiredAttributes});

  @override
  String toString() {
    return '''
    "allowUnauthenticatedIdentities": $allowUnauthenticatedIdentities,
    "requiredAttributes": $requiredAttributes,
    ''';
  }
}
