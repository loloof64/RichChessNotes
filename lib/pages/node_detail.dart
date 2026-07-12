import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:remix_icons_flutter/remixicon_ids.dart';
import 'package:rich_chess_notes/i18n/strings.g.dart';
import 'package:rich_chess_notes/core/markdown/chess_block_syntax.dart';
import 'package:rich_chess_notes/core/markdown/chess_builder.dart';
import 'package:rich_chess_notes/pages/note_editor.dart';

class NoteDetailPage extends StatefulWidget {
  const NoteDetailPage({super.key, required this.filePath});

  final String filePath;

  @override
  State<NoteDetailPage> createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  late Future<String> _fileDataFuture;

  @override
  void initState() {
    super.initState();
    _loadFileData();
  }

  void _loadFileData() {
    _fileDataFuture = File(widget.filePath).readAsString();
  }

  void _editNote() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (innerCtx) {
          return NoteEditorPage(filePath: widget.filePath);
        },
      ),
    );
    setState(() {
      _loadFileData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t.pages.note_details.title),
        actions: [
          IconButton(onPressed: _editNote, icon: Icon(RemixIcon.edit2Line)),
        ],
      ),
      body: FutureBuilder<String>(
        future: _fileDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            child: MarkdownBody(
              data: snapshot.data ?? "",

              extensionSet: md.ExtensionSet([
                ...md.ExtensionSet.gitHubFlavored.blockSyntaxes,
                ChessBlockSyntax(),
              ], md.ExtensionSet.gitHubFlavored.inlineSyntaxes),

              builders: {
                'chess': ChessBuilder(
                  onFenEdited: (blockContent, newFen, whiteAtBottom) => {},
                ),
              },
            ),
          );
        },
      ),
    );
  }
}
