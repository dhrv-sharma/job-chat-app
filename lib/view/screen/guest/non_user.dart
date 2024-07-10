import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobchat/constants/app_constants.dart';
import 'package:jobchat/view/common/appstyle.dart';
import 'package:jobchat/view/common/buildStyleContainer.dart';
import 'package:jobchat/view/common/custome_outline_btn.dart';
import 'package:jobchat/view/common/heightSpacer.dart';
import 'package:jobchat/view/common/resuabletext.dart';
import 'package:jobchat/view/screen/auth/login.dart';

class nonUser extends StatelessWidget {
  const nonUser({super.key});

  @override
  Widget build(BuildContext context) {
    return buildStyleContainer(
        context,
        Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(99.w)),
              child: CachedNetworkImage(
                imageUrl:
                    'https://res.cloudinary.com/dap69mong/image/upload/v1710654983/fbdrtr3b8spuotwu3r28.jpg',
                fit: BoxFit.cover,
                width: 70.w,
                height: 70.w,
              ),
            ),
            const heightSpacer(size: 20),
            reusableText(
                text: "To access content please login",
                style:
                    appStyle(12, Color(kBlueColor.value), FontWeight.normal)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
              child: CustomOutlineBtn(
                  onTap: () {
                    Get.to(() => const loginPage());
                  },
                  width: width,
                  hieght: 40.h,
                  text: "Proceed to Login",
                  color: Color(kOrange.value)),
            )
          ],
        ));
  }
}
