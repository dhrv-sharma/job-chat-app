import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobchat/constants/app_constants.dart';
import 'package:jobchat/controllers/exports.dart';
import 'package:jobchat/models/auth/sign_up.dart';
import 'package:jobchat/view/common/appstyle.dart';
import 'package:jobchat/view/common/buildStyleContainer.dart';
import 'package:jobchat/view/common/customText.dart';
import 'package:jobchat/view/common/customappBar.dart';
import 'package:jobchat/view/common/customeButton.dart';
import 'package:jobchat/view/common/heightSpacer.dart';
import 'package:jobchat/view/common/pageloader.dart';
import 'package:jobchat/view/common/resuabletext.dart';
import 'package:jobchat/view/screen/auth/login.dart';
import 'package:provider/provider.dart';

class registerPage extends StatefulWidget {
  const registerPage({super.key});

  @override
  State<registerPage> createState() => _registerPageState();
}

class _registerPageState extends State<registerPage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController username = TextEditingController();
  final _formKey = GlobalKey<FormState>();

// dispose function
  @override
  void dispose() {
    // TODO: implement dispose
    email.dispose();
    password.dispose();
    username.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpNotifier>(builder: (context, signNotifier, child) {
      return Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: CustomAppbar(
                  text: "Sign up",
                  actions: const [],
                  child: GestureDetector(
                    onTap: () {
                      Get.offAll(() => const loginPage());
                    },
                    child: const Icon(CupertinoIcons.arrow_left),
                  ))),
          body: signNotifier.loader
              ? const PageLoader()
              : buildStyleContainer(
                  context,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          const heightSpacer(size: 50),
                          reusableText(
                              text: "Hello, Welcome!",
                              style: appStyle(
                                  30, Color(kDark.value), FontWeight.w600)),
                          reusableText(
                              text:
                                  "Fill the details to sign up to your account",
                              style: appStyle(
                                  16, Color(kDarkGrey.value), FontWeight.w600)),
                          const heightSpacer(size: 50),
                          customTextField(
                            hintText: "Username",
                            keyBoardType: TextInputType.name,
                            controller: username,
                            suffixIcon: Icon(
                              Icons.person_2,
                              color: Color(kDark.value),
                            ),
                            obsecureText: false,
                            validator: (name) {
                              if (name!.isEmpty || name.length < 5) {
                                return "Please enter a valid username";
                              }
                              return null;
                            },
                          ),
                          const heightSpacer(size: 20),
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
                                signNotifier.obsecure = !signNotifier.obsecure;
                              },
                              child: !signNotifier.obsecure
                                  ? Icon(
                                      Icons.visibility,
                                      color: Color(kDark.value),
                                    )
                                  : Icon(Icons.visibility_off,
                                      color: Color(kDark.value)),
                            ),
                            obsecureText: signNotifier.obsecure,
                            validator: (password) {
                              if (!signNotifier
                                      .passwordValidator(password ?? '') ||
                                  password!.isEmpty) {
                                return "Password atleast have  a Special character , Upper case letter , Lower case letter and Digit 0-9";
                              }
                              return null;
                            },
                          ),
                          const heightSpacer(size: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                Get.to(const loginPage());
                              },
                              child: reusableText(
                                  text: "Log in",
                                  style: appStyle(
                                      14, Color(kDark.value), FontWeight.w500)),
                            ),
                          ),
                          const heightSpacer(size: 50),
                          customButton(
                              text: "Sign up",
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  signNotifier.loader = true;

                                  SignupModel model = SignupModel(
                                      username: username.text,
                                      email: email.text,
                                      password: password.text);
                                  String newModel = signupModelToJson(model);
                                  signNotifier.signup(newModel);
                                } else {
                                  Get.snackbar("Invalid fields",
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
                        ],
                      ),
                    ),
                  )));
    });
  }
}
