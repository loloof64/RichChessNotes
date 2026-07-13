import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:remix_icons_flutter/remixicon_ids.dart';

import 'package:rich_chess_notes/core/markdown/chess_block_syntax.dart';
import 'package:rich_chess_notes/core/markdown/chess_builder.dart';
import 'package:rich_chess_notes/i18n/strings.g.dart';

class NoteEditorPage extends StatefulWidget {
  const NoteEditorPage({super.key, required this.filePath});
  final String filePath;

  @override
  State<NoteEditorPage> createState() => _NoteEditorPageState();
}

class _NoteEditorPageState extends State<NoteEditorPage> {
  static const _debounceDuration = Duration(milliseconds: 500);

  static const _initialMarkdown = '''
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
  late Future<String> _fileDataFuture;
  late String _previewData;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: _initialMarkdown);
    _previewData = _initialMarkdown;
    _textController.addListener(_onTextChanged);
    _loadFileData();
  }

  void _loadFileData() {
    _fileDataFuture = File(widget.filePath).readAsString();
    _fileDataFuture.then((data) {
      setState(() {
        _textController.text = data;
        _previewData = data;
      });
    });
  }

  void _onTextChanged() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(_debounceDuration, () {
      setState(() {
        _previewData = _textController.text;
      });
    });
  }

  void _updateFenInSource(
    String blockContent,
    String newFen,
    bool whiteAtBottom,
  ) {
    final fullText = _textController.text;
    final idx = fullText.indexOf(blockContent);
    if (idx == -1) return;

    final fenLineRegex = RegExp(r'fen:.*');
    final orientationLineRegex = RegExp(r'orientation:.*');

    var newBlockContent = blockContent.replaceFirst(
      fenLineRegex,
      'fen: $newFen',
    );
    newBlockContent = newBlockContent.replaceFirst(
      orientationLineRegex,
      'orientation: ${whiteAtBottom ? 'white' : 'black'}',
    );

    final newFullText = fullText.replaceRange(
      idx,
      idx + blockContent.length,
      newBlockContent,
    );

    setState(() {
      _textController.text = newFullText;
      _previewData = newFullText;
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

  void _purposeSaveContent() async {
    final isOk = await showDialog<bool>(
      context: context,
      builder: (innerCtx) {
        return AlertDialog(
          title: Text(t.pages.note_editor.save_content_dialog.title),
          content: Text(t.pages.note_editor.save_content_dialog.message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                t.misc.buttons.cancel,
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(
                t.misc.buttons.ok,
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        );
      },
    );
    if (isOk == true) {
      await File(
        widget.filePath,
      ).writeAsString(_textController.text.toString());
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(t.pages.note_editor.content_saved)),
      );
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(t.misc.cancelled_by_user)));
    }
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
        title: Text(t.pages.note_editor.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.grid_on),
            tooltip: t.pages.note_editor.insert_board_tooltip,
            onPressed: _insertChessTemplate,
          ),
          IconButton(
            onPressed: _purposeSaveContent,
            icon: Icon(RemixIcon.save2Fill),
          ),
        ],
      ),

      body: FutureBuilder<String>(
        future: _fileDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          final editZone = Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: _textController,
              maxLines: null,
              expands: true,
              textAlignVertical: TextAlignVertical.top,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: t.pages.note_editor.placeholder,
              ),
            ),
          );

          final previewZone = SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            child: MarkdownBody(
              data: _previewData,

              extensionSet: md.ExtensionSet([
                ...md.ExtensionSet.gitHubFlavored.blockSyntaxes,
                ChessBlockSyntax(),
              ], md.ExtensionSet.gitHubFlavored.inlineSyntaxes),

              builders: {
                'chess': ChessBuilder(onFenEdited: _updateFenInSource),
              },
            ),
          );

          return OrientationBuilder(
            builder: (context, orientation) {
              if (orientation == Orientation.portrait) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child: editZone),
                    const Divider(height: 1),
                    Expanded(child: previewZone),
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: editZone),
                  const VerticalDivider(width: 1),
                  Expanded(child: previewZone),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
