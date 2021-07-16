import 'package:flutter_amplify_auth_ui/src/auth_config/auth_config_reader.dart';
import 'package:flutter_amplify_auth_ui/src/flutter_amplify_auth_ui_generator.dart';
import 'package:flutter_amplify_auth_ui/src/util/command_line.dart';

void main(List<String> args) {
  CommandLine.printHeader();

  var amplifyDir = CommandLine.readArg(args, '--amplifyDir') ?? './amplify/';
  var targetDir = CommandLine.readArg(args, '--targetDir') ??
      './lib/generated_auth_classes/';

  CommandLine.printMessage('Using following parameters:');
  CommandLine.printMessage('\t--amplifyDir=$amplifyDir');
  CommandLine.printMessage('\t--targetDir=$targetDir\n');

  var authConfig = AuthConfigReader.readAuthConfig(amplifyDir: amplifyDir);

  FlutterAmplifyAuthUIGenerator.generateClassesFromConfig(
    authConfig: authConfig,
    targetDir: targetDir,
  );
}
