import 'package:markdown/markdown.dart' as md;

class ChessBlockSyntax extends md.BlockSyntax {
  @override
  RegExp get pattern => RegExp(r'^:::chess\s*$');

  @override
  md.Node parse(md.BlockParser parser) {
    parser.advance();

    final lines = <String>[];

    while (!parser.isDone) {
      final line = parser.current;

      if (line.content.trim() == ':::') {
        parser.advance();
        break;
      }

      lines.add(line.content);
      parser.advance();
    }

    // Find minimum indentation (excluding empty lines)
    int minIndent = 999;
    for (final line in lines) {
      if (line.trim().isNotEmpty) {
        final indent = line.length - line.trimLeft().length;
        minIndent = minIndent < indent ? minIndent : indent;
      }
    }

    // Remove minimum indentation from all lines
    final buffer = StringBuffer();
    for (final line in lines) {
      if (line.trim().isEmpty) {
        buffer.writeln();
      } else {
        buffer.writeln(line.substring(minIndent));
      }
    }

    final content = buffer.toString().trim();
    return md.Element.text('chess', content);
  }
}
