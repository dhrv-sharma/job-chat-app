import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobchat/view/common/appstyle.dart';
import 'package:jobchat/view/common/resuabletext.dart';
import 'package:jobchat/view/common/widthspacer.dart';

class drawerItem extends StatelessWidget {
  const drawerItem(
      {super.key,
      required this.icon,
      required this.text,
      required this.index,
      required this.color,
      this.indexSetter});

  final IconData icon; // accpets the different type of icons
  final String text;
  final int index;
  final Color color;
  final ValueSetter? indexSetter;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // when tapped function passed from main screen start executing
        // it indirectly changes the provider data
        indexSetter!(index);
      },
      child: Container(
        margin: EdgeInsets.only(left: 20.w, bottom: 20.h),
        child: Row(
          children: [
            Icon(
              icon,
              color: color,
            ),
            const widthSpacer(size: 12),
            reusableText(
                text: text, style: appStyle(12, color, FontWeight.bold))
          ],
        ),
      ),
    );
  }
}
