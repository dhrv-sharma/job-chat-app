import 'dart:ffi';


import 'package:flutter/material.dart';


import 'package:jobchat/constants/app_constants.dart';

import 'package:jobchat/models/auth/profile_model.dart';

import 'package:jobchat/services/authHelper.dart';


class ProfileNotifier extends ChangeNotifier {

  late Future<ProfileRes?> myProfile;


  String _profileImage = profileConst;


  String get profileImage => _profileImage;


  set profileImage(String url) {

    _profileImage = url;


    notifyListeners();

  }


  Future<ProfileRes?> get getProfile => myProfile;


  void profileSet() {

    myProfile = authHelper.getProfile();

  }

}

