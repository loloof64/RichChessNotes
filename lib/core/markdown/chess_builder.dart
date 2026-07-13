import 'package:flutter/material.dart';

import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

import 'package:markdown/markdown.dart' as md;
import 'package:rich_chess_notes/core/markdown/chess_definition.dart';
import 'package:rich_chess_notes/core/markdown/chess_position_editor.dart';

import 'package:simple_chess_board/simple_chess_board.dart';

import 'chess_parser.dart';

Color _colorFromName(String name) {
  switch (name.toLowerCase()) {
    case 'red':
      return Colors.red;
    case 'orange':
      return Colors.orange;
    case 'yellow':
      return Colors.yellow;
    case 'green':
      return Colors.green;
    case 'blue':
      return Colors.blue;
    case 'purple':
      return Colors.purple;
    case 'black':
      return Colors.black;
    case 'white':
      return Colors.white;
    default:
      return Colors.transparent;
  }
}

typedef ChessFenEditedCallback =
    void Function(String blockContent, String newFen, bool whiteAtBottom);

class ChessBuilder extends MarkdownElementBuilder {
  final ChessFenEditedCallback? onFenEdited;

  ChessBuilder({this.onFenEdited});

  @override
  bool isBlockElement() => true;

  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    late final ChessDefinition chess;
    final blockContent = element.textContent;

    try {
      chess = parseChess(blockContent);
    } catch (e) {
      return Text(
        'Chess block error:\n$e',
        style: const TextStyle(color: Colors.red),
      );
    }

    try {
      final arrows = chess.arrows.map((arrowDef) {
        return BoardArrow(
          from: arrowDef.from,
          to: arrowDef.to,
          color: _colorFromName(arrowDef.color),
        );
      }).toList();

      final highlightsColors = chess.highlights.fold(<String, Color>{}, (
        previousRes,
        highlightDef,
      ) {
        previousRes[highlightDef.square] = _colorFromName(highlightDef.color);
        return previousRes;
      });

      final lastMove = chess.lastMove;
      final lastMoveArrow = (lastMove != null && lastMove.length == 4)
          ? BoardArrow(
              from: lastMove.substring(0, 2),
              to: lastMove.substring(2, 4),
              color: Colors.transparent,
            )
          : null;

      return _ChessBoardWithEditor(
        chess: chess,
        blockContent: blockContent,
        arrows: arrows,
        highlightsColors: highlightsColors,
        lastMoveArrow: lastMoveArrow,
        onFenEdited: onFenEdited,
      );
    } catch (e) {
      return Text(
        'Invalid FEN:\n${chess.fen}\n\n$e',
        style: const TextStyle(color: Colors.red),
      );
    }
  }
}

class _ChessBoardWithEditor extends StatefulWidget {
  final ChessDefinition chess;
  final String blockContent;
  final List<BoardArrow> arrows;
  final Map<String, Color> highlightsColors;
  final BoardArrow? lastMoveArrow;
  final ChessFenEditedCallback? onFenEdited;

  const _ChessBoardWithEditor({
    required this.chess,
    required this.blockContent,
    required this.arrows,
    required this.highlightsColors,
    required this.lastMoveArrow,
    required this.onFenEdited,
  });

  @override
  State<_ChessBoardWithEditor> createState() => _ChessBoardWithEditorState();
}

class _ChessBoardWithEditorState extends State<_ChessBoardWithEditor> {
  bool _isEditing = false;

  @override
  Widget build(BuildContext context) {
    if (_isEditing) {
      return Center(
        child: SizedBox(
          width: 300.0,
          child: ChessPositionEditor(
            initialFen: widget.chess.fen,
            whiteAtBottom: widget.chess.whiteAtBottom,
            onCancel: () => setState(() => _isEditing = false),
            onValidate: (newFen, whiteAtBottom) {
              widget.onFenEdited?.call(
                widget.blockContent,
                newFen,
                whiteAtBottom,
              );
              setState(() => _isEditing = false);
            },
          ),
        ),
      );
    }

    return Center(
      child: SizedBox(
        width: 300.0,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            SimpleChessBoard(
              fen: widget.chess.fen,

              whitePlayerType: PlayerType.computer,

              blackPlayerType: PlayerType.computer,

              onMove: ({required move}) {},

              onPromote: () {
                return Future.value(null);
              },

              onPromotionCommited: ({required moveDone, required pieceType}) {},

              onTap: ({required cellCoordinate}) {},

              cellHighlights: widget.highlightsColors,

              blackSideAtBottom: !widget.chess.whiteAtBottom,

              engineThinking: false,

              highlightLastMoveSquares: false,

              lastMoveToHighlight: widget.lastMoveArrow,

              playSounds: false,

              isInteractive: false,

              highlightingArrows: widget.arrows,

              nonInteractiveText: '',

              nonInteractiveOverlayColor: Colors.transparent,

              onBoardResized: (_) {},

              onMoveComplete: ({required move, required newFen}) {},

              showCoordinatesZone: true,

              chessBoardColors: ChessBoardColors(),
            ),
            if (widget.onFenEdited != null)
              Positioned(
                right: -18,
                top: 0,
                bottom: 0,
                child: Center(
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: IconButton(
                      icon: const Icon(
                        Icons.edit,
                        size: 18,
                        color: Colors.white,
                      ),
                      tooltip: 'Modifier la position',
                      onPressed: () => setState(() => _isEditing = true),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
