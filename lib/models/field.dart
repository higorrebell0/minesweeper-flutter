import 'package:flutter/foundation.dart';
import 'explosion_exception.dart';

class Field {
  final int line;
  final int column;
  final List<Field> neighbors = [];

  bool _open = false;
  bool _flagged = false;
  bool _mined = false;
  bool _destructed = false;

  Field({@required this.line, @required this.column});

  void addNeighbor(Field neighbor) {
    final deltaLine = (line - neighbor.line).abs();
    final deltaColumn = (column - neighbor.column).abs();

    if (deltaLine == 0 && deltaColumn == 0) {
      return;
    }

    if (deltaLine <= 1 && deltaColumn <= 1) {
      neighbors.add(neighbor);
    }
  }

  void openField() {
    if (_open) {
      return;
    }
    _open = true;

    if (_mined) {
      _destructed = true;
      throw ExplosionException();
    }

    if (safeNeighborhood) {
      neighbors.forEach((n) => n.openField());
    }
  }

  void revealBomb() {
    if (_mined) {
      _open = true;
    }
  }

  void setMine() {
    _mined = true;
  }

  void setFlag() {
    _flagged = !_flagged;
  }

  void restartField() {
    _open = false;
    _flagged = false;
    _mined = false;
    _destructed = false;
  }

  bool get mined {
    return _mined;
  }

  bool get destructed {
    return _destructed;
  }

  bool get open {
    return _open;
  }

  bool get flagged {
    return _flagged;
  }

  bool get solved {
    bool minedNFlagged = mined && flagged;
    bool safeNOpen = !mined && open;

    return minedNFlagged || safeNOpen;
  }

  bool get safeNeighborhood {
    return neighbors.every((n) => !n._mined);
  }

  int get numberMinesOnNeighborhood {
    return neighbors.where((n) => n.mined).length;
  }
}
