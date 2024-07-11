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


  bool _loggedIn = loggedInconst;


  bool get loggedIn => _loggedIn;


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


// logout functionality just removing out the shared presference


  logout() async {

    try {

      final SharedPreferences prefs = await SharedPreferences.getInstance();


      await prefs.remove('token');


      await prefs.remove('username');


      await prefs.remove('userId');


      await prefs.remove('profile');


      await prefs.setBool('loggedIn', false);


      _loggedIn = false;


      loggedInconst = false;


      userNameConst = "";


      userIdConst = "";


      profileConst =

          "https://res.cloudinary.com/dap69mong/image/upload/v1710654983/fbdrtr3b8spuotwu3r28.jpg";


      Get.snackbar("Logout Successfull", "Make Sure you Login ",

          colorText: Color(kLight.value),

          backgroundColor: Colors.green,

          icon: const Icon(

            Icons.add_alert,

            color: Colors.white,

          ),

          borderRadius: 5);

    } catch (e) {

      // TODO


      Get.snackbar("Unable To Log Out", "Please try again",

          colorText: Color(kLight.value),

          backgroundColor: Color(kOrange.value),

          icon: const Icon(

            Icons.add_alert,

            color: Colors.white,

          ),

          borderRadius: 5);

    }

  }


// setting up the constant


  getData() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();


    _loggedIn = prefs.getBool("loggedIn") ?? false;


    var username = prefs.getString('username') ?? '';


    var userId = prefs.getString('userId') ?? '';


    var profile = prefs.getString('profile') ?? '';


    userNameConst = username;


    userIdConst = userId;


    profileConst = profile;


    entrypoint = prefs.getBool('entrypoint') ?? false;

  }


  getPref() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();


    // entry point is for boarding screen


    // var entrypoint = prefs.getBool('entrypoint') ?? false;


    var loggedIn = prefs.getBool("loggedIn") ?? false;


    _loggedIn = true;


    var username = prefs.getString('username') ?? '';


    var userId = prefs.getString('userId') ?? '';


    var profile = prefs.getString('profile') ?? '';


    userNameConst = username;


    userIdConst = userId;


    profileConst = profile;

  }


  int selected = 0;


  int _selected() => selected;


  void change(int index) {

    selected = index;

    notifyListeners();

  }

}

