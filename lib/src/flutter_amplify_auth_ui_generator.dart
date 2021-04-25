import 'dart:io';

import 'package:flutter_amplify_auth_ui/src/util/command_line.dart';

import 'package:path/path.dart' as path;

import 'auth_config/auth_config.dart';

class FlutterAmplifyAuthUIGenerator {
  static void generateClassesFromConfig({
    required AuthConfig authConfig,
    required String targetDir
  }) {
    Directory(targetDir).createSync();

    CommandLine.printInfo('Generating classes...');
    _generateClassFromTemplate(targetDir: targetDir, templateName: 'sign_in_page');
    CommandLine.printSuccess('Successfully generated classes from Amplify configuration!');
  }

  static void _generateClassFromTemplate({
    required String targetDir,
    required String templateName,
    String Function(String)? modifier,
  }) {
    var filePath = path.join(targetDir, '$templateName.dart');
    var file = File(filePath);
    file.createSync();
    var template = _readTemplate(name: templateName);
    if(modifier != null) {
      template = modifier(template);
    }
    file.writeAsStringSync(template);
    CommandLine.printInfo('Successfully generated $filePath');
  }

  static String _readTemplate({required String name}) {
    var file = File(path.join('./templates' , '$name.template'));
    return file.readAsStringSync();
  }
}
