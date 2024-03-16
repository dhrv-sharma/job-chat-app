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


  bool _loader = false;


  bool get loader => _loader;


  set loader(bool newState) {

    _loader = newState;


    notifyListeners();

  }

}

