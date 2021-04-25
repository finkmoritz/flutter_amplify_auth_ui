class AuthConfig {
  final bool allowUnauthenticatedIdentities;
  final List<String> requiredAttributes;

  const AuthConfig({required this.allowUnauthenticatedIdentities, required this.requiredAttributes});

  static AuthConfig fromJson(dynamic json) {
    return AuthConfig(
      allowUnauthenticatedIdentities: json['allowUnauthenticatedIdentities'],
      requiredAttributes: List<String>.from(json['requiredAttributes']),
    );
  }

  @override
  String toString() {
    return '''
    "allowUnauthenticatedIdentities": $allowUnauthenticatedIdentities,
    "requiredAttributes": $requiredAttributes,
    ''';
  }
}
