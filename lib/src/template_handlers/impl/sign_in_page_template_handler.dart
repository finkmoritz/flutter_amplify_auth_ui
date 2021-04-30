import 'package:flutter_amplify_auth_ui/src/auth_config/auth_config.dart';
import 'package:flutter_amplify_auth_ui/src/template.dart';
import 'package:flutter_amplify_auth_ui/src/template_handlers/template_handler.dart';

class SignInPageTemplateHandler extends TemplateHandler {
  @override
  void modifyTemplate({required Template template, required AuthConfig authConfig}) {
    if(!authConfig.allowUnauthenticatedIdentities) {
      template.remove(identifier: 'allowUnauthenticatedIdentities');
    }
  }
}
