import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:jobchat/constants/app_constants.dart';
import 'package:jobchat/controllers/exports.dart';
import 'package:jobchat/controllers/login_provider.dart';
import 'package:jobchat/controllers/profile_provider.dart';
import 'package:jobchat/models/auth/profile_model.dart';
import 'package:jobchat/view/common/NoSearchResult.dart';
import 'package:jobchat/view/common/appstyle.dart';
import 'package:jobchat/view/common/buildStyleContainer.dart';
import 'package:jobchat/view/common/customappBar.dart';
import 'package:jobchat/view/common/custome_outline_btn.dart';
import 'package:jobchat/view/common/heightSpacer.dart';
import 'package:jobchat/view/common/pageloader.dart';
import 'package:jobchat/view/common/resuabletext.dart';
import 'package:jobchat/view/common/widthspacer.dart';
import 'package:jobchat/view/drawer/drawer_widget.dart';
import 'package:jobchat/view/screen/guest/non_user.dart';
import 'package:provider/provider.dart';

class profilePage extends StatefulWidget {
  const profilePage({super.key});

  @override
  State<profilePage> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  late Future<ProfileRes?> myProfile;
  @override
  Widget build(BuildContext context) {
    var loginNotifier = Provider.of<LoginNotifier>(
      context,
    );
    var profileNotifier = Provider.of<ProfileNotifier>(
      context,
    );
    if (loginNotifier.loggedIn) {
      // get our data
      print("getting profile Data");
      profileNotifier.profileSet();
      myProfile = profileNotifier.getProfile;
    }
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.h),
            child: CustomAppbar(
              text: loginNotifier.loggedIn
                  ? userNameConst.toUpperCase()
                  : "Profile",
              actions: const [],
              child: Padding(
                  padding: EdgeInsets.all(12.0.h), child: const DrawerWidget()),
            )),
        body: loginNotifier.loggedIn == false
            ? const nonUser()
            : FutureBuilder(
                future: myProfile,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const PageLoader();
                  } else if (snapshot.hasError) {
                    return const NoSearchResults(
                        message: "Something Went Wrong");
                  } else {
                    var prof = snapshot.data;
                    return buildStyleContainer(
                        context,
                        ListView(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 5.w, right: 5.w),
                              width: width,
                              height: hieght * 0.1,
                              decoration: BoxDecoration(
                                  color: Color(kGreen.value),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12.2))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      circularAvtr(
                                          image: prof!.profile,
                                          width: 60,
                                          height: 60),
                                      const widthSpacer(size: 10),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          reusableText(
                                              text: prof.username,
                                              style: appStyle(
                                                  14,
                                                  Colors.black.withOpacity(0.8),
                                                  FontWeight.w600)),
                                          reusableText(
                                              text: prof.email,
                                              style: appStyle(
                                                  14,
                                                  Colors.black.withOpacity(0.8),
                                                  FontWeight.w400))
                                        ],
                                      ),
                                      const widthSpacer(size: 25),
                                      GestureDetector(
                                        onTap: () {},
                                        child: const Icon(Feather.edit),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const heightSpacer(size: 20),
                            Column(
                              children: [
                                !prof.isAgent
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          reusableText(
                                              text: 'Agent Section',
                                              style: appStyle(
                                                  14,
                                                  Color(kDark.value),
                                                  FontWeight.w600)),
                                          const heightSpacer(size: 20),
                                          CustomOutlineBtn(
                                              hieght: 40.h,
                                              width: width,
                                              onTap: () {},
                                              text: "Want To Hire ",
                                              color: Color(kOrange.value)),
                                          const heightSpacer(size: 10),
                                          CustomOutlineBtn(
                                              hieght: 40.h,
                                              width: width,
                                              onTap: () {},
                                              text: "Update Inforamation ",
                                              color: Color(kOrange.value))
                                        ],
                                      )
                                    : CustomOutlineBtn(
                                        hieght: 40.h,
                                        width: width,
                                        onTap: () {},
                                        text: "Apply To Become An Agent",
                                        color: Color(kOrange.value)),
                              ],
                            ),
                            const heightSpacer(size: 20),
                            CustomOutlineBtn(
                                hieght: 40.h,
                                width: width,
                                onTap: () {
                                  loginNotifier.logout();
                                  var zoomNotifier = Provider.of<ZoomNotifier>(
                                      context,
                                      listen: false);
                                  zoomNotifier.currentIndex = 0;
                                  var profileNotifier =
                                      Provider.of<ProfileNotifier>(context,
                                          listen: false);
                                  profileNotifier.profileImage =
                                      "https://res.cloudinary.com/dap69mong/image/upload/v1710654983/fbdrtr3b8spuotwu3r28.jpg";
                                },
                                text: "Proceed To Logout",
                                color: Color(kOrange.value))
                          ],
                        ));
                  }
                }));
  }
}

// circular avatar widget
class circularAvtr extends StatelessWidget {
  const circularAvtr(
      {super.key,
      required this.image,
      required this.width,
      required this.height});
  final String image;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(99.w)),
      child: CachedNetworkImage(
        imageUrl: image,
        width: width,
        height: height,
        fit: BoxFit.cover,
        placeholder: (context, url) {
          // when loading this pat of the code runs hence this widget will goin gto run
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        },
      ),
    );
  }
}

// resume

// Center(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
//                 child: Consumer<LoginNotifier>(
//                   builder: (context, loginNotifier, child) {
//                     return CustomOutlineBtn(
//                         hieght: 40.h,
//                         width: width,
//                         onTap: () {
//                           loginNotifier.logout();
//                           var zoomNotifier =
//                               Provider.of<ZoomNotifier>(context, listen: false);
//                           zoomNotifier.currentIndex = 0;
//                           var profileNotifier = Provider.of<ProfileNotifier>(
//                               context,
//                               listen: false);
//                           profileNotifier.profileImage =
//                               "https://res.cloudinary.com/dap69mong/image/upload/v1710654983/fbdrtr3b8spuotwu3r28.jpg";
//                         },
//                         text: "Proceed To Logout",
//                         color: Color(kOrange.value));
//                   },
//                 ),
//               ),
//             ),
