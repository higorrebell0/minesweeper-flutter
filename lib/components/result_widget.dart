import 'package:flutter/material.dart';

class ResultWidget extends StatelessWidget implements PreferredSizeWidget {
  final bool won;
  final Function onRestart;

  ResultWidget({
    @required this.won,
    @required this.onRestart,
  });

  Color _getCor() {
    if (won == null) {
      return Colors.yellow;
    } else if (won) {
      return Colors.green[300];
    } else {
      return Colors.red[300];
    }
  }

  IconData _getIcon() {
    if (won == null) {
      return Icons.sentiment_satisfied;
    } else if (won) {
      return Icons.sentiment_very_satisfied;
    } else {
      return Icons.sentiment_dissatisfied;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          child: CircleAvatar(
            backgroundColor: _getCor(),
            child: IconButton(
              padding: EdgeInsets.all(0),
              icon: Icon(
                _getIcon(),
                color: Colors.black,
                size: 35,
              ),
              onPressed: onRestart,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(120);
}
