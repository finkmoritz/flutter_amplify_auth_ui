import 'dart:io';

import 'package:flutter_amplify_auth_ui/src/auth_config/auth_config_reader.dart';
import 'package:flutter_amplify_auth_ui/src/util/command_line.dart';

import 'package:path/path.dart' as path;

import 'auth_config/auth_config.dart';

class FlutterAmplifyAuthUIGenerator {
  static const String signInPageName = 'sign_in_page';

  static void generateClassesFromConfig({
    required String amplifyDir,
    required String targetDir
  }) {
    var authConfig = AuthConfigReader.readAuthConfig(amplifyDir: amplifyDir);
    CommandLine.printInfo('Amplify configuration:\n$authConfig');

    _cleanUpTargetDir(targetDir: targetDir);
    _generateClasses(authConfig: authConfig, targetDir: targetDir);

    CommandLine.printSuccess('Successfully generated classes from Amplify configuration!');
  }

  static void _generateClasses({
    required AuthConfig authConfig,
    required String targetDir
  }) {
    CommandLine.printMessage('Generating classes into target directory: "$targetDir"');
    _generateSignInPage(targetDir: targetDir);
  }

  static void _cleanUpTargetDir({required String targetDir}) {
    CommandLine.printMessage('Cleaning up the target directory: "$targetDir"');
    var dir = Directory(targetDir);
    if(dir.existsSync()) {
      dir.deleteSync(recursive: true);
    }
    dir.createSync();
  }

  static void _generateSignInPage({required String targetDir}) {
    var template = _readTemplate(name: signInPageName);
    var file = File(path.join(targetDir, '$signInPageName.dart'));
    file.createSync();
    file.writeAsStringSync(template);
  }

  static String _readTemplate({required String name}) {
    var file = File(path.join('./templates' , '$name.template'));
    return file.readAsStringSync();
  }
}
