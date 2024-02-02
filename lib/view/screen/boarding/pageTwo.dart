import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobchat/constants/app_constants.dart';
import 'package:jobchat/view/common/appstyle.dart';
import 'package:jobchat/view/common/heightSpacer.dart';

class pageTwo extends StatelessWidget {
  const pageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: width,
        height: hieght,
        color: Color(kDarkBlue.value),
        child: Column(
          children: [
            const heightSpacer(size: 65),
            Padding(
              padding: EdgeInsets.all(8.h),
              child: Image.asset("assets/images/page2.png"),
            ),
            const heightSpacer(size: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Stable Yourself \n With Your Ability",
                  style: appStyle(30, Color(kLight.value), FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                const heightSpacer(size: 10),
                Padding(
                  padding: EdgeInsets.all(8.h),
                  child: Text(
                    "We help you to find your dream job according to your skillbase,location and preferences to builder your corner",
                    textAlign: TextAlign.center,
                    style: appStyle(14, Color(kLight.value), FontWeight.normal),
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
