import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobchat/constants/app_constants.dart';
import 'package:jobchat/controllers/login_provider.dart';
import 'package:jobchat/controllers/profile_provider.dart';
import 'package:jobchat/view/common/appstyle.dart';
import 'package:jobchat/view/common/customappBar.dart';
import 'package:jobchat/view/common/headingWidget.dart';
import 'package:jobchat/view/common/heightSpacer.dart';
import 'package:jobchat/view/drawer/drawer_widget.dart';
import 'package:jobchat/view/screen/home/popularJobPage.dart';
import 'package:jobchat/view/screen/home/popularJobs.dart';
import 'package:jobchat/view/screen/home/recentList.dart';
import 'package:jobchat/view/screen/home/recentlyPostedPage.dart';
import 'package:jobchat/view/screen/home/searchPage.dart';
import 'package:jobchat/view/screen/home/searchWidget.dart';
import 'package:provider/provider.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    var loginNotfier = Provider.of<LoginNotifier>(context);
    loginNotfier.getData();
    return Consumer<ProfileNotifier>(
        builder: (context, profileNotifier, child) {
      return Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(50.h),
              child: CustomAppbar(
                text: "",
                actions: [
                  Padding(
                    padding: EdgeInsets.all(12.h),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          NetworkImage(profileNotifier.profileImage),
                    ),
                  )
                ],
                child: Padding(
                    padding: EdgeInsets.all(12.0.h),
                    child: const DrawerWidget()),
              )),
          body: SafeArea(
              child: SingleChildScrollView(
                  child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Search \nFind  & Apply",
                  style: appStyle(38, Color(kDark.value), FontWeight.bold),
                ),
                heightSpacer(size: 20.h),
                searchWidget(onTap: () {
                  Get.to(() => const searchPage());
                }),
                heightSpacer(size: 30.h),
                headingWidget(
                    text: "Popular Jobs",
                    onTap: () {
                      Get.to(() => const popularJobsList());
                    }),
                heightSpacer(size: 15.h),
                ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(12.w)),
                    child: const popularJobs()),
                heightSpacer(size: 15.h),
                headingWidget(
                    text: "Recently Posted",
                    onTap: () {
                      Get.to(() => const recentlyJobList());
                    }),
                heightSpacer(size: 15.h),
                // need future builder for api and data fetch from the server
                const recentList()
              ],
            ),
          ))));
    });
  }
}
