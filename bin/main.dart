import 'package:flutter_amplify_auth_ui/src/flutter_amplify_auth_ui_generator.dart';
import 'package:flutter_amplify_auth_ui/src/util/command_line.dart';

void main(List<String> args) {
  CommandLine.printHeader();

  var amplifyDir = CommandLine.readArg(args, '--amplifyDir') ?? './amplify/';
  var targetDir = CommandLine.readArg(args, '--targetDir') ?? './lib/generated_auth_classes/';

  CommandLine.printInfo('Using following parameters:');
  CommandLine.printInfo('\t--amplifyDir=$amplifyDir');
  CommandLine.printInfo('\t--targetDir=$targetDir\n');

  FlutterAmplifyAuthUIGenerator.generateClassesFromConfig(
    amplifyDir: amplifyDir,
    targetDir: targetDir,
  );
}


