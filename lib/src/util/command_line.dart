import 'dart:math';

class CommandLine {
  static const String RESET = '\x1B[0m';

  static const String BLACK = '\x1B[30m';
  static const String RED = '\x1B[31m';
  static const String GREEN = '\x1B[32m';
  static const String YELLOW = '\x1B[33m';
  static const String BLUE = '\x1B[34m';

  static void printMessage(String s, {String? color}) {
    s = _prepend(s, 'MSG');
    if (color == null) {
      print(s);
    } else {
      print('$color$s$RESET');
    }
  }

  static void printError(String s) {
    s = _prepend(s, 'ERROR');
    print('$RED$s$RESET');
  }

  static void printWarning(String s) {
    s = _prepend(s, 'WARNING');
    print('$YELLOW$s$RESET');
  }

  static void printInfo(String s) {
    s = _prepend(s, 'INFO');
    print('$BLUE$s$RESET');
  }

  static void printSuccess(String s) {
    s = _prepend(s, 'SUCCESS');
    print('$GREEN$s$RESET');
  }

  static void printFancy(String s) {
    s = _prepend(s, 'MSG');
    var rand = Random();
    for (var i = s.length - 1; i >= 0; --i) {
      var r = rand.nextInt(6) + 1;
      s = '${s.substring(0, i)}\x1B[3${r}m${s.substring(i)}';
    }
    print('$s$RESET');
  }

  static void printHeader() {
    printFancy('###############################');
    printFancy('### Flutter Amplify Auth UI ###');
    printFancy('###############################');
    printMessage('');

    printMessage(
        'Generate Flutter widgets from your AWS Amplify CLI configuration.\n');

    printMessage('Author: https://github.com/finkmoritz\n');
  }

  static String? readArg(List<String> args, String key) {
    String? value = args.firstWhere((element) => element.startsWith('$key='),
        orElse: () => '');
    return value.isEmpty ? null : value.replaceAll('$key=', '');
  }

  static String _prepend(String s, String leading) {
    leading = '\[$leading\]'.padRight(10);
    s = s.replaceAll('\n', '\n$leading');
    return '$leading$s';
  }
}
