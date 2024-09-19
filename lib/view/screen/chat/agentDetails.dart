import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:jobchat/constants/app_constants.dart';
import 'package:jobchat/controllers/agent_provider.dart';
import 'package:jobchat/models/auth/profile_model.dart';
import 'package:jobchat/models/getAgent.dart';
import 'package:jobchat/view/common/appstyle.dart';
import 'package:jobchat/view/common/resuabletext.dart';
import 'package:jobchat/view/screen/chat/agentJob.dart';
import 'package:jobchat/view/screen/profile/profile.dart';
import 'package:provider/provider.dart';

class agentDetailPage extends StatelessWidget {
  agentDetailPage({super.key, required this.myProfile});

  ProfileRes myProfile;

  @override
  Widget build(BuildContext context) {
    var agentClicked = Provider.of<agentProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xff171717),
      appBar: AppBar(
        backgroundColor: const Color(0xff171717),
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(12.w),
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              AntDesign.leftcircleo,
              color: kLight,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Container(
                padding: EdgeInsets.only(
                    top: 2.w, left: 12.w, right: 0.w, bottom: 10.w),
                height: 100.h,
                decoration: BoxDecoration(
                    color: Color(kBlueColor.value),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.w),
                        topRight: Radius.circular(20.w))),
                child: Consumer<agentProvider>(
                    builder: (context, agentNotifier, child) {
                  return Padding(
                    padding: EdgeInsets.all(8.w),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  reusableText(
                                      text: "Company name",
                                      style: appStyle(10, Color(kLight.value),
                                          FontWeight.w500)),
                                  reusableText(
                                      text: "Address",
                                      style: appStyle(10, Color(kLight.value),
                                          FontWeight.w500)),
                                  reusableText(
                                      text: "Working hours",
                                      style: appStyle(10, Color(kLight.value),
                                          FontWeight.w500)),
                                ],
                              ),
                              // code for straight line
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Container(
                                  height: 60.w,
                                  width: 1.w,
                                  color: Color(kLight.value),
                                ),
                              ),

                              FutureBuilder<GetAgent?>(
                                  future: agentNotifier
                                      .getAgentinfo(agentNotifier.agent!.uid),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return SizedBox(
                                        height: 60.w,
                                        child: Center(
                                          child: CircularProgressIndicator
                                              .adaptive(
                                            backgroundColor:
                                                Color(kLight.value),
                                          ),
                                        ),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text("Error : ${snapshot.error}");
                                    } else {
                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          reusableText(
                                              text: snapshot.data!.company,
                                              style: appStyle(
                                                  10,
                                                  Color(kLight.value),
                                                  FontWeight.w500)),
                                          reusableText(
                                              text: snapshot.data!.hqAddress,
                                              style: appStyle(
                                                  10,
                                                  Color(kLight.value),
                                                  FontWeight.w500)),
                                          reusableText(
                                              text: snapshot.data!.workingHrs,
                                              style: appStyle(
                                                  10,
                                                  Color(kLight.value),
                                                  FontWeight.w500)),
                                        ],
                                      );
                                    }
                                  }),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 5.w,
                          top: 8.h,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(99.w)),
                                border: Border.all(
                                  width: 1,
                                  color: Color(kLight.value),
                                )),
                            // circular avatar picked from the profile page
                            child: circularAvtr(
                                image: agentNotifier.agent!.profile,
                                width: 50,
                                height: 50),
                          ),
                        )
                      ],
                    ),
                  );
                }),
              )),
          Positioned(
              top: 80.h,
              right: 0,
              left: 0,
              child: Container(
                  height: hieght,
                  width: width,
                  decoration: BoxDecoration(
                      color: Color(kLight.value),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.w),
                          topRight: Radius.circular(20.w))),
                  child: agentJob(
                    uid: agentClicked.agent!.userid,
                    agent: agentClicked.agent!,
                    myProfile: myProfile,
                  )))
        ],
      ),
    );
  }
}
