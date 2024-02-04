import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobchat/view/common/customappBar.dart';
import 'package:jobchat/view/drawer/drawer_widget.dart';

class bookaMark extends StatefulWidget {
  const bookaMark({super.key});

  @override
  State<bookaMark> createState() => _bookaMarkState();
}

class _bookaMarkState extends State<bookaMark> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: CustomAppbar(
            text: "Bookmarks",
            actions: const [],
            child: Padding(
                padding: EdgeInsets.all(12.0.h), child: const DrawerWidget()),
          )),
    );
  }
}
