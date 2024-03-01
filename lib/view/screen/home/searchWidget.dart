import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:jobchat/constants/app_constants.dart';
import 'package:jobchat/view/common/appstyle.dart';
import 'package:jobchat/view/common/resuabletext.dart';
import 'package:jobchat/view/common/widthspacer.dart';

class searchWidget extends StatelessWidget {
  const searchWidget({super.key, required this.onTap});

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: FittedBox(
        // fitted box resize the child according to the screen size
        child: Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
              color: Color(kLightGrey.value).withOpacity(0.3),
              borderRadius: BorderRadius.all(Radius.circular(10.w))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: width * 0.84,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Color(kOrange.value),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(9)),
                      ),
                      child: Icon(
                        Feather.search,
                        color: Color(kLight.value),
                        size: 20.h,
                      ),
                    ),
                    const widthSpacer(size: 20),
                    reusableText(
                        text: "Search For Jobs",
                        style:
                            appStyle(16, Color(kDark.value), FontWeight.w600)),
                  ],
                ),
              ),
              Icon(
                FontAwesome.sliders,
                color: Color(kDark.value),
                size: 20.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}
