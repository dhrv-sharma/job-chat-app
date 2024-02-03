import 'package:flutter/material.dart';

class LoginNotifier extends ChangeNotifier {
// paramter
  bool _obsecure = true;

// function to get parameter
  bool get obsecure => _obsecure;

// fucntion to set parameter value
  set obsecure(bool newState) {
    _obsecure = newState;

    notifyListeners();
  }
}
