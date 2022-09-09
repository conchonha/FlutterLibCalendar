import 'package:flutter/cupertino.dart';

/// Controller to notify the height of cell gotten from [MeasureSize]
class CellHeightController extends ChangeNotifier {

  double? cellHeight;
  double? cellWith;

  void onChanged(Size size) {
    cellHeight = size.height;
    cellWith = size.width;
    notifyListeners();
  }
}
