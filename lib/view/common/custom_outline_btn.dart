import 'package:flutter/material.dart';
import 'package:jobchat/view/common/appstyle.dart';
import 'package:jobchat/view/common/resuabletext.dart';

class customOutlineButton extends StatelessWidget {
  const customOutlineButton(
      {super.key,
      required this.text,
      required this.color1,
      this.color2,
      this.width,
      this.height,
      this.onTap});

  final double? width;
  final double? height;
  final String text;
  final void Function()? onTap;
  final Color color1; // for the text color as well as border color
  final Color? color2; // for the button color

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: color2,
            border: Border.all(
                // set the border properties of the button
                width: 1,
                color: color1)),
        child: Center(
          child: reusableText(
              text: text, style: appStyle(16, color1, FontWeight.w600)),
        ),
      ),
    );
  }
}
