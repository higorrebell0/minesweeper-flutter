import 'package:flutter_test/flutter_test.dart';
import 'package:minesweeper/models/board.dart';

main() {
  test('Win game', () {
    Board board = Board(lines: 2, columns: 2, numberOfMines: 0);

    board.fields[0].setMine();
    board.fields[3].setMine();

    board.fields[0].setFlag();
    board.fields[1].openField();
    board.fields[2].openField();
    board.fields[3].setFlag();

    expect(board.boardSolved, isTrue);
  });
}
