import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:yaml/yaml.dart';

import 'auth_config.dart';

class AuthConfigReader {
  static const String pathToYaml = 'backend/awscloudformation/nested-cloudformation-stack.yml';
  
  static AuthConfig readAuthConfig({required String amplifyDir}) {
    var file = File(path.join(amplifyDir, pathToYaml));
    var config = loadYaml(file.readAsStringSync());
    var authParams = _findAuthParams(yamlString: config);
    return AuthConfig(
      allowUnauthenticatedIdentities: authParams['allowUnauthenticatedIdentities'],
      requiredAttributes: [authParams['requiredAttributes']]
    );
  }

  static dynamic _findAuthParams({dynamic yamlString}) {
    for(dynamic key in yamlString['Resources'].keys) {
      if(key.startsWith('auth')) {
        return yamlString['Resources'][key]['Properties']['Parameters'];
      }
    }
    throw Exception('Could not locate auth parameters inside yaml file!');
  }
}
