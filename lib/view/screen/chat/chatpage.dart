import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobchat/constants/app_constants.dart';
import 'package:jobchat/controllers/login_provider.dart';
import 'package:jobchat/view/common/appstyle.dart';
import 'package:jobchat/view/drawer/drawer_widget.dart';
import 'package:jobchat/view/screen/chat/agentTab.dart';
import 'package:jobchat/view/screen/chat/chatTab.dart';
import 'package:jobchat/view/screen/chat/exploreTab.dart';
import 'package:jobchat/view/screen/guest/non_user.dart';
import 'package:provider/provider.dart';

class chatPage extends StatefulWidget {
  const chatPage({super.key});

  @override
  State<chatPage> createState() => _chatPageState();
}

class _chatPageState extends State<chatPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    late TabController tabController = TabController(length: 3, vsync: this);
    var loginNotifier = Provider.of<LoginNotifier>(context);
    return Scaffold(
        backgroundColor: const Color(0xff171717),
        appBar: AppBar(
          backgroundColor: const Color(0xff171717),
          elevation: 0,
          leading: Padding(
            padding: EdgeInsets.all(12.w),
            child: DrawerWidget(
              color: Color(kLight.value),
            ),
          ),
          title: !loginNotifier.loggedIn
              ? const SizedBox.shrink()
              : TabBar(
                  dividerColor: Colors.transparent,
                  controller: tabController,
                  labelColor: Color(kLight.value),
                  indicatorColor: Colors.transparent,
                  padding: EdgeInsets.all(3.w),
                  labelStyle:
                      appStyle(12, Color(kLight.value), FontWeight.w500),
                  unselectedLabelColor: Colors.grey.withOpacity(.5),
                  tabs: const [
                      Tab(
                        text: "Message",
                      ),
                      Tab(
                        text: "Agents",
                      ),
                      Tab(
                        text: "Explore",
                      )
                    ]),
        ),
        body: loginNotifier.loggedIn == false
            ? const nonUser()
            : TabBarView(
                controller: tabController,
                children: const [chatTab(), agentTab(), exploreTab()]));
  }
}
