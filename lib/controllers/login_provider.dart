import 'package:flutter/material.dart';


import 'package:get/get.dart';


import 'package:get/get_core/src/get_main.dart';


import 'package:jobchat/constants/app_constants.dart';


import 'package:jobchat/services/authHelper.dart';


import 'package:jobchat/view/screen/home/mainscreen.dart';


import 'package:shared_preferences/shared_preferences.dart';


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


// logged In notifer


  bool? _loggedIn;


  bool get loggedIn => _loggedIn ?? false;


  set loggedIn(bool newState) {

    _loggedIn = newState;


    notifyListeners();

  }


// login function


  login(String model) {

    authHelper.login(model).then((response) {

      if (response == true) {

        loader = false;


        Get.snackbar("Login Succesfull", "New Jobs are waiting for you",

            colorText: Color(kLight.value),

            backgroundColor: Colors.green,

            icon: const Icon(

              Icons.add_alert,

              color: Colors.white,

            ),

            borderRadius: 5);


        getPref();


        Get.offAll(() => const mainScreen());

      } else {

        loader = false;


        Get.snackbar("Failed To Login In", "Please check your Credentials",

            colorText: Color(kLight.value),

            backgroundColor: Color(kOrange.value),

            icon: const Icon(

              Icons.add_alert,

              color: Colors.white,

            ),

            borderRadius: 5);

      }

    });

  }


// setting up the constant

  getPref() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();


    // entry point is for boarding screen


    // var entrypoint = prefs.getBool('entrypoint') ?? false;


    var loggedIn = prefs.getBool("loggedin") ?? false;


    _loggedIn = loggedIn;


    var username = prefs.getString('username') ?? '';


    var userId = prefs.getString('userId') ?? '';


    var profile = prefs.getString('profile') ?? '';


    userNameConst = username;


    userIdConst = userId;


    profileConst = profile;

  }

}

