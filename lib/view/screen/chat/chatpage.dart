import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobchat/constants/app_constants.dart';
import 'package:jobchat/controllers/login_provider.dart';
import 'package:jobchat/controllers/zoom_provider.dart';
import 'package:jobchat/view/common/appstyle.dart';
import 'package:jobchat/view/drawer/drawer_widget.dart';
import 'package:jobchat/view/screen/chat/agentTab.dart';
import 'package:jobchat/view/screen/chat/chatTab.dart';
import 'package:jobchat/view/screen/chat/exploreTab.dart';
import 'package:jobchat/view/screen/guest/non_user.dart';
import 'package:jobchat/view/screen/home/mainscreen.dart';
import 'package:provider/provider.dart';

class chatPage extends StatefulWidget {
  const chatPage({super.key});

  @override
  State<chatPage> createState() => _chatPageState();
}

class _chatPageState extends State<chatPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    var zoomNotifier = Provider.of<ZoomNotifier>(context, listen: false);

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
                children: const [chatTab(), agentTab(), exploreTab()]),
        bottomNavigationBar: Theme(
          data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent),
          child: BottomNavigationBar(
              onTap: (index) {
                zoomNotifier.currentIndex = index;

                Get.offAll(const mainScreen());
              },
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedItemColor: primaryColor,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              currentIndex: zoomNotifier.currentIndex,
              items: const [
                BottomNavigationBarItem(
                    label: "Home",
                    icon: Icon(
                      Icons.home,
                      size: 20,
                    )),
                BottomNavigationBarItem(
                    label: "Chats",
                    icon: Icon(
                      Icons.chat_outlined,
                      size: 20,
                    )),
                BottomNavigationBarItem(
                    label: "BookMark",
                    icon: Icon(
                      Icons.bookmark_border_outlined,
                      size: 20,
                    )),
                BottomNavigationBarItem(
                  label: "Application",
                  icon: Icon(Icons.description_outlined),
                ),
                BottomNavigationBarItem(
                    label: "Profile",
                    icon: Icon(
                      Icons.person,
                      size: 20,
                    )),
              ]),
        ));
  }
}
