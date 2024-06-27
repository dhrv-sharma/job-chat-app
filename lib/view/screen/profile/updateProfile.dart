// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jobchat/constants/app_constants.dart';
import 'package:jobchat/controllers/profile_provider.dart';
import 'package:jobchat/models/auth/profile_model.dart';
import 'package:jobchat/services/authHelper.dart';
import 'package:jobchat/view/common/appstyle.dart';
import 'package:jobchat/view/common/buildStyleContainer.dart';
import 'package:jobchat/view/common/custom_outline_btn.dart';
import 'package:jobchat/view/common/customappBar.dart';
import 'package:jobchat/view/common/heightSpacer.dart';
import 'package:jobchat/view/common/resuabletext.dart';
import 'package:jobchat/view/screen/profile/profile.dart';
import 'package:provider/provider.dart';

class updateProfile extends StatefulWidget {
  updateProfile({super.key, required this.profile});

  ProfileRes profile;

  @override
  State<updateProfile> createState() => _updateProfileState();
}

class _updateProfileState extends State<updateProfile> {
  TextEditingController userName = TextEditingController();

  TextEditingController Email = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    userName.dispose();
    Email.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Email.text = widget.profile.email;
    userName.text = widget.profile.username;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(kLightBlue.value),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.w),
          child: CustomAppbar(
              color: Color(kLightBlue.value),
              textColor: Colors.white,
              text: "Update Profile",
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: circularAvtr(
                      image: widget.profile.profile, width: 40, height: 40),
                ),
              ],
              child: Padding(
                padding: EdgeInsets.all(12.0.h),
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    AntDesign.leftcircleo,
                    color: Colors.white,
                  ),
                ),
              ))),
      body:
          Consumer<ProfileNotifier>(builder: (context, profileNotifier, child) {
        return Stack(
          children: [
            Positioned(
                child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  color: Colors.white),
              child: buildStyleContainer(
                  context,
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8, bottom: 0, right: 8),
                    child: Stack(
                      children: [
                        Form(
                          key: _formKey,
                          child: ListView(
                            children: [
                              const heightSpacer(size: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  reusableText(
                                      text: "Profile Picture",
                                      style: appStyle(15, Color(kOrange.value),
                                          FontWeight.w500)),
                                  GestureDetector(
                                      onTap: () {},
                                      child: const Icon(Entypo.upload_to_cloud,
                                          size: 32, color: Colors.blue))
                                ],
                              ),
                              const heightSpacer(size: 5),
                              profileNotifier.editProfile
                                  ? Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          profileNotifier.selectPicture();
                                        },
                                        child: Container(
                                          width: 150,
                                          height: 150,
                                          decoration: BoxDecoration(
                                            color: Colors
                                                .white, // Background color
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color:
                                                  Colors.white, // Border color
                                              width: 4, // Border width
                                            ),
                                          ),
                                          child: ClipOval(
                                            child: Image.file(
                                              profileNotifier
                                                  .editProfilePicture!,
                                              width: 150,
                                              height: 150,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          profileNotifier.selectPicture();
                                        },
                                        child: Container(
                                          width: 150,
                                          height: 150,
                                          decoration: BoxDecoration(
                                            color: Colors
                                                .white, // Background color
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color:
                                                  Colors.white, // Border color
                                              width: 4, // Border width
                                            ),
                                          ),
                                          child: ClipOval(
                                            child: Image.network(
                                              widget.profile.profile,
                                              width: 150,
                                              height: 150,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                              const heightSpacer(size: 5),
                              buildtextField(
                                hintText: "User Name*",
                                controller: userName,
                                label: "User Name",
                              ),
                              buildtextField(
                                hintText: "Email*",
                                controller: Email,
                                label: "Email",
                              ),
                              const heightSpacer(size: 15),
                            ],
                          ),
                        ),
                        Positioned(
                            left: 0,
                            right: 0,
                            bottom: 10,
                            child: GestureDetector(
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  ProfileRes res;

                                  if (profileNotifier.editProfilePicture !=
                                      null) {
                                    await profileNotifier
                                        .uploadProfile(userName.text);
                                    res = ProfileRes(
                                        id: widget.profile.id,
                                        username: userName.text,
                                        email: Email.text,
                                        isAgent: widget.profile.isAgent,
                                        skills: skills,
                                        profile:
                                            profileNotifier.uploadedProfile!);
                                    var model = createprofileRequestToJson(res);

                                    profileNotifier.updateProfile(
                                        model, context, res);
                                  } else {
                                    await profileNotifier
                                        .uploadProfile(userName.text);
                                    res = ProfileRes(
                                        id: widget.profile.id,
                                        username: userName.text,
                                        email: Email.text,
                                        isAgent: widget.profile.isAgent,
                                        skills: skills,
                                        profile: widget.profile.profile);
                                    var model = createprofileRequestToJson(res);

                                    profileNotifier.updateProfile(
                                        model, context, res);
                                  }
                                } else {
                                  Get.snackbar("Invalid fields",
                                      "Please fill out every fields",
                                      colorText: Color(kLight.value),
                                      backgroundColor: Color(kOrange.value),
                                      icon: const Icon(
                                        Icons.add_alert,
                                        color: Colors.white,
                                      ),
                                      borderRadius: 5);
                                }
                              },
                              child: customOutlineButton(
                                text: "Update My Profile",
                                height: hieght * 0.06,
                                color1: Color(kLight.value),
                                color2: Color(kOrange.value),
                              ),
                            ))
                      ],
                    ),
                  )),
            ))
          ],
        );
      }),
    );
  }
}

class buildtextField extends StatelessWidget {
  buildtextField(
      {super.key,
      required this.hintText,
      required this.controller,
      this.label = "",
      this.maxLines = 1});

  String hintText;
  TextEditingController controller;
  String label;
  int maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label != "" ? const heightSpacer(size: 20) : Container(),
        label != ""
            ? reusableText(
                text: label,
                style: appStyle(15, Color(kOrange.value), FontWeight.w500))
            : Container(),
        const heightSpacer(size: 10),
        TextFormField(
          maxLines: maxLines,
          decoration: InputDecoration(
              hintText: hintText,
              hintStyle: appStyle(
                  14, Color(kDark.value).withOpacity(0.6), FontWeight.w500),
              focusedErrorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                  borderSide: BorderSide(
                    color: Colors.red,
                    width: 0.5,
                  )),
              errorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                  borderSide: BorderSide(color: Colors.red, width: 0.5)),
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide(color: Colors.blue, width: 1.5)),

              // ideal condition
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide(color: Colors.black, width: 1))),
          controller: controller,
          onFieldSubmitted: (value) {},
          validator: (value) {
            if (value!.isEmpty) {
              return "Please Fill the Field";
            } else {
              return null;
            }
          },
        ),
      ],
    );
  }
}
