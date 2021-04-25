import 'package:flutter_amplify_auth_ui/src/util/command_line.dart';

class FlutterAmplifyAuthUiException implements Exception {
  String message;

  FlutterAmplifyAuthUiException(this.message) {
    CommandLine.printError(message);
  }
}
