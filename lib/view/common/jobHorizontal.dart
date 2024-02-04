import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:jobchat/constants/app_constants.dart';
import 'package:jobchat/view/common/appstyle.dart';
import 'package:jobchat/view/common/heightSpacer.dart';
import 'package:jobchat/view/common/resuabletext.dart';
import 'package:jobchat/view/common/widthspacer.dart';

class jobHorizontalTile extends StatelessWidget {
  const jobHorizontalTile(
      {super.key,
      required this.onTap,
      required this.company,
      required this.description,
      required this.location,
      required this.salary});

  final void Function() onTap;
  final String company;
  final String description;
  final String location;
  final String salary;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(right: 12.w),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          width: width * 0.7,
          height: hieght * 0.27,
          color: Color(kLightGrey.value),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage("assets/images/user.png"),
                  ),
                  const widthSpacer(size: 15),
                  reusableText(
                      text: company,
                      style: appStyle(20, Color(kDark.value), FontWeight.w600)),
                ],
              ),
              const heightSpacer(size: 15),
              reusableText(
                  text: description,
                  style: appStyle(20, Color(kDark.value), FontWeight.w600)),
              reusableText(
                  text: location,
                  style: appStyle(16, Color(kDarkGrey.value), FontWeight.w600)),
              const heightSpacer(size: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      reusableText(
                          text: salary,
                          style: appStyle(
                              20, Color(kDark.value), FontWeight.w600)),
                      reusableText(
                          text: "/monthly",
                          style: appStyle(
                              20, Color(kDarkGrey.value), FontWeight.w600))
                    ],
                  ),
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Color(kLight.value),
                    child: const Icon(Ionicons.chevron_forward),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
