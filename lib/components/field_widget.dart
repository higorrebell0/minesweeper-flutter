import 'package:flutter/material.dart';
import 'package:minesweeper/models/field.dart';

class FieldWidget extends StatelessWidget {
  final Field field;
  final void Function(Field) onOpen;
  final void Function(Field) onFlag;

  FieldWidget(
      {@required this.field, @required this.onOpen, @required this.onFlag});

  Widget _getFieldImage() {
    int minesNear = field.numberMinesOnNeighborhood;
    if (field.open && field.mined && field.destructed) {
      return Image.asset('assets/images/mine_0.jpeg');
    } else if (field.open && field.mined) {
      return Image.asset('assets/images/mine_1.jpeg');
    } else if (field.open) {
      return Image.asset('assets/images/open_$minesNear.jpeg');
    } else if (field.flagged) {
      return Image.asset('assets/images/flag.jpeg');
    } else {
      return Image.asset('assets/images/closed.jpeg');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onOpen(field),
      onLongPress: () => onFlag(field),
      child: _getFieldImage(),
    );
  }
}
