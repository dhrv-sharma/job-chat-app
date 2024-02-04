import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobchat/constants/app_constants.dart';
import 'package:jobchat/view/common/appstyle.dart';
import 'package:jobchat/view/common/resuabletext.dart';

class headingWidget extends StatelessWidget {
  const headingWidget({super.key, required this.text, required this.onTap});

  final String text;

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        reusableText(
            text: text,
            style: appStyle(20, Color(kDark.value), FontWeight.w600)),
        GestureDetector(
          onTap: onTap,
          child: reusableText(
              text: "View All",
              style: appStyle(20, Color(kOrange.value), FontWeight.w600)),
        )
      ],
    );
  }
}
