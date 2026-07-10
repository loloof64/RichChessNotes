import 'package:flutter/material.dart';
import 'package:rich_chess_notes/widgets/note_editor.dart';

class NoteEditorPage extends StatefulWidget {
  const NoteEditorPage({super.key});

  @override
  State<NoteEditorPage> createState() => _NoteEditorPageState();
}

class _NoteEditorPageState extends State<NoteEditorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Editing note")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: NoteEditorWidget(),
      ),
    );
  }
}
