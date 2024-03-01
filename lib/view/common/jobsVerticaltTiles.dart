import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:jobchat/constants/app_constants.dart';
import 'package:jobchat/view/common/appstyle.dart';
import 'package:jobchat/view/common/resuabletext.dart';
import 'package:jobchat/view/common/widthspacer.dart';

class JobsVerticalTile extends StatelessWidget {
  const JobsVerticalTile({super.key});

  // it will recieve an model of job from the recentlist

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          height: hieght * 0.12,
          width: width,
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
          decoration: BoxDecoration(
              color: Color(kLightGrey.value).withOpacity(0.2),
              borderRadius: BorderRadius.all(Radius.circular(9.w))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      // need to change the network image recive from the server
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/images/slack.png'),
                      ),
                      widthSpacer(size: 10.w),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // company name
                          reusableText(
                              text: "Google",
                              style: appStyle(
                                  18, Color(kDark.value), FontWeight.w500)),
                          // job title
                          SizedBox(
                            width: width * 0.5,
                            child: reusableText(
                                text: "Flutter Full Stack  Developer",
                                style: appStyle(
                                    16,
                                    Color(kDark.value).withOpacity(0.6),
                                    FontWeight.bold)),
                          ),
                          // salary  with period
                          reusableText(
                              text: "25k per month",
                              style: appStyle(
                                  16, Color(kDark.value), FontWeight.w500)),
                        ],
                      )
                    ],
                  ),
                  CircleAvatar(
                    radius: 15,
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
