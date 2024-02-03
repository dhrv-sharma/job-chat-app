import 'package:flutter/material.dart';
import 'package:jobchat/constants/app_constants.dart';
import 'package:jobchat/view/common/appstyle.dart';
import 'package:jobchat/view/common/resuabletext.dart';

class customButton extends StatelessWidget {
  const customButton(
      {super.key, required this.text, required this.onTap, this.color});

  final String text;
  final Color? color;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Color(kOrange.value),
        width: width,
        height: hieght * 0.065,
        child: Center(
          child: reusableText(
              text: text,
              style:
                  appStyle(16, color ?? Color(kLight.value), FontWeight.w600)),
        ),
      ),
    );
  }
}
