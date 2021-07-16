import 'dart:convert';
import 'dart:io';

import 'package:flutter_amplify_auth_ui/src/util/command_line.dart';
import 'package:flutter_amplify_auth_ui/src/util/flutter_amplify_auth_ui_exception.dart';
import 'package:path/path.dart' as path;

import 'auth_config.dart';

class AuthConfigReader {
  static AuthConfig readAuthConfig({required String amplifyDir}) {
    var file = _findParametersJsonFile(amplifyDir: amplifyDir);
    var authConfig = AuthConfig.fromJson(json.decode(file.readAsStringSync()));
    CommandLine.printInfo(
        'Successfully read Amplify configuration:\n$authConfig');
    return authConfig;
  }

  static File _findParametersJsonFile({required String amplifyDir}) {
    var authDir = Directory(path.join(amplifyDir, 'backend', 'auth'));
    for (var file in authDir.listSync(recursive: true)) {
      if (file.path.endsWith('parameters.json')) {
        CommandLine.printMessage(
            'Reading Amplify Auth configuration from ${file.path}\n');
        return File(file.path);
      }
    }
    ;
    throw FlutterAmplifyAuthUiException('''
    Could not find "parameters.json"!
    Please check if you have already configured Amplify Auth for this project.''');
  }
}
