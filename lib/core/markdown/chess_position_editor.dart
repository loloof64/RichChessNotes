import 'package:chess_vectors_flutter/chess_vectors_flutter.dart';
import 'package:flutter/material.dart';
import 'package:simple_chess_board/simple_chess_board.dart';

/// Decodes the piece placement part of a FEN string into an 8x8 grid.
/// `board[0]` is the 8th rank, `board[7]` is the 1st rank.
List<List<String?>> _decodeBoard(String fen) {
  final boardPart = fen.split(' ').first;
  final board = List.generate(8, (_) => List<String?>.filled(8, null));

  final ranks = boardPart.split('/');
  for (var r = 0; r < ranks.length && r < 8; r++) {
    var c = 0;
    for (final char in ranks[r].split('')) {
      final emptyCount = int.tryParse(char);
      if (emptyCount != null) {
        c += emptyCount;
      } else {
        if (c < 8) board[r][c] = char;
        c++;
      }
    }
  }
  return board;
}

/// Encodes an 8x8 grid back into a full FEN string, reusing `restOfFen`
/// (side to move, castling rights, en passant, halfmove/fullmove counters).
String _encodeBoard(List<List<String?>> board, String restOfFen) {
  final ranks = <String>[];
  for (var r = 0; r < 8; r++) {
    final buffer = StringBuffer();
    var emptyCount = 0;
    for (var c = 0; c < 8; c++) {
      final piece = board[r][c];
      if (piece == null) {
        emptyCount++;
      } else {
        if (emptyCount > 0) {
          buffer.write(emptyCount);
          emptyCount = 0;
        }
        buffer.write(piece);
      }
    }
    if (emptyCount > 0) buffer.write(emptyCount);
    ranks.add(buffer.toString());
  }
  return '${ranks.join('/')} $restOfFen';
}

int _rowOf(String square) => 8 - int.parse(square[1]);
int _colOf(String square) => square.codeUnitAt(0) - 'a'.codeUnitAt(0);

/// A piece code as used in FEN: uppercase for white, lowercase for black
/// (e.g. 'P', 'n', 'Q'), or null for the eraser tool.
typedef ChessPositionValidatedCallback =
    void Function(String newFen, bool whiteAtBottom);

class ChessPositionEditor extends StatefulWidget {
  final String initialFen;
  final bool whiteAtBottom;
  final ChessPositionValidatedCallback onValidate;
  final VoidCallback onCancel;

  const ChessPositionEditor({
    super.key,
    required this.initialFen,
    required this.whiteAtBottom,
    required this.onValidate,
    required this.onCancel,
  });

  @override
  State<ChessPositionEditor> createState() => _ChessPositionEditorState();
}

class _ChessPositionEditorState extends State<ChessPositionEditor> {
  late List<List<String?>> _board;
  late String _restOfFen;
  late bool _whiteAtBottom;
  String? _selectedTool;
  bool _eraseMode = false;

  static const _whitePieces = ['P', 'N', 'B', 'R', 'Q', 'K'];
  static const _blackPieces = ['p', 'n', 'b', 'r', 'q', 'k'];

  @override
  void initState() {
    super.initState();
    _board = _decodeBoard(widget.initialFen);
    final parts = widget.initialFen.split(' ');
    _restOfFen = parts.length > 1 ? parts.sublist(1).join(' ') : 'w - - 0 1';
    _whiteAtBottom = widget.whiteAtBottom;
  }

  String get _currentFen => _encodeBoard(_board, _restOfFen);

  Widget _pieceIcon(String code, {double size = 24}) {
    switch (code) {
      case 'P':
        return WhitePawn(size: size);
      case 'N':
        return WhiteKnight(size: size);
      case 'B':
        return WhiteBishop(size: size);
      case 'R':
        return WhiteRook(size: size);
      case 'Q':
        return WhiteQueen(size: size);
      case 'K':
        return WhiteKing(size: size);
      case 'p':
        return BlackPawn(size: size);
      case 'n':
        return BlackKnight(size: size);
      case 'b':
        return BlackBishop(size: size);
      case 'r':
        return BlackRook(size: size);
      case 'q':
        return BlackQueen(size: size);
      case 'k':
        return BlackKing(size: size);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _paletteButton({required String? tool, required bool erase}) {
    final isSelected = erase
        ? _eraseMode
        : (_selectedTool == tool && !_eraseMode);

    return InkWell(
      borderRadius: BorderRadius.circular(6),
      onTap: () {
        setState(() {
          if (erase) {
            _eraseMode = true;
            _selectedTool = null;
          } else {
            _eraseMode = false;
            _selectedTool = tool;
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: erase
            ? const Icon(Icons.delete_outline, size: 24)
            : _pieceIcon(tool!),
      ),
    );
  }

  Widget _paletteRow(List<String> pieces, {required bool clearAllButton}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (final piece in pieces) _paletteButton(tool: piece, erase: false),
        if (clearAllButton)
          _clearAllButton()
        else
          _paletteButton(tool: null, erase: true),
      ],
    );
  }

  Widget _clearAllButton() {
    return InkWell(
      borderRadius: BorderRadius.circular(6),
      onTap: () {
        setState(() {
          _board = List.generate(8, (_) => List<String?>.filled(8, null));
        });
      },
      child: Container(
        padding: const EdgeInsets.all(4),
        child: const Icon(Icons.auto_fix_off, size: 24),
      ),
    );
  }

  void _onSquareTap(String square) {
    setState(() {
      final row = _rowOf(square);
      final col = _colOf(square);
      _board[row][col] = _eraseMode ? null : _selectedTool;
    });
  }

  Widget _circularActionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      customBorder: const CircleBorder(),
      onTap: onPressed,
      child: CircleAvatar(
        radius: 22,
        backgroundColor: color,
        child: Icon(icon, color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _paletteRow(_whitePieces, clearAllButton: false),
          const SizedBox(height: 8),
          SizedBox(
            width: 300,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                SimpleChessBoard(
                  fen: _currentFen,
                  whitePlayerType: PlayerType.computer,
                  blackPlayerType: PlayerType.computer,
                  onMove: ({required move}) {},
                  onPromote: () => Future.value(null),
                  onPromotionCommited:
                      ({required moveDone, required pieceType}) {},
                  onTap: ({required cellCoordinate}) =>
                      _onSquareTap(cellCoordinate),
                  cellHighlights: const {},
                  blackSideAtBottom: !_whiteAtBottom,
                  engineThinking: false,
                  highlightLastMoveSquares: false,
                  playSounds: false,
                  // Both player types are `computer`, so no move/drag can ever
                  // be triggered by the human; this only exists to avoid the
                  // non-interactive overlay, which swallows taps before onTap
                  // runs.
                  isInteractive: true,
                  nonInteractiveText: '',
                  nonInteractiveOverlayColor: Colors.transparent,
                  onBoardResized: (_) {},
                  onMoveComplete: ({required move, required newFen}) {},
                  showCoordinatesZone: true,
                  chessBoardColors: ChessBoardColors(),
                ),
                Positioned(
                  left: -18,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: _circularActionButton(
                      icon: Icons.sync,
                      color: Colors.blueGrey,
                      onPressed: () {
                        setState(() => _whiteAtBottom = !_whiteAtBottom);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          _paletteRow(_blackPieces, clearAllButton: true),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _circularActionButton(
                icon: Icons.close,
                color: Colors.red,
                onPressed: widget.onCancel,
              ),
              const SizedBox(width: 24),
              _circularActionButton(
                icon: Icons.check,
                color: Colors.green,
                onPressed: () => widget.onValidate(_currentFen, _whiteAtBottom),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
