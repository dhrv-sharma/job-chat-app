import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobchat/constants/app_constants.dart';
import 'package:jobchat/controllers/exports.dart';
import 'package:jobchat/controllers/login_provider.dart';
import 'package:jobchat/controllers/profile_provider.dart';
import 'package:jobchat/view/common/customappBar.dart';
import 'package:jobchat/view/common/custome_outline_btn.dart';
import 'package:jobchat/view/drawer/drawer_widget.dart';
import 'package:jobchat/view/screen/guest/non_user.dart';
import 'package:provider/provider.dart';

class profilePage extends StatefulWidget {
  const profilePage({super.key});

  @override
  State<profilePage> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  @override
  Widget build(BuildContext context) {
    var loginNotifier = Provider.of<LoginNotifier>(context);
    print(loginNotifier.loggedIn);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: CustomAppbar(
            text: "Profile",
            actions: const [],
            child: Padding(
                padding: EdgeInsets.all(12.0.h), child: const DrawerWidget()),
          )),
      body: loginNotifier.loggedIn == false
          ? const nonUser()
          : Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
                child: Consumer<LoginNotifier>(
                  builder: (context, loginNotifier, child) {
                    return CustomOutlineBtn(
                        hieght: 40.h,
                        width: width,
                        onTap: () {
                          loginNotifier.logout();
                          var zoomNotifier =
                              Provider.of<ZoomNotifier>(context, listen: false);
                          zoomNotifier.currentIndex = 0;
                          var profileNotifier = Provider.of<ProfileNotifier>(
                              context,
                              listen: false);
                          profileNotifier.profileImage =
                              "https://res.cloudinary.com/dap69mong/image/upload/v1710654983/fbdrtr3b8spuotwu3r28.jpg";
                        },
                        text: "Proceed To Logout",
                        color: Color(kOrange.value));
                  },
                ),
              ),
            ),
    );
  }
}
