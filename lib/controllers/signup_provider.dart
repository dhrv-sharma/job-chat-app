import 'package:flutter/material.dart';


import 'package:get/get.dart';


import 'package:jobchat/constants/app_constants.dart';


import 'package:jobchat/services/authHelper.dart';


import 'package:jobchat/view/screen/auth/login.dart';


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


  // password validator


  bool passwordValidator(String password) {

    if (password.isEmpty) return false;


    String pattern =

        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';


    RegExp regex = RegExp(pattern);


    return regex.hasMatch(password);

  }


  bool _loader = false;


  bool get loader => _loader;


  set loader(bool newState) {

    _loader = newState;


    notifyListeners();

  }


// validating form


  final signupFormKey = GlobalKey<FormState>();


  bool validateAndSave() {

    final form = signupFormKey.currentState;


    if (form!.validate()) {

      form.save();


      return true;

    } else {

      return false;

    }

  }


  signup(String model) {

    authHelper.signUp(model).then((response) {

      if (response == true) {

        loader = false;


        Get.snackbar("Your account has been Created", "Please login",

            colorText: Color(kLight.value),

            backgroundColor: Colors.green,

            icon: const Icon(

              Icons.add_alert,

              color: Colors.white,

            ),

            borderRadius: 5);


        Get.offAll(() => const loginPage());

      } else {

        loader = false;


        Get.snackbar("Failed To Sign up", "Please check your Credentials",

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

}

