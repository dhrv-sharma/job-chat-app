import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobchat/constants/app_constants.dart';
import 'package:jobchat/view/common/appstyle.dart';
import 'package:jobchat/view/common/heightSpacer.dart';
import 'package:jobchat/view/common/resuabletext.dart';

class pageOne extends StatelessWidget {
  const pageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: width,
        height: hieght,
        color: Color(kDarkPurple.value),
        child: Column(
          children: [
            const heightSpacer(size: 70),
            Image.asset("assets/images/page1.png"),
            const heightSpacer(size: 40),
            Column(
              children: [
                reusableText(
                    text: "Find Your Dream Job",
                    style: appStyle(30, Color(kLight.value), FontWeight.w500)),
                const heightSpacer(size: 10),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0.w),
                    child: Text(
                      "We help you to find your dream job according to your skillbase,location and preferences to builder your corner",
                      style: appStyle(
                        14,
                        Color(kLight.value),
                        FontWeight.normal,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
