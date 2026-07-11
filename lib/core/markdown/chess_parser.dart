import 'package:flutter/foundation.dart';
import 'package:yaml/yaml.dart';

import 'chess_definition.dart';

ChessDefinition parseChess(String source) {
  final trimmed = source.trim();
  if (kDebugMode) {
    print('Parsing YAML: [$trimmed]');
  }
  final yaml = loadYaml(trimmed);

  if (kDebugMode) {
    print('YAML type: ${yaml.runtimeType}');
    print('YAML value: $yaml');
  }

  if (yaml is! YamlMap) {
    throw FormatException(
      'Invalid YAML format. Got ${yaml.runtimeType}. Content:\n$trimmed',
    );
  }

  final fen = yaml['fen']?.toString();

  if (fen == null || fen.isEmpty) {
    throw FormatException('Missing fen');
  }

  final arrows = <ChessArrow>[];

  final yamlArrows = yaml['arrows'];

  if (yamlArrows is YamlList) {
    for (final item in yamlArrows) {
      String move;
      String color = 'transparent'; // default color

      if (item is YamlMap) {
        move = item.keys.first.toString();
        color = item.values.first.toString();
      } else {
        move = item.toString();
      }

      if (move.length == 4) {
        arrows.add(
          ChessArrow(
            from: move.substring(0, 2),
            to: move.substring(2, 4),
            color: color,
          ),
        );
      }
    }
  }

  final highlights = <ChessHighlight>[];

  final yamlHighlights = yaml['highlights'];

  if (yamlHighlights is YamlList) {
    for (final item in yamlHighlights) {
      if (item is YamlMap) {
        highlights.add(
          ChessHighlight(
            square: item.keys.first.toString(),
            color: item.values.first.toString(),
          ),
        );
      } else {
        highlights.add(
          ChessHighlight(
            square: item.toString(),
            color: 'yellow', // default color
          ),
        );
      }
    }
  }

  return ChessDefinition(
    fen: fen,

    whiteAtBottom: yaml['orientation'] != 'black',

    lastMove: yaml['lastMove']?.toString(),

    arrows: arrows,

    highlights: highlights,
  );
}
