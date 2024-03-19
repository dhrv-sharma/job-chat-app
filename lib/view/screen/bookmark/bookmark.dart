import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobchat/controllers/login_provider.dart';
import 'package:jobchat/view/common/customappBar.dart';
import 'package:jobchat/view/drawer/drawer_widget.dart';
import 'package:jobchat/view/screen/guest/non_user.dart';
import 'package:provider/provider.dart';

class bookaMark extends StatefulWidget {
  const bookaMark({super.key});

  @override
  State<bookaMark> createState() => _bookaMarkState();
}

class _bookaMarkState extends State<bookaMark> {
  @override
  Widget build(BuildContext context) {
    var loginNotifier = Provider.of<LoginNotifier>(context);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: CustomAppbar(
            text: "Bookmarks",
            actions: const [],
            child: Padding(
                padding: EdgeInsets.all(12.0.h), child: const DrawerWidget()),
          )),
      body: loginNotifier.loggedIn == false
          ? const nonUser()
          : const Center(
              child: Text(
                "Bookmark",
              ),
            ),
    );
  }
}
