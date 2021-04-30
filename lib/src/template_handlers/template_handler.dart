import 'package:flutter_amplify_auth_ui/src/auth_config/auth_config.dart';
import 'package:flutter_amplify_auth_ui/src/template.dart';

abstract class TemplateHandler {
  void modifyTemplate({
    required Template template,
    required AuthConfig authConfig,
  });
}
