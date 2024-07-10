import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:jobchat/constants/app_constants.dart';
import 'package:jobchat/view/common/appstyle.dart';
import 'package:jobchat/view/common/resuabletext.dart';

class chatTab extends StatefulWidget {
  const chatTab({super.key});

  @override
  State<chatTab> createState() => _chatTabState();
}

class _chatTabState extends State<chatTab> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            top: 20,
            right: 0,
            left: 0,
            child: Container(
              padding: EdgeInsets.only(top: 15.w, left: 15.w, right: 0.w),
              height: 220.h,
              decoration: BoxDecoration(
                  color: Color(kBlueColor.value),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.w),
                      topRight: Radius.circular(20.w))),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      reusableText(
                          text: "Agent and Companies",
                          style: appStyle(
                              12, Color(kLight.value), FontWeight.normal)),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            AntDesign.ellipsis1,
                            color: Color(kLight.value),
                          ))
                    ],
                  )
                ],
              ),
            )),
        Positioned(
            top: 150.h,
            right: 0,
            left: 0,
            child: Container(
              width: width,
              height: hieght,
              decoration: BoxDecoration(
                  color: Color(kLight.value),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.w),
                      topRight: Radius.circular(20.w))),
            ))
      ],
    );
  }
}
