import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:jobchat/constants/app_constants.dart';
import 'package:jobchat/controllers/zoom_provider.dart';
import 'package:jobchat/view/drawer/drawerItem.dart';
import 'package:provider/provider.dart';

class drawerScreen extends StatefulWidget {
  const drawerScreen({super.key, required this.indexSetter});
  final ValueSetter indexSetter;

  @override
  State<drawerScreen> createState() => _drawerScreenState();
}

class _drawerScreenState extends State<drawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ZoomNotifier>(builder: (context, zoomNotifier, child) {
      return GestureDetector(
        onTap: () {
          // when we double tap on the empty area the drawer should be closed
          ZoomDrawer.of(context)!.toggle();
        },
        child: Scaffold(
          backgroundColor: Color(kLightBlue.value),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // drawer items
              //  ant desigon icons are from the flutter vector package
              // all these icons from the vector file import only
              drawerItem(
                  indexSetter: widget.indexSetter,
                  icon: AntDesign.home,
                  text: "Home",
                  index: 0,
                  color: zoomNotifier.currentIndex == 0
                      ? Color(kLight.value)
                      : Color(kLightGrey.value)),

              drawerItem(
                  indexSetter: widget.indexSetter,
                  icon: Ionicons.chatbubble_outline,
                  text: "Chat",
                  index: 1,
                  color: zoomNotifier.currentIndex == 1
                      ? Color(kLight.value)
                      : Color(kLightGrey.value)),

              drawerItem(
                  indexSetter: widget.indexSetter,
                  icon: Fontisto.bookmark,
                  text: "Bookmark",
                  index: 2,
                  color: zoomNotifier.currentIndex == 2
                      ? Color(kLight.value)
                      : Color(kLightGrey.value)),
              drawerItem(
                  indexSetter: widget.indexSetter,
                  icon: MaterialCommunityIcons.devices,
                  text: "Device Mgmt",
                  index: 3,
                  color: zoomNotifier.currentIndex == 3
                      ? Color(kLight.value)
                      : Color(kLightGrey.value)),
              drawerItem(
                  indexSetter: widget.indexSetter,
                  icon: FontAwesome.user_circle,
                  text: "Profile",
                  index: 4,
                  color: zoomNotifier.currentIndex == 4
                      ? Color(kLight.value)
                      : Color(kLightGrey.value)),
            ],
          ),
        ),
      );
    });
  }
}
