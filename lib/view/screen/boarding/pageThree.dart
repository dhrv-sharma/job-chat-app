import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobchat/constants/app_constants.dart';
import 'package:jobchat/view/common/appstyle.dart';
import 'package:jobchat/view/common/custom_outline_btn.dart';
import 'package:jobchat/view/common/heightSpacer.dart';
import 'package:jobchat/view/common/resuabletext.dart';
import 'package:jobchat/view/screen/auth/login.dart';
import 'package:jobchat/view/screen/auth/registerPage.dart';
import 'package:jobchat/view/screen/home/mainscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class pageThree extends StatelessWidget {
  const pageThree({super.key});

  void boardedDone() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("entrypoint", true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: width,
        height: hieght,
        color: Color(kLightBlue.value),
        child: Column(
          children: [
            Image.asset("assets/images/page3.png"),
            const heightSpacer(size: 20),
            reusableText(
                text: "Welcome to JobHub",
                style: appStyle(30, Color(kLight.value), FontWeight.w600)),
            const heightSpacer(size: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Text(
                "We help you to find your dream job according to your skillbase,location and preferences to builder your corner",
                textAlign: TextAlign.center,
                style: appStyle(14, Color(kLight.value), FontWeight.normal),
              ),
            ),
            const heightSpacer(size: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // custom button
                customOutlineButton(
                  text: "Login",
                  color1: Color(kLight.value),
                  width: width * 0.4,
                  height: hieght * 0.06,
                  onTap: () async {
                    boardedDone();
                    Get.to(() => loginPage());
                  },
                ),
                GestureDetector(
                  onTap: () async {
                    boardedDone();
                    Get.to(() => const registerPage());
                  },
                  child: Container(
                      width: width * 0.4,
                      height: hieght * 0.06,
                      color: Color(kLight.value),
                      child: Center(
                        child: reusableText(
                            text: "Sign Up",
                            style: appStyle(
                                16, Color(kLightBlue.value), FontWeight.w600)),
                      )),
                ),
              ],
            ),
            const heightSpacer(size: 30),
            GestureDetector(
              onTap: () {
                boardedDone();
                Get.to(() => const mainScreen());
              },
              child: reusableText(
                  text: "Continue as guest",
                  style: appStyle(16, Color(kLight.value), FontWeight.w600)),
            )
          ],
        ),
      ),
    );
  }
}
