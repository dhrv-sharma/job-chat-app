import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobchat/constants/app_constants.dart';
import 'package:jobchat/view/common/appstyle.dart';
import 'package:jobchat/view/common/resuabletext.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar(
      {super.key,
      required this.text,
      required this.child,
      required this.actions,
      this.color,
      this.textColor});

  final String text;
  final Widget child;
  final List<Widget> actions;
  final Color? color;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(),
      backgroundColor: color ?? Color(kLight.value),
      elevation: 0,
      automaticallyImplyLeading: false,
      //Specifies the width of the leading widget. It's set to 70.w, which suggests that it might be a responsive width based on the screen size or device width.
      leadingWidth: 70.w,
      // leading: child, he widget to be used as the leading element. It's assigned the value of the variable child. Ensure that child is defined and contains a valid widget.
      //  A list of widgets to be used as action elements on the right side of the AppBar. It's assigned the value of the variable actions. Ensure that actions is defined and contains a valid list of widgets.
      actions: actions,
      leading: child,
      centerTitle: true,
      title: reusableText(
          text: text.toString(),
          style:
              appStyle(16, textColor ?? Color(kDark.value), FontWeight.w600)),
    );
  }
}
