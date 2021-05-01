import 'dart:io';

import 'dart:isolate';

class Template {
  static final String delimiterStart = '+++START ';
  static final String delimiterEnd = '+++END ';
  static final List<String> delimiters = [
    delimiterStart,
    delimiterEnd,
  ];

  late String _content;

  Template._({required String pathToTemplate}) {
    var file = File(pathToTemplate);
    _content = file.readAsStringSync();
  }

  static Future<Template> byName({required String templateName}) async {
    var uri = Uri.parse('package:flutter_amplify_auth_ui/templates/$templateName');
    var resolvedUri = await Isolate.resolvePackageUri(uri);
    if(resolvedUri == null) {
      throw Exception('Could not resolve path to $uri');
    } else {
      return Template._(pathToTemplate: resolvedUri.toFilePath());
    }
  }

  void writeToFile({required String filePath}) {
    var file = File(filePath);
    file.createSync(recursive: true);
    file.writeAsStringSync(_content);
  }

  void remove({required String identifier}) {
    while(_content.contains(delimiterStart + identifier)) {
      var startIndex = _content.lastIndexOf('\n', _content.indexOf(delimiterStart + identifier));
      var endIndex = _content.indexOf('\n', _content.indexOf(delimiterEnd + identifier));
      _content = _content.substring(0, startIndex) + _content.substring(endIndex);
    }
  }

  void removeAllIdentifiers() {
    for(var delimiter in delimiters) {
      while(_content.contains(delimiter)) {
        _removeLineAt(_content.indexOf(delimiter));
      }
    }
  }

  void _removeLineAt(int index) {
    var lineStart = _content.lastIndexOf('\n', index) + 1;
    var lineEnd = _content.indexOf('\n', index) + 1;
    _content = _content.substring(0, lineStart) + _content.substring(lineEnd);
  }
}
