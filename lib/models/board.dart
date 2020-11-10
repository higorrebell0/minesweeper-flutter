import 'dart:math';

import 'package:flutter/foundation.dart';

import 'field.dart';

class Board {
  final int lines;
  final int columns;
  final int numberOfMines;

  final List<Field> _fields = [];

  Board(
      {@required this.lines,
      @required this.columns,
      @required this.numberOfMines}) {
    _createFields();
    _linkNeighbors();
    _sortMines();
  }

  void revealMines() {
    _fields.forEach((field) => field.revealBomb());
  }

  void restartBoard() {
    _fields.forEach((field) => field.restartField());
    _sortMines();
  }

  void _createFields() {
    for (int l = 0; l < lines; l++) {
      for (int c = 0; c < columns; c++) {
        _fields.add(Field(line: l, column: c));
      }
    }
  }

  void _linkNeighbors() {
    for (var field in _fields) {
      for (var neighbor in _fields) {
        field.addNeighbor(neighbor);
      }
    }
  }

  void _sortMines() {
    int sorted = 0;
    int numberFields = _fields.length;

    if (numberOfMines > lines * columns) {
      return; // TODO - return exception with a message
    }

    while (sorted < numberOfMines) {
      int rng = Random().nextInt(numberFields);

      if (!_fields[rng].mined) {
        sorted++;
        _fields[rng].setMine();
      }
    }
  }

  List<Field> get fields {
    return _fields;
  }

  bool get boardSolved {
    return _fields.every((field) => field.solved);
  }
}
