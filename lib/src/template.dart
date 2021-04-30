import 'dart:io';

class Template {
  static final String delimiterStart = '+++START ';
  static final String delimiterEnd = '+++END ';
  static final List<String> delimiters = [
    delimiterStart,
    delimiterEnd,
  ];

  late String _content;

  Template({required String pathToTemplate}) {
    var file = File(pathToTemplate);
    _content = file.readAsStringSync();
  }

  void writeToFile({required String filePath}) {
    var file = File(filePath);
    file.createSync(recursive: true);
    file.writeAsStringSync(_content);
  }

  void remove({required String identifier}) {
    var startIndex = _content.indexOf('\n', _content.indexOf(delimiterStart + identifier));
    var endIndex = _content.lastIndexOf('\n', _content.indexOf(delimiterEnd + identifier));
    _content = _content.substring(0, startIndex) + _content.substring(endIndex);
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
