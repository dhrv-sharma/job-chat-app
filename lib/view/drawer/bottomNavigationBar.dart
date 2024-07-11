import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jobchat/constants/app_constants.dart';
import 'package:jobchat/controllers/zoom_provider.dart';
import 'package:jobchat/view/screen/home/mainscreen.dart';
import 'package:provider/provider.dart';

class bottomNavigationBar extends StatefulWidget {
  const bottomNavigationBar({super.key});

  @override
  State<bottomNavigationBar> createState() => _bottomNavigationBarState();
}

class _bottomNavigationBarState extends State<bottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    var zoomNotifier = Provider.of<ZoomNotifier>(context, listen: false);

    return Theme(
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
            currentIndex: zoomNotifier.currentIndex,
            elevation: 0,
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                  label: "Home",
                  icon: Icon(
                    Icons.home,
                    size: 25,
                  )),
              BottomNavigationBarItem(
                  label: "Chats",
                  icon: Icon(
                    Icons.chat_outlined,
                    size: 25,
                  )),
              BottomNavigationBarItem(
                  label: "BookMark",
                  icon: Icon(
                    Icons.bookmark_border_outlined,
                    size: 25,
                  )),
              BottomNavigationBarItem(
                label: "Application",
                icon: Icon(Icons.description_outlined),
              ),
              BottomNavigationBarItem(
                  label: "Profile",
                  icon: Icon(
                    Icons.person,
                    size: 25,
                  )),
            ]));
  }
}
