import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobchat/constants/app_constants.dart';
import 'package:jobchat/view/common/appstyle.dart';
import 'package:jobchat/view/common/resuabletext.dart';
import 'package:jobchat/view/common/widthspacer.dart';

class NoSearchResults extends StatelessWidget {
  const NoSearchResults({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images,optimized_search.png"),
          const widthSpacer(size: 20),
          reusableText(
              text: message,
              style: appStyle(18, Color(kDark.value), FontWeight.w500))
        ],
      ),
    );
  }
}
