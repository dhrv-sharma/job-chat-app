import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobchat/constants/app_constants.dart';
import 'package:jobchat/models/bookmark.dart/all_bookmarks.dart';
import 'package:jobchat/view/common/appstyle.dart';

import 'package:jobchat/view/common/custome_outline_btn.dart';
import 'package:jobchat/view/common/resuabletext.dart';
import 'package:jobchat/view/common/widthspacer.dart';

class bookMarkTile extends StatelessWidget {
  const bookMarkTile({
    super.key,
    required this.bookMark,
    required this.onTap,
  });

  final AllBookMarks bookMark;

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          height: hieght * 0.12,
          width: width,
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
          decoration: BoxDecoration(
              color: const Color(0x09000000),
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
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(bookMark.job.imageUrl),
                      ),
                      widthSpacer(size: 10.w),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // company name
                          reusableText(
                              text: bookMark.job.company,
                              style: appStyle(
                                  18, Color(kDark.value), FontWeight.w500)),
                          // job title
                          SizedBox(
                            width: width * 0.5,
                            child: reusableText(
                                text: bookMark.job.title,
                                style: appStyle(
                                    12,
                                    Color(kDark.value).withOpacity(0.6),
                                    FontWeight.bold)),
                          ),
                          // salary  with period
                          reusableText(
                              text:
                                  "${bookMark.job.salary}/${bookMark.job.period}",
                              style: appStyle(
                                  16, Color(kDark.value), FontWeight.w500)),
                        ],
                      ),
                      CustomOutlineBtn(
                          width: 76.w,
                          hieght: 36.h,
                          text: "View",
                          color: Color(kLightBlue.value))
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
