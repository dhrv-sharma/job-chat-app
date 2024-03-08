import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:jobchat/constants/app_constants.dart';
import 'package:jobchat/controllers/jobs_provider.dart';
import 'package:jobchat/models/job.dart';
import 'package:jobchat/view/common/NoSearchResult.dart';
import 'package:jobchat/view/common/appstyle.dart';
import 'package:jobchat/view/common/buildStyleContainer.dart';
import 'package:jobchat/view/common/custom_outline_btn.dart';
import 'package:jobchat/view/common/customappBar.dart';
import 'package:jobchat/view/common/heightSpacer.dart';
import 'package:jobchat/view/common/pageloader.dart';
import 'package:jobchat/view/common/resuabletext.dart';
import 'package:provider/provider.dart';

class jobView extends StatefulWidget {
  const jobView({super.key, required this.job});

  final Job job;

  @override
  State<jobView> createState() => _jobViewState();
}

class _jobViewState extends State<jobView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<JobsNotifier>(
      builder: (context, jobsNotifier, child) {
        jobsNotifier.getJob(widget.job.id);
        return Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: CustomAppbar(
                  text: "",
                  actions: [
                    GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.only(right: 14.w),
                        child: const Icon(
                          Fontisto.bookmark,
                        ),
                      ),
                    )
                  ],
                  child: const BackButton())),
          body: buildStyleContainer(
              context,
              // <We have to put that parameter on which my UI getting dependent here we are waiting for Job >
              FutureBuilder<Job>(
                  future: jobsNotifier.job,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // runs when the future builder loading data
                      return const Center(
                        child: PageLoader(),
                      );
                    } else if (snapshot.hasError) {
                      // when there is some error
                      return Text("Error: +${snapshot.error}");
                    } else if (snapshot.data == Null) {
                      // not able to find
                      return const NoSearchResults(message: "Not able to Load");
                    } else {
                      // job found
                      final job = snapshot.data;
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Stack(
                          children: [
                            ListView(
                              padding: EdgeInsets.zero,
                              children: [
                                Container(
                                  width: width,
                                  height: hieght * 0.27,
                                  decoration: BoxDecoration(
                                      color: Color(kLightGrey.value)
                                          .withOpacity(0.2),
                                      image: const DecorationImage(
                                          image: AssetImage(
                                              "assets/images/jobs.png"),
                                          opacity: 0.25),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(9.w))),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 30.w,
                                        backgroundImage:
                                            NetworkImage(job!.imageUrl),
                                      ),
                                      const heightSpacer(size: 10),
                                      reusableText(
                                          text: job.title,
                                          style: appStyle(
                                              16,
                                              Color(kDark.value),
                                              FontWeight.w600)),
                                      const heightSpacer(size: 10),
                                      reusableText(
                                          text: job.location,
                                          style: appStyle(
                                              16,
                                              Color(kDark.value)
                                                  .withOpacity(0.7),
                                              FontWeight.w600)),
                                      const heightSpacer(size: 5),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 50),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            customOutlineButton(
                                                width: width * 0.26,
                                                height: hieght * 0.04,
                                                text: job.contract,
                                                color1: Color(kOrange.value)),
                                            Row(
                                              children: [
                                                reusableText(
                                                    text: job.salary,
                                                    style: appStyle(
                                                        16,
                                                        Color(kDark.value),
                                                        FontWeight.w600)),
                                                reusableText(
                                                    text: "/${job.period}",
                                                    style: appStyle(
                                                        16,
                                                        Color(kDark.value)
                                                            .withOpacity(0.7),
                                                        FontWeight.w600)),
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const heightSpacer(size: 20),
                                reusableText(
                                    text: "Description",
                                    style: appStyle(18, Color(kDark.value),
                                        FontWeight.bold)),
                                const heightSpacer(size: 10),
                                Text(
                                  job.description,
                                  textAlign: TextAlign.justify,
                                  maxLines: 9,
                                  style: appStyle(
                                      12,
                                      Color(kDark.value).withOpacity(0.72),
                                      FontWeight.w600),
                                ),
                                const heightSpacer(size: 10),
                                reusableText(
                                    text: "Requirements",
                                    style: appStyle(18, Color(kDark.value),
                                        FontWeight.bold)),
                                const heightSpacer(size: 10),
                                SizedBox(
                                  height: hieght * 0.6,
                                  child: ListView.builder(
                                      itemCount: job.requirements.length,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        var requirement =
                                            job.requirements[index];
                                        String bullet = '\u2022';
                                        return Padding(
                                          padding:
                                              EdgeInsets.only(bottom: 12.w),
                                          child: Text(
                                            "${bullet}  ${requirement}",
                                            style: appStyle(
                                                12,
                                                Color(kDark.value)
                                                    .withOpacity(0.72),
                                                FontWeight.bold),
                                          ),
                                        );
                                      }),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: customOutlineButton(
                                    text: "Please Login",
                                    height: hieght * 0.06,
                                    color1: Color(kLight.value),
                                    color2: Color(kOrange.value),
                                  )),
                            )
                          ],
                        ),
                      );
                    }
                  })),
        );
      },
    );
  }
}
