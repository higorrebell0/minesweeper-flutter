import 'package:flutter/material.dart';
import 'package:minesweeper/components/field_widget.dart';
import 'package:minesweeper/models/board.dart';
import 'package:minesweeper/models/field.dart';
import '../models/field.dart';
import '../models/board.dart';

class BoardWidget extends StatelessWidget {
  final Board board;
  final void Function(Field) onOpen;
  final void Function(Field) onFlag;

  BoardWidget(
      {@required this.board, @required this.onOpen, @required this.onFlag});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: board.columns,
        children: board.fields.map((field) {
          return FieldWidget(
            field: field,
            onOpen: onOpen,
            onFlag: onFlag,
          );
        }).toList(),
      ),
    );
  }
}
