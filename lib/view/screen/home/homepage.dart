import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:jobchat/constants/app_constants.dart';
import 'package:jobchat/view/common/appstyle.dart';
import 'package:jobchat/view/common/customappBar.dart';
import 'package:jobchat/view/common/headingWidget.dart';
import 'package:jobchat/view/common/heightSpacer.dart';
import 'package:jobchat/view/common/jobHorizontal.dart';
import 'package:jobchat/view/drawer/drawer_widget.dart';
import 'package:jobchat/view/screen/home/recentList.dart';
import 'package:jobchat/view/screen/home/searchWidget.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.h),
            child: CustomAppbar(
              text: "",
              actions: [
                Padding(
                  padding: EdgeInsets.all(12.h),
                  child: const CircleAvatar(
                    radius: 15,
                    backgroundImage: AssetImage("assets/images/user.png"),
                  ),
                )
              ],
              child: Padding(
                  padding: EdgeInsets.all(12.0.h), child: const DrawerWidget()),
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
              searchWidget(onTap: () {}),
              heightSpacer(size: 30.h),
              headingWidget(text: "Popular Jobs", onTap: () {}),
              heightSpacer(size: 15.h),

              SizedBox(
                height: hieght * 0.28,
                child: ListView.builder(
                    itemCount: 7,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return jobHorizontalTile(
                          onTap: () {},
                          company: "Google",
                          description: "Flutter Developer",
                          location: "NewYork(Remote)",
                          salary: "35");
                    }),
              ),
              heightSpacer(size: 15.h),
              headingWidget(text: "Recently Posted", onTap: () {}),
              heightSpacer(size: 15.h),
              // need future builer for api and data fetch from the server
              const recentList()
            ],
          ),
        ))));
  }
}
