import 'package:flutter/material.dart';

class SignUpNotifier extends ChangeNotifier {
// paramter for the password

  bool _obsecure = true;

// function to get parameter

  bool get obsecure => _obsecure;

// fucntion to set parameter value

  set obsecure(bool newState) {
    _obsecure = newState;

    notifyListeners();
  }

// password should more than 8
//  password should have atleast upper , lower case letter ,special symbol, digit
  bool passwordValidator(String password) {
    if (password.isEmpty) return false;
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(password);
  }
}
