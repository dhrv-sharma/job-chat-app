import 'package:flutter/material.dart';

class ZoomNotifier extends ChangeNotifier {
  int _currentIndex = 0; // parameterss

  int get currentIndex => _currentIndex; // get the value return int

  // set he the value
  set currentIndex(int newIndex) {
    _currentIndex = newIndex;
    notifyListeners();
  }
}
