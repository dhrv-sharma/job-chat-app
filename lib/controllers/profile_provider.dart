import 'package:flutter/material.dart';

import 'package:jobchat/constants/app_constants.dart';


class ProfileNotifier extends ChangeNotifier {

  String _profileImage = profileConst;


  String get profileImage => _profileImage;


  set profileImage(String url) {

    _profileImage = url;

    notifyListeners();

  }

}

