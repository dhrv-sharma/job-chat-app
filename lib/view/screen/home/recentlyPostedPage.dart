import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobchat/view/common/customappBar.dart';
import 'package:jobchat/view/screen/home/recentlyJobListItempage.dart';

class recentlyJobList extends StatelessWidget {
  const recentlyJobList({super.key});

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.w),
          child: const CustomAppbar(
            text: "Recent Jobs",
            actions: [],
            child:
                BackButton(), // back button automatically lie to the previos stack page
          )),
      body: const recentlyJobListItem(),
    );
  }
}
