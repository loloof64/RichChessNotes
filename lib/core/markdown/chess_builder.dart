import 'package:flutter/material.dart';

import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

import 'package:markdown/markdown.dart' as md;
import 'package:rich_chess_notes/core/markdown/chess_definition.dart';

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

class ChessBuilder extends MarkdownElementBuilder {
  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    late final ChessDefinition chess;

    try {
      chess = parseChess(element.textContent);
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

      return Center(
        child: SizedBox(
          width: 300.0,
          child: SimpleChessBoard(
            fen: chess.fen,

            whitePlayerType: PlayerType.computer,

            blackPlayerType: PlayerType.computer,

            onMove: ({required move}) {},

            onPromote: () {
              return Future.value(null);
            },

            onPromotionCommited: ({required moveDone, required pieceType}) {},

            onTap: ({required cellCoordinate}) {},

            cellHighlights: highlightsColors,

            blackSideAtBottom: !chess.whiteAtBottom,

            engineThinking: false,

            highlightLastMoveSquares: false,

            lastMoveToHighlight: lastMoveArrow,

            playSounds: false,

            isInteractive: false,

            highlightingArrows: arrows,

            nonInteractiveText: '',

            nonInteractiveOverlayColor: Colors.transparent,

            onBoardResized: (_) {},

            onMoveComplete: ({required move, required newFen}) {},

            showCoordinatesZone: false,

            chessBoardColors: ChessBoardColors(),
          ),
        ),
      );
    } catch (e) {
      return Text(
        'Invalid FEN:\n${chess.fen}\n\n$e',
        style: const TextStyle(color: Colors.red),
      );
    }
  }
}
