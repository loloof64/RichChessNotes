import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:rich_chess_notes/widgets/note_editor_painter.dart';

class NoteEditorWidget extends StatefulWidget {
  const NoteEditorWidget({super.key});

  @override
  State<NoteEditorWidget> createState() => _NoteEditorWidgetState();
}

class _NoteEditorWidgetState extends State<NoteEditorWidget> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final paragraphBuilder = ui.ParagraphBuilder(
      ui.ParagraphStyle(fontSize: 20, textAlign: TextAlign.justify),
    )
      ..pushStyle(ui.TextStyle(color: Colors.black))
      ..addText("Lorem ipsum it sin dolor");
    final paragraph = paragraphBuilder.build()
      ..layout(ui.ParagraphConstraints(width: screenSize.width));

    return CustomPaint(
      size: screenSize,
      painter: NoteEditorPainter(paragraph),
    );
  }
}
