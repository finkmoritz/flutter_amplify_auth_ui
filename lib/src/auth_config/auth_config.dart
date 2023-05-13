class AuthConfig {
  final bool allowUnauthenticatedIdentities;
  final List<String> requiredAttributes;
  final List<String> usernameAttributes;
  final List<String> authProviders;
  final String mfaConfiguration;
  final List<String> mfaTypes;

  const AuthConfig({
    required this.allowUnauthenticatedIdentities,
    required this.requiredAttributes,
    required this.usernameAttributes,
    required this.authProviders,
    required this.mfaConfiguration,
    required this.mfaTypes,
  });

  static AuthConfig fromJson(dynamic json) {
    return AuthConfig(
      allowUnauthenticatedIdentities: json['allowUnauthenticatedIdentities'],
      requiredAttributes: _getAsList(json, 'requiredAttributes'),
      usernameAttributes: _getAsList(json, 'usernameAttributes'),
      authProviders: _getAsList(json, 'authProvidersUserPool'),
      mfaConfiguration: json['mfaConfiguration'],
      mfaTypes: _getAsList(json, 'mfaTypes'),
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
    "authProvidersUserPool": $authProviders,
    "mfaConfiguration": $mfaConfiguration,
    "mfaTypes": $mfaTypes,
    ''';
  }
}
