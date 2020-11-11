import 'package:flutter/material.dart';
import 'package:minesweeper/components/board_widget.dart';
import 'package:minesweeper/models/board.dart';
import 'package:minesweeper/models/explosion_exception.dart';
import '../components/result_widget.dart';
import '../models/field.dart';

class MinesweeperApp extends StatefulWidget {
  @override
  _MinesweeperAppState createState() => _MinesweeperAppState();
}

class _MinesweeperAppState extends State<MinesweeperApp> {
  bool _won;
  Board _board;

  void _restart() {
    setState(() {
      _won = null;
      _board.restartBoard();
    });
  }

  void _openField(Field field) {
    if (_won != null) {
      return;
    }

    setState(() {
      try {
        field.openField();
        if (_board.boardSolved) {
          _won = true;
        }
      } on ExplosionException {
        _won = false;
        _board.revealMines();
      }
    });
  }

  void _flagField(Field field) {
    if (_won != null) {
      return;
    }

    setState(() {
      field.setFlag();
      if (_board.boardSolved) {
        _won = true;
      }
    });
  }

  Board _generateBoard(double screenWidth, double screenHeight) {
    if (_board == null) {
      int numColumns = 15;
      double boardSize = screenWidth / screenHeight;
      int numLines = (screenHeight / boardSize).floor();
      numLines = numLines - 1;

      _board = Board(lines: 23, columns: 15, numberOfMines: 30);
    }
    return _board;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: ResultWidget(
          won: _won,
          onRestart: _restart,
        ),
        body: Container(
          color: Colors.grey,
          child: LayoutBuilder(
            builder: (ctx, constraints) {
              return BoardWidget(
                board:
                    _generateBoard(constraints.maxWidth, constraints.maxHeight),
                onOpen: _openField,
                onFlag: _flagField,
              );
            },
          ),
        ),
      ),
    );
  }
}
