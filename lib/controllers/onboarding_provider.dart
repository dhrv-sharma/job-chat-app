import 'package:flutter/material.dart';


// it notifes the every dependence

class OnBoardNotifier extends ChangeNotifier {

  // value that checks wheather its a last page

  bool _isLastPage = false;


  // fucntion to get the lastpage var

  bool get isLastPage => _isLastPage;


  // function to set the lastpage var value run when page() get scrolled

  set isLastPage(bool lastpage) {

    _isLastPage = lastpage;

    notifyListeners();

  }

}

