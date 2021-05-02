class AuthConfig {
  final bool allowUnauthenticatedIdentities;
  final List<String> requiredAttributes;
  final List<String> usernameAttributes;
  final List<String> authProvidersUserPool;

  const AuthConfig({
    required this.allowUnauthenticatedIdentities,
    required this.requiredAttributes,
    required this.usernameAttributes,
    required this.authProvidersUserPool,
  });

  static AuthConfig fromJson(dynamic json) {
    return AuthConfig(
      allowUnauthenticatedIdentities: json['allowUnauthenticatedIdentities'],
      requiredAttributes: _getAsList(json,'requiredAttributes'),
      usernameAttributes: _getAsList(json,'usernameAttributes'),
      authProvidersUserPool: _getAsList(json, 'authProvidersUserPool'),
    );
  }

  static List<String> _getAsList(dynamic json, String key) {
    return List<String>.from(json[key] ?? Iterable.empty());
  }

  @override
  String toString() {
    return '''
    "allowUnauthenticatedIdentities": $allowUnauthenticatedIdentities,
    "requiredAttributes": $requiredAttributes,
    "usernameAttributes": $usernameAttributes,
    "authProvidersUserPool": $authProvidersUserPool,
    ''';
  }
}
