import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:jobchat/constants/app_constants.dart';
import 'package:jobchat/models/job.dart';
import 'package:jobchat/view/common/appstyle.dart';
import 'package:jobchat/view/common/heightSpacer.dart';
import 'package:jobchat/view/common/resuabletext.dart';
import 'package:jobchat/view/common/widthspacer.dart';
import 'package:jobchat/view/screen/job/jobview.dart';

class jobHorizontalTile extends StatelessWidget {
  const jobHorizontalTile({super.key, required this.onTap, required this.job});

  final void Function() onTap;

  final Job job;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
          padding: EdgeInsets.only(right: 12.w),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(12.w)),
            child: Container(
                height: hieght * 0.27,
                width: width * 0.7,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
                decoration: BoxDecoration(
                    color: Color(kLightGrey.value).withOpacity(0.2),
                    image: const DecorationImage(
                        image: AssetImage('assets/images/jobs.png'),
                        fit: BoxFit.contain,
                        opacity: 0.3)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(job.imageUrl),
                        ),
                        const widthSpacer(size: 15),
                        Container(
                          width: 160.w,
                          padding:
                              EdgeInsetsDirectional.symmetric(horizontal: 20.w),
                          decoration: BoxDecoration(
                              color: Color(kLight.value),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.w))),
                          child: reusableText(
                              text: job.company!,
                              style: appStyle(
                                  22, Color(kDark.value), FontWeight.w600)),
                        )
                      ],
                    ),
                    const heightSpacer(size: 15),
                    reusableText(
                        text: job.title,
                        style:
                            appStyle(20, Color(kDark.value), FontWeight.w600)),
                    const heightSpacer(size: 5),
                    reusableText(
                        text: job.location,
                        style: appStyle(18, Color(kDark.value).withOpacity(0.6),
                            FontWeight.w600)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            reusableText(
                                text: "${job.salary}",
                                style: appStyle(
                                    20, Color(kDark.value), FontWeight.w600)),
                            reusableText(
                                text: "/${job.period}",
                                style: appStyle(
                                    18,
                                    Color(kDark.value).withOpacity(0.6),
                                    FontWeight.w600)),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => jobView(job: job));
                          },
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: Color(kLight.value),
                            child: const Icon(Ionicons.chevron_forward),
                          ),
                        )
                      ],
                    ),
                  ],
                )),
          )),
    );
  }
}
