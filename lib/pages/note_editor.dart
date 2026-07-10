import 'package:flutter/material.dart';

class NoteEditorWidget extends StatefulWidget {
  const NoteEditorWidget({super.key});

  @override
  State<NoteEditorWidget> createState() => _NoteEditorWidgetState();
}

class _NoteEditorWidgetState extends State<NoteEditorWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Editing note")),
      body: Placeholder(),
    );
  }
}
