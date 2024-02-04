import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobchat/constants/app_constants.dart';
import 'package:jobchat/view/common/appstyle.dart';
import 'package:jobchat/view/common/customappBar.dart';
import 'package:jobchat/view/common/headingWidget.dart';
import 'package:jobchat/view/common/heightSpacer.dart';
import 'package:jobchat/view/common/jobHorizontal.dart';
import 'package:jobchat/view/drawer/drawer_widget.dart';
import 'package:jobchat/view/screen/home/searchWidget.dart';
import 'package:jobchat/view/screen/search/searchPage.dart';

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
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const heightSpacer(size: 10),
              Text(
                "Search \nFind & Apply", // \n next line character
                style: appStyle(40, Color(kDark.value), FontWeight.bold),
              ),
              const heightSpacer(size: 40),
              searchWidget(onTap: () {
                Get.to(() => const searchPage());
              }),
              const heightSpacer(size: 30),
              headingWidget(text: "Popular Jobs", onTap: () {}),
              const heightSpacer(size: 20),
              SizedBox(
                height: hieght * 0.28,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return jobHorizontalTile(
                          onTap: () {},
                          company: "FaceBook",
                          description: "Senior Flutter Developer",
                          location: "washington",
                          salary: "15k");
                    }),
              ),
              const heightSpacer(size: 20),
              headingWidget(text: "Recently Posted", onTap: () {}),
            ],
          ),
        ),
      )),
    );
  }
}
