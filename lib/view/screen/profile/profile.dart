import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
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
import 'package:jobchat/view/screen/home/mainscreen.dart';
import 'package:jobchat/view/screen/job/addJobs.dart';
import 'package:jobchat/view/screen/profile/addAgent.dart';
import 'package:jobchat/view/screen/profile/skills.dart';
import 'package:jobchat/view/screen/profile/updateProfile.dart';
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
    var zoomNotifier = Provider.of<ZoomNotifier>(context, listen: false);
    if (loginNotifier.loggedIn) {
      // get our data

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
                  return const NoSearchResults(message: "Something Went Wrong");
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
                            child: Stack(
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
                                  ],
                                ),
                                Positioned(
                                    right: 0..w,
                                    top: 0.w,
                                    bottom: 0.w,
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(updateProfile(profile: prof));
                                      },
                                      child: const Icon(Feather.edit),
                                    ))
                              ],
                            ),
                          ),
                          const heightSpacer(size: 10),
                          const skillWidget(),
                          const heightSpacer(size: 15),
                          Column(
                            children: [
                              prof.isAgent
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        resume(),
                                        const heightSpacer(size: 20),
                                        reusableText(
                                            text: 'Agent Information',
                                            style: appStyle(
                                                14,
                                                Color(kDark.value),
                                                FontWeight.w600)),
                                        const heightSpacer(size: 20),
                                        CustomOutlineBtn(
                                            hieght: 40.h,
                                            width: width,
                                            onTap: () {
                                              profileNotifier.companyLogo =
                                                  false;
                                              profileNotifier.newJobImg = null;
                                              profileNotifier.uploadedImage =
                                                  "";
                                              Get.to(() => addJobPage(
                                                    imageUrl: prof.profile,
                                                  ));
                                            },
                                            text: "Add Job",
                                            color: Color(kOrange.value)),
                                        const heightSpacer(size: 10),
                                        CustomOutlineBtn(
                                            hieght: 40.h,
                                            width: width,
                                            onTap: () {},
                                            text: "Update Agent Inforamation ",
                                            color: Color(kOrange.value))
                                      ],
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        reusableText(
                                            text: 'Profile',
                                            style: appStyle(
                                                14,
                                                Color(kDark.value),
                                                FontWeight.w600)),
                                        const heightSpacer(size: 20),
                                        resume(),
                                        const heightSpacer(size: 20),
                                        CustomOutlineBtn(
                                            hieght: 40.h,
                                            width: width,
                                            onTap: () {
                                              // warning to change function

                                              Get.to(() =>
                                                  addAgent(profile: prof));
                                            },
                                            text: "Apply To Become An Agent",
                                            color: Color(kOrange.value)),
                                      ],
                                    ),
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
              }),
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
      ),
    );
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

class resume extends StatelessWidget {
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: width,
          height: hieght * 0.12,
          decoration: BoxDecoration(
              color: Color(kGreen.value),
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 12.w),
                width: 60.w,
                height: 70.h,
                decoration: BoxDecoration(
                  color: Color(kLight.value),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: const Icon(
                  FontAwesome.file_pdf_o,
                  color: Colors.red,
                  size: 40,
                ),
              ),
              const widthSpacer(
                size: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  reusableText(
                      text: "Upload Your Resume",
                      style: appStyle(16, Color(kDark.value), FontWeight.w500)),
                  FittedBox(
                    child: Text(
                      "Please make your to upload your resume in PDF Format",
                      style:
                          appStyle(8, Color(kDarkGrey.value), FontWeight.w500),
                    ),
                  )
                ],
              ),
              const widthSpacer(size: 1)
            ],
          ),
        ),
        Positioned(right: 0.w, child: const editButton())
      ],
    );
  }
}

class editButton extends StatelessWidget {
  const editButton({super.key, this.onTap});

  final void Function()? onTap;

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
            color: Color(kOrange.value),
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(9), bottomLeft: Radius.circular(9))),
        child: reusableText(
            text: " Edit ",
            style: appStyle(12, Color(kLight.value), FontWeight.w500)),
      ),
    );
  }
}
