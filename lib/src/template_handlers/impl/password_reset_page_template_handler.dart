import 'package:flutter_amplify_auth_ui/src/auth_config/auth_config.dart';
import 'package:flutter_amplify_auth_ui/src/template.dart';
import 'package:flutter_amplify_auth_ui/src/template_handlers/template_handler.dart';

class PasswordResetPageTemplateHandler extends TemplateHandler {
  static const List<String> configurableUsernameAttributes = [
    'email',
    'phone_number',
  ];

  @override
  void modifyTemplate(
      {required Template template, required AuthConfig authConfig}) {
    _handleUsernameAttributes(template: template, authConfig: authConfig);
  }

  void _handleUsernameAttributes(
      {required Template template, required AuthConfig authConfig}) {
    if (authConfig.usernameAttributes.isEmpty) {
      configurableUsernameAttributes.forEach((attribute) {
        template.remove(identifier: 'usernameAttributes[$attribute]');
      });
    } else {
      template.remove(identifier: 'usernameAttributes[username]');
      configurableUsernameAttributes.forEach((attribute) {
        if (!authConfig.usernameAttributes.contains(attribute)) {
          template.remove(identifier: 'usernameAttributes[$attribute]');
        }
      });
    }
  }
}
