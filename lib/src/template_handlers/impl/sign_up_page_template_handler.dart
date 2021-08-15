import 'package:flutter_amplify_auth_ui/src/auth_config/auth_config.dart';
import 'package:flutter_amplify_auth_ui/src/template.dart';
import 'package:flutter_amplify_auth_ui/src/template_handlers/template_handler.dart';

class SignUpPageTemplateHandler extends TemplateHandler {
  static const List<String> configurableRequiredAttributes = [
    'address',
    'birthdate',
    'email',
    'family_name',
    'gender',
    'given_name',
    'middle_name',
    'name',
    'nickname',
    'phone_number',
    'preferred_username',
    'profile',
    'picture',
    'updated_at',
    'website',
  ];
  static const List<String> configurableUsernameAttributes = [
    'email',
    'phone_number',
  ];

  @override
  void modifyTemplate(
      {required Template template, required AuthConfig authConfig}) {
    _handleRequiredAttributes(template: template, authConfig: authConfig);
    _handleUsernameAttributes(template: template, authConfig: authConfig);
  }

  void _handleRequiredAttributes(
      {required Template template, required AuthConfig authConfig}) {
    var requiredAttributes = authConfig.requiredAttributes;
    if (authConfig.mfaConfiguration == 'ON' &&
        authConfig.mfaTypes.contains('SMS Text Message')) {
      requiredAttributes.add('phone_number');
    }
    configurableRequiredAttributes.forEach((attribute) {
      if (!requiredAttributes.contains(attribute)) {
        template.remove(identifier: 'requiredAttributes[$attribute]');
      }
    });
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
