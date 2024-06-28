import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobchat/constants/app_constants.dart';
import 'package:jobchat/controllers/login_provider.dart';
import 'package:jobchat/models/auth/login.dart';
import 'package:jobchat/view/common/appstyle.dart';
import 'package:jobchat/view/common/buildStyleContainer.dart';
import 'package:jobchat/view/common/customappBar.dart';
import 'package:jobchat/view/common/customeButton.dart';
import 'package:jobchat/view/common/heightSpacer.dart';
import 'package:jobchat/view/common/newTextField.dart';
import 'package:jobchat/view/common/pageloader.dart';
import 'package:jobchat/view/common/resuabletext.dart';
import 'package:jobchat/view/screen/auth/registerPage.dart';
import 'package:jobchat/view/screen/home/mainscreen.dart';
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
  final _formKey = GlobalKey<FormState>();

  // method to dispose them
  @override
  void dispose() {
    // TODO: implement dispose
    email.dispose();
    password.dispose();
    super.dispose();
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
                    onTap: () {
                      Get.offAll(() => const mainScreen());
                    },
                    child: const Icon(Icons.arrow_back),
                  ))),
          body: loginNotifer.loader
              ? const PageLoader()
              : buildStyleContainer(
                  context,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Form(
                      key: _formKey,
                      child: ListView(padding: EdgeInsets.zero, children: [
                        const heightSpacer(size: 50),
                        reusableText(
                            text: "Welcome Back",
                            style: appStyle(
                                30, Color(kDark.value), FontWeight.w600)),
                        reusableText(
                            text:
                                "Fill in the Details to login to  your account",
                            style: appStyle(
                                14, Color(kDarkGrey.value), FontWeight.w400)),
                        const heightSpacer(size: 40),
                        buildtextField(
                            hintText: "Enter Your Email",
                            type: TextInputType.emailAddress,
                            controller: email,
                            suffixIcon: const Icon(Icons.email_outlined),
                            obsecureText: false,
                            validator: (email) {
                              if (email!.isEmpty || !email.contains("@")) {
                                return "Please Enter Your Email";
                              }
                              return null;
                            }),
                        const heightSpacer(size: 20),
                        buildtextField(
                            hintText: "Enter your password",
                            controller: password,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                loginNotifer.obsecure = !loginNotifer.obsecure;
                              },
                              child: !loginNotifer.obsecure
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                            ),
                            obsecureText: loginNotifer.obsecure,
                            validator: (password) {
                              if (password!.isEmpty) {
                                return "Please Enter a Valid Password";
                              }
                              return null;
                            },
                            type: TextInputType.text),
                        const heightSpacer(size: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              Get.to(() => const registerPage());
                            },
                            child: reusableText(
                                text: "Register",
                                style: appStyle(
                                    14, Color(kDark.value), FontWeight.w400)),
                          ),
                        ),
                        const heightSpacer(size: 50),
                        customButton(
                            text: "Login",
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                loginNotifer.loader = true;
                                LoginModel model = LoginModel(
                                    email: email.text, password: password.text);
                                String newModel = loginModelToJson(model);
                                loginNotifer.login(newModel);
                              } else {
                                Get.snackbar("Invalid Fields",
                                    "Please check your Credentials",
                                    colorText: Color(kLight.value),
                                    backgroundColor: Color(kOrange.value),
                                    icon: const Icon(
                                      Icons.add_alert,
                                      color: Colors.white,
                                    ),
                                    borderRadius: 5);
                              }
                            })
                      ]),
                    ),
                  )));
    });
  }
}
