import 'dart:io';

import 'package:flutter_amplify_auth_ui/src/util/command_line.dart';

import 'package:path/path.dart' as path;

import 'auth_config/auth_config.dart';

class FlutterAmplifyAuthUIGenerator {
  static const String signInPageName = 'sign_in_page';

  static void generateClassesFromConfig({
    required AuthConfig authConfig,
    required String targetDir
  }) {
    _createTargetDir(targetDir: targetDir);

    CommandLine.printInfo('Generating classes...');
    _generateSignInPage(targetDir: targetDir);
    CommandLine.printSuccess('Successfully generated classes from Amplify configuration!');
  }

  static void _createTargetDir({required String targetDir}) {
    var dir = Directory(targetDir);
    if(!dir.existsSync()) {
      dir.createSync();
    }
  }

  static void _generateSignInPage({required String targetDir}) {
    var filePath = path.join(targetDir, '$signInPageName.dart');
    var file = File(filePath);
    file.createSync();
    var template = _readTemplate(name: signInPageName);
    file.writeAsStringSync(template);
    CommandLine.printInfo('Successfully generated $filePath');
  }

  static String _readTemplate({required String name}) {
    var file = File(path.join('./templates' , '$name.template'));
    return file.readAsStringSync();
  }
}
