import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:markdown/markdown.dart' as md;

import 'package:rich_chess_notes/core/markdown/chess_block_syntax.dart';
import 'package:rich_chess_notes/core/markdown/chess_builder.dart';

class NoteEditorPage extends StatefulWidget {
  const NoteEditorPage({super.key});

  @override
  State<NoteEditorPage> createState() => _NoteEditorPageState();
}

class _NoteEditorPageState extends State<NoteEditorPage> {
  final markdownData = '''
### Simple title

Avant l'échiquier

:::chess
fen: rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1
orientation: white
lastMove: e2e4

arrows:
  - e2e4: yellow
  - c7c5: blue

highlights:
  - e4: red
  - c5: green
:::

Après l'échiquier.
''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editing note')),

      body: Padding(
        padding: const EdgeInsets.all(8),

        child: MarkdownBody(
          data: markdownData,

          extensionSet: md.ExtensionSet([
            ...md.ExtensionSet.gitHubFlavored.blockSyntaxes,
            ChessBlockSyntax(),
          ], md.ExtensionSet.gitHubFlavored.inlineSyntaxes),

          builders: {'chess': ChessBuilder()},
        ),
      ),
    );
  }
}
