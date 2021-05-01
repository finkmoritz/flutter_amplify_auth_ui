import 'package:flutter_amplify_auth_ui/src/auth_config/auth_config.dart';
import 'package:flutter_amplify_auth_ui/src/template.dart';
import 'package:flutter_amplify_auth_ui/src/template_handlers/template_handler.dart';

class SignUpPageTemplateHandler extends TemplateHandler {
  static const List<String> configurableRequiredAttributes = [
    'email',
    'nickname',
  ];

  @override
  void modifyTemplate({required Template template, required AuthConfig authConfig}) {
    configurableRequiredAttributes.forEach((attribute) {
      if(!authConfig.requiredAttributes.contains(attribute)) {
        template.remove(identifier: 'requiredAttributes[$attribute]');
      }
    });
  }
}
