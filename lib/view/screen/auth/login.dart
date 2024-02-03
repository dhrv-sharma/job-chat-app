import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobchat/constants/app_constants.dart';
import 'package:jobchat/controllers/login_provider.dart';
import 'package:jobchat/view/common/appstyle.dart';
import 'package:jobchat/view/common/customText.dart';
import 'package:jobchat/view/common/customappBar.dart';
import 'package:jobchat/view/common/customeButton.dart';
import 'package:jobchat/view/common/heightSpacer.dart';
import 'package:jobchat/view/common/resuabletext.dart';
import 'package:jobchat/view/screen/home/homepage.dart';
import 'package:provider/provider.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  // controller for the text field
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  // method to dispose them
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginNotifier>(builder: (context, loginNotifer, child) {
      return Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: CustomAppbar(
                  text: "Login",
                  actions: const [],
                  child: GestureDetector(
                    onTap: null,
                    child: const Icon(CupertinoIcons.arrow_left),
                  ))),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const heightSpacer(size: 50),
                reusableText(
                    text: "Welcome Back!",
                    style: appStyle(30, Color(kDark.value), FontWeight.w600)),
                reusableText(
                    text: "Fill the details to login to your account",
                    style:
                        appStyle(16, Color(kDarkGrey.value), FontWeight.w600)),
                const heightSpacer(size: 50),
                customTextField(
                  hintText: "Email",
                  keyBoardType: TextInputType.emailAddress,
                  controller: email,
                  suffixIcon: Icon(
                    Icons.email_outlined,
                    color: Color(kDark.value),
                  ),
                  obsecureText: false,
                  validator: (email) {
                    if (email!.isEmpty || !email.contains("@")) {
                      return "Please enter a valid email";
                    } else {
                      return null;
                    }
                  },
                ),
                const heightSpacer(size: 20),
                customTextField(
                  hintText: "Password",
                  keyBoardType: TextInputType.visiblePassword,
                  controller: password,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      loginNotifer.obsecure = !loginNotifer.obsecure;
                    },
                    child: loginNotifer.obsecure
                        ? Icon(
                            Icons.visibility,
                            color: Color(kDark.value),
                          )
                        : Icon(Icons.visibility_off, color: Color(kDark.value)),
                  ),
                  obsecureText: loginNotifer.obsecure,
                  validator: (password) {
                    if (password!.isEmpty && password.length < 7) {
                      return "Please enter a password";
                    } else {
                      return null;
                    }
                  },
                ),
                const heightSpacer(size: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: null,
                    child: reusableText(
                        text: "Register",
                        style:
                            appStyle(14, Color(kDark.value), FontWeight.w500)),
                  ),
                ),
                const heightSpacer(size: 50),
                customButton(
                    text: "Login",
                    onTap: () {
                      Get.to(const homePage());
                    })
              ],
            ),
          ));
    });
  }
}
