import 'dart:ui';

import 'package:flutter/material.dart';

class NoteEditorPainter extends CustomPainter {
  NoteEditorPainter(this.childrenParagraph);

  final Paragraph childrenParagraph;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    canvas.drawRect(rect, Paint()..color = Colors.white);
    canvas.drawParagraph(childrenParagraph, Offset.zero);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
