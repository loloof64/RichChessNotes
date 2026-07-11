class ChessDefinition {
  final String fen;
  final bool whiteAtBottom;
  final String? lastMove;

  final List<ChessArrow> arrows;
  final List<ChessHighlight> highlights;

  const ChessDefinition({
    required this.fen,
    required this.whiteAtBottom,
    this.lastMove,
    this.arrows = const [],
    this.highlights = const [],
  });
}

class ChessArrow {
  final String from;
  final String to;
  final String color;

  const ChessArrow({required this.from, required this.to, required this.color});
}

class ChessHighlight {
  final String square;
  final String color;

  const ChessHighlight({required this.square, required this.color});
}
