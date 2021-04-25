import 'package:flutter_amplify_auth_ui/src/flutter_amplify_auth_ui_generator.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    FlutterAmplifyAuthUIGenerator? generator;

    setUp(() {
      generator = FlutterAmplifyAuthUIGenerator();
    });

    test('First Test', () {
      expect(generator, isNotNull);
    });
  });
}
