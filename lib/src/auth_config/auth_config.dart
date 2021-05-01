class AuthConfig {
  final bool allowUnauthenticatedIdentities;
  final List<String> requiredAttributes;
  final List<String> usernameAttributes;

  const AuthConfig({
    required this.allowUnauthenticatedIdentities,
    required this.requiredAttributes,
    required this.usernameAttributes,
  });

  static AuthConfig fromJson(dynamic json) {
    return AuthConfig(
      allowUnauthenticatedIdentities: json['allowUnauthenticatedIdentities'],
      requiredAttributes: _getAsList(json,'requiredAttributes'),
      usernameAttributes: _getAsList(json,'usernameAttributes'),
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
    ''';
  }
}
