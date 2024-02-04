import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobchat/view/common/customappBar.dart';
import 'package:jobchat/view/drawer/drawer_widget.dart';

class chatPage extends StatefulWidget {
  const chatPage({super.key});

  @override
  State<chatPage> createState() => _chatPageState();
}

class _chatPageState extends State<chatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: CustomAppbar(
            text: "Chats",
            actions: const [],
            child: Padding(
                padding: EdgeInsets.all(12.0.h), child: const DrawerWidget()),
          )),
    );
  }
}
