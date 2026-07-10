import 'package:flutter/material.dart';
import 'package:rich_chess_notes/pages/note_editor.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  void _goToNoteEditorPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (routeContext) {
          return NoteEditorWidget();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () => _goToNoteEditorPage(context),
        child: Text("Go to editor page"),
      ),
    );
  }
}
