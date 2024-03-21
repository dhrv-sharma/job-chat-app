import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:jobchat/constants/app_constants.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    var zoomDrawer = ZoomDrawer.of(context);
    return GestureDetector(
      onTap: () {
        zoomDrawer!.toggle();
      },
      child: SvgPicture.asset(
        "assets/icons/menu.svg",
        width: 30.w,
        height: 30.h,
        color: color ?? Color(kDark.value),
      ), // install svg package
    );
  }
}
