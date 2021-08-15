import 'package:flutter_amplify_auth_ui/src/auth_config/auth_config.dart';
import 'package:flutter_amplify_auth_ui/src/template.dart';
import 'package:flutter_amplify_auth_ui/src/template_handlers/template_handler.dart';

class SignInPageTemplateHandler extends TemplateHandler {
  static const List<String> configurableUsernameAttributes = [
    'email',
    'phone_number',
  ];
  static const List<String> configurableAuthProviders = [
    'graph.facebook.com',
    'accounts.google.com',
    'www.amazon.com',
  ];

  @override
  void modifyTemplate(
      {required Template template, required AuthConfig authConfig}) {
    _handleUsernameAttributes(template: template, authConfig: authConfig);
    _handleGuestSignIn(template: template, authConfig: authConfig);
    _handleSignInWithWebUI(template: template, authConfig: authConfig);
    _handleMfa(template: template, authConfig: authConfig);
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

  void _handleGuestSignIn(
      {required Template template, required AuthConfig authConfig}) {
    if (!authConfig.allowUnauthenticatedIdentities) {
      template.remove(identifier: 'allowUnauthenticatedIdentities');
    }
  }

  void _handleSignInWithWebUI(
      {required Template template, required AuthConfig authConfig}) {
    configurableAuthProviders.forEach((provider) {
      if (!authConfig.authProviders.contains(provider)) {
        template.remove(identifier: 'authProvidersUserPool[$provider]');
      }
    });
    if (authConfig.authProviders.isEmpty) {
      template.remove(identifier: 'authProvidersUserPool[any]');
    }
  }

  void _handleMfa(
      {required Template template, required AuthConfig authConfig}) {
    var reverseFlag = authConfig.mfaConfiguration == 'ON' ? 'OFF' : 'ON';
    template.remove(identifier: 'mfaConfiguration[$reverseFlag]');
  }
}
