import 'dart:io';

import 'package:flutter_amplify_auth_ui/src/template.dart';
import 'package:flutter_amplify_auth_ui/src/template_handlers/impl/password_reset_page_template_handler.dart';
import 'package:flutter_amplify_auth_ui/src/template_handlers/impl/sign_in_page_template_handler.dart';
import 'package:flutter_amplify_auth_ui/src/template_handlers/impl/sign_up_page_template_handler.dart';
import 'package:flutter_amplify_auth_ui/src/template_handlers/template_handler.dart';
import 'package:flutter_amplify_auth_ui/src/util/command_line.dart';

import 'package:path/path.dart' as path;

import 'auth_config/auth_config.dart';

class FlutterAmplifyAuthUIGenerator {
  static void generateClassesFromConfig(
      {required AuthConfig authConfig, required String targetDir}) {
    Directory(targetDir).createSync();

    CommandLine.printMessage('Generating classes...');
    _generateClassFromTemplate(
      targetDir: targetDir,
      templateName: 'sign_in/sign_in_page.dart',
      templateHandler: SignInPageTemplateHandler(),
      authConfig: authConfig,
    );
    _generateClassFromTemplate(
      targetDir: targetDir,
      templateName: 'sign_up/sign_up_page.dart',
      templateHandler: SignUpPageTemplateHandler(),
      authConfig: authConfig,
    );
    _generateClassFromTemplate(
      targetDir: targetDir,
      templateName: 'password_management/password_reset_page.dart',
      templateHandler: PasswordResetPageTemplateHandler(),
      authConfig: authConfig,
    );
  }

  static Future<void> _generateClassFromTemplate({
    required String targetDir,
    required String templateName,
    TemplateHandler? templateHandler,
    AuthConfig? authConfig,
  }) async {
    var template = await Template.byName(templateName: templateName);
    if (templateHandler != null && authConfig != null) {
      templateHandler.modifyTemplate(
        template: template,
        authConfig: authConfig,
      );
    }
    template.removeAllIdentifiers();

    var filePath = path.join(targetDir, '$templateName');
    template.writeToFile(filePath: filePath);

    CommandLine.printInfo('Successfully generated $filePath');
  }
}
