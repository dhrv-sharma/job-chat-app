import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobchat/view/common/customappBar.dart';
import 'package:jobchat/view/screen/home/popluarJobPageList.dart';

class popularJobsList extends StatelessWidget {
  const popularJobsList({super.key});

// popular job page is the page and JobListPopular() is the defination of the Future builder  in the page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.w),
          child: const CustomAppbar(
            text: "Popular Jobs",
            actions: [],
            child:
                BackButton(), // back button automatically lie to the previos stack page
          )),
      body: const JobListPopular(),
    );
  }
}
