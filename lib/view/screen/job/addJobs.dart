import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:jobchat/constants/app_constants.dart';
import 'package:jobchat/controllers/profile_provider.dart';
import 'package:jobchat/models/create_job.dart';
import 'package:jobchat/services/pickPicture.dart';
import 'package:jobchat/view/common/appstyle.dart';
import 'package:jobchat/view/common/buildStyleContainer.dart';
import 'package:jobchat/view/common/custom_outline_btn.dart';
import 'package:jobchat/view/common/customappBar.dart';
import 'package:jobchat/view/common/heightSpacer.dart';
import 'package:jobchat/view/common/pageloader.dart';
import 'package:jobchat/view/common/resuabletext.dart';
import 'package:jobchat/view/screen/profile/profile.dart';
import 'package:provider/provider.dart';

class addJobPage extends StatefulWidget {
  addJobPage({super.key, this.imageUrl, this.name});

  String? imageUrl;
  String? name;

  @override
  State<addJobPage> createState() => _addJobPageState();
}

class _addJobPageState extends State<addJobPage> {
  TextEditingController title = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController agentName = TextEditingController();
  TextEditingController salary = TextEditingController();
  TextEditingController contract = TextEditingController();
  TextEditingController company = TextEditingController();
  TextEditingController period = TextEditingController();

  TextEditingController rq1 = TextEditingController();
  TextEditingController rq2 = TextEditingController();
  TextEditingController rq3 = TextEditingController();
  TextEditingController rq4 = TextEditingController();

  TextEditingController rq5 = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    title.dispose();
    location.dispose();
    description.dispose();
    agentName.dispose();
    salary.dispose();
    contract.dispose();
    company.dispose();
    rq1.dispose();
    rq2.dispose();
    rq3.dispose();
    rq4.dispose();
    rq5.dispose();
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
              text: "Add A Job",
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: circularAvtr(
                      image: widget.imageUrl!, width: 40, height: 40),
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
                                      text: "Company Logo",
                                      style: appStyle(15, Color(kOrange.value),
                                          FontWeight.w500)),
                                  GestureDetector(
                                      onTap: () {},
                                      child: const Icon(Entypo.upload_to_cloud,
                                          size: 32, color: Colors.blue))
                                ],
                              ),
                              const heightSpacer(size: 5),
                              profileNotifier.companyLogo
                                  ? Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          profileNotifier.newJobImage();
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
                                              profileNotifier.newJobImg!,
                                              width: 150,
                                              height: 150,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () async {
                                        profileNotifier.newJobImage();
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: const Icon(
                                          Icons.folder_open,
                                          size: 60,
                                        ),
                                      ),
                                    ),
                              const heightSpacer(size: 5),
                              buildtextField(
                                hintText: "Job Title*",
                                controller: title,
                                label: "Title",
                              ),
                              buildtextField(
                                hintText: "Location*",
                                controller: location,
                                label: "Location",
                              ),
                              buildtextField(
                                hintText: "Description*",
                                controller: description,
                                label: "Description",
                                maxLines: 6,
                              ),
                              buildtextField(
                                hintText: "Agent Name*",
                                controller: agentName,
                                label: "Agent Name",
                              ),
                              buildtextField(
                                hintText: "Salary*",
                                controller: salary,
                                label: "Salary",
                              ),
                              buildtextField(
                                hintText: "weekly | Monthly | Annually *",
                                controller: period,
                                label: "Salary Period",
                                maxLines: 1,
                              ),
                              buildtextField(
                                hintText: "Contract*",
                                controller: contract,
                                label: "Contract",
                              ),
                              buildtextField(
                                hintText: "Company*",
                                controller: company,
                                label: "Company",
                              ),
                              const heightSpacer(size: 20),
                              reusableText(
                                  text: "Requirements",
                                  style: appStyle(15, Color(kOrange.value),
                                      FontWeight.w500)),
                              buildtextField(
                                hintText: "Requirement*",
                                controller: rq1,
                                maxLines: 2,
                              ),
                              buildtextField(
                                hintText: "Requirement*",
                                controller: rq2,
                                maxLines: 2,
                              ),
                              buildtextField(
                                hintText: "Requirement*",
                                controller: rq3,
                                maxLines: 2,
                              ),
                              buildtextField(
                                hintText: "Requirement*",
                                controller: rq4,
                                maxLines: 2,
                              ),
                              buildtextField(
                                hintText: "Requirement*",
                                controller: rq5,
                                maxLines: 2,
                              ),
                              const heightSpacer(size: 70)
                            ],
                          ),
                        ),
                        Positioned(
                            left: 0,
                            right: 0,
                            bottom: 10,
                            child: GestureDetector(
                              onTap: () async {
                                if (_formKey.currentState!.validate() &&
                                    profileNotifier.companyLogo) {
                                  Center(
                                    child: Container(
                                        height: 40, child: const PageLoader()),
                                  );

                                  CreateJobsRequest rawModel =
                                      CreateJobsRequest(
                                          title: title.text,
                                          location: location.text,
                                          company: company.text,
                                          hiring: true,
                                          description: description.text,
                                          salary: salary.text,
                                          period: period.text,
                                          contract: contract.text,
                                          imageUrl:
                                              profileNotifier.uploadedImage,
                                          agentId: userIdConst,
                                          agentName: agentName.text,
                                          requirements: [
                                        rq1.text,
                                        rq2.text,
                                        rq3.text,
                                        rq4.text,
                                        rq5.text,
                                      ]);

                                  var model = createJobsRequestToJson(rawModel);
                                  await profileNotifier.uploadImage(
                                      agentName.text, model, context);
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
                                text: "Post Job",
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

// profileNotifier.companyLogo
//                                   ? FutureBuilder<File?>(
//                                       future: logo,
//                                       builder: (context, snapshot) {
//                                         if (snapshot.connectionState ==
//                                             ConnectionState.waiting) {
//                                           // Display a loading indicator while waiting for the Future to complete
//                                           return Container(
//                                               child:
//                                                   CircularProgressIndicator());
//                                         } else if (snapshot.hasError) {
//                                           // Display an error message if the Future completes with an error
//                                           return Text(
//                                               'Error: ${snapshot.error}');
//                                         } else {
//                                           File data = snapshot.data!;
//                                           return data == null
//                                               ? GestureDetector(
//                                                   onTap: () async {
//                                                     profileNotifier
//                                                         .companyLogo = true;
//                                                     setState(() {});
//                                                   },
//                                                   child: ClipRRect(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             15),
//                                                     child: const Icon(
//                                                       Icons.folder_open,
//                                                       size: 60,
//                                                     ),
//                                                   ),
//                                                 )
//                                               : ClipRRect(
//                                                   borderRadius:
//                                                       BorderRadius.circular(5),
//                                                   child: Image.file(
//                                                     data,
//                                                     height: 100,
//                                                     width: 100,
//                                                     fit: BoxFit.scaleDown,
//                                                   ),
//                                                 );
//                                         }
//                                       })

// text field for the upload a job page
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
