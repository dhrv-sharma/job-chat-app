import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jobchat/constants/app_constants.dart';
import 'package:jobchat/controllers/login_provider.dart';
import 'package:jobchat/controllers/zoom_provider.dart';
import 'package:jobchat/view/common/customappBar.dart';
import 'package:jobchat/view/drawer/drawer_widget.dart';
import 'package:jobchat/view/screen/guest/non_user.dart';
import 'package:jobchat/view/screen/home/mainscreen.dart';
import 'package:provider/provider.dart';

class deviceMgmt extends StatefulWidget {
  const deviceMgmt({super.key});

  @override
  State<deviceMgmt> createState() => _deviceMgmtState();
}

class _deviceMgmtState extends State<deviceMgmt> {
  @override
  Widget build(BuildContext context) {
    var zoomNotifier = Provider.of<ZoomNotifier>(context, listen: false);

    var loginNotifier = Provider.of<LoginNotifier>(context);
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.h),
            child: CustomAppbar(
              text: "Applications",
              actions: const [],
              child: Padding(
                  padding: EdgeInsets.all(12.0.h), child: const DrawerWidget()),
            )),
        body: loginNotifier.loggedIn == false
            ? const nonUser()
            : const Center(
                child: Text(
                  "Applications",
                ),
              ),
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
