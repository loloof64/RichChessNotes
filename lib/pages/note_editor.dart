import 'dart:async';

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
  static const _debounceDuration = Duration(milliseconds: 500);

  static const _initialMarkdown = '''
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

  static const _chessTemplate = ''':::chess
fen: rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1
orientation: white
lastMove: no

arrows:
  - e2e4: yellow
  - c7c5: blue

highlights:
  - e4: red
  - c5: green
:::''';

  late final TextEditingController _textController;
  late String _previewData;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: _initialMarkdown);
    _previewData = _initialMarkdown;
    _textController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(_debounceDuration, () {
      setState(() {
        _previewData = _textController.text;
      });
    });
  }

  void _insertChessTemplate() {
    final text = _textController.text;
    final selection = _textController.selection;

    if (!selection.isValid) {
      final newText = '$_chessTemplate\n\n$text';
      _textController.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: _chessTemplate.length + 2),
      );
      return;
    }

    final insertion = '\n$_chessTemplate\n';
    final start = selection.start;
    final end = selection.end;

    final newText = text.replaceRange(start, end, insertion);

    _textController.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: start + insertion.length),
    );
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _textController.removeListener(_onTextChanged);
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editing note'),
        actions: [
          IconButton(
            icon: const Icon(Icons.grid_on),
            tooltip: 'Insérer un échiquier',
            onPressed: _insertChessTemplate,
          ),
        ],
      ),

      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                controller: _textController,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Écrivez votre note en markdown...',
                ),
              ),
            ),
          ),

          const VerticalDivider(width: 1),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8),
              child: MarkdownBody(
                data: _previewData,

                extensionSet: md.ExtensionSet([
                  ...md.ExtensionSet.gitHubFlavored.blockSyntaxes,
                  ChessBlockSyntax(),
                ], md.ExtensionSet.gitHubFlavored.inlineSyntaxes),

                builders: {'chess': ChessBuilder()},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
