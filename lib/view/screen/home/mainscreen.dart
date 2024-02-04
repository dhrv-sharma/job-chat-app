import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:jobchat/constants/app_constants.dart';
import 'package:jobchat/controllers/exports.dart';
import 'package:jobchat/view/screen/bookmark/bookmark.dart';
import 'package:jobchat/view/screen/chat/chatpage.dart';
import 'package:jobchat/view/screen/devicemgmt/devicemgmt.dart';
import 'package:jobchat/view/drawer/drawerScreen.dart';
import 'package:jobchat/view/screen/profile/profile.dart';
import 'package:jobchat/view/screen/home/homepage.dart';
import 'package:provider/provider.dart';

class mainScreen extends StatefulWidget {
  const mainScreen({super.key});

  @override
  State<mainScreen> createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ZoomNotifier>(builder: (context, zoomNotifier, child) {
      return ZoomDrawer(
        menuScreen: drawerScreen(
            // set the index at provider
            // index setter is a function which set the current index value of provider
            //  this is passed to drawer page and then to each drawer item and on tap of item it changes the value
            //  indes is return by ZoomDrawer
            indexSetter: (index) {
          zoomNotifier.currentIndex = index;
        }),
        mainScreen: currentScreen(), // main widget switch statement
        borderRadius: 30, // border radius
        showShadow: true, // shadow
        angle: 0.0,
        slideWidth: 250, // sets the navigation area occupancy
        menuBackgroundColor: Color(kLightBlue.value), // background colour
      );
    });
  }

  Widget currentScreen() {
    // accessing the provider content of controller Zoom Notifer
    // initial current index value is zero hence home page will be open
    var zoomNotifier = Provider.of<ZoomNotifier>(context);
    switch (zoomNotifier.currentIndex) {
      case 0:
        return const homePage();
      case 1:
        return const chatPage();
      case 2:
        return const bookaMark();
      case 3:
        return const deviceMgmt();
      case 4:
        return const profilePage();

      default:
        return const homePage();
    }
  }
}
