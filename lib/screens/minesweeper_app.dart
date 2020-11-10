import 'package:flutter/material.dart';
import '../components/result_widget.dart';
import '../components/field_widget.dart';
import '../models/field.dart';

class MinesweeperApp extends StatelessWidget {
  void _restart() {
    print('restarting...');
  }

  void _open(Field field) {
    print('restarting...');
  }

  void _flag(Field field) {
    print('restarting...');
  }

  @override
  Widget build(BuildContext context) {
    Field field = Field(line: 0, column: 0);
    return MaterialApp(
      home: Scaffold(
        appBar: ResultWidget(
          won: true,
          onRestart: _restart,
        ),
        body: Container(
          child: FieldWidget(
            field: field,
            onOpen: _open,
            onFlag: _flag,
          ),
        ),
      ),
    );
  }
}
