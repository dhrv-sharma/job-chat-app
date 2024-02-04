import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobchat/view/common/customappBar.dart';
import 'package:jobchat/view/drawer/drawer_widget.dart';

class deviceMgmt extends StatefulWidget {
  const deviceMgmt({super.key});

  @override
  State<deviceMgmt> createState() => _deviceMgmtState();
}

class _deviceMgmtState extends State<deviceMgmt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: CustomAppbar(
            text: "Device Management",
            actions: const [],
            child: Padding(
                padding: EdgeInsets.all(12.0.h), child: const DrawerWidget()),
          )),
    );
  }
}
