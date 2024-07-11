import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jobchat/constants/app_constants.dart';
import 'package:jobchat/controllers/agent_provider.dart';
import 'package:jobchat/models/auth/profile_model.dart';
import 'package:jobchat/models/createAgent.dart';
import 'package:jobchat/view/common/appstyle.dart';
import 'package:jobchat/view/common/buildStyleContainer.dart';
import 'package:jobchat/view/common/custom_outline_btn.dart';
import 'package:jobchat/view/common/customappBar.dart';
import 'package:jobchat/view/common/heightSpacer.dart';
import 'package:jobchat/view/common/pageloader.dart';
import 'package:jobchat/view/common/resuabletext.dart';
import 'package:jobchat/view/screen/profile/profile.dart';
import 'package:provider/provider.dart';

class addAgent extends StatefulWidget {
  addAgent({super.key, required this.profile});

  ProfileRes profile;

  @override
  State<addAgent> createState() => _addAgentState();
}

class _addAgentState extends State<addAgent> {
  TextEditingController company = TextEditingController();

  TextEditingController hqAddress = TextEditingController();
  TextEditingController workingTime = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    company.dispose();
    hqAddress.dispose();
    workingTime.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
              text: "Apply for Agent",
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
      body: Consumer<agentProvider>(builder: (context, agentNotifier, child) {
        return agentNotifier.applying
            ? const PageLoader()
            : Stack(
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
                          padding: const EdgeInsets.only(
                              left: 8, bottom: 0, right: 8),
                          child: Stack(
                            children: [
                              Form(
                                key: _formKey,
                                child: ListView(
                                  children: [
                                    const heightSpacer(size: 5),
                                    buildtextField(
                                      hintText: "Company*",
                                      controller: company,
                                      label: "Company",
                                    ),
                                    buildtextField(
                                      hintText: "Address",
                                      controller: hqAddress,
                                      label: "Head Quarter Address",
                                    ),
                                    buildtextField(
                                      hintText: "Timings",
                                      controller: workingTime,
                                      label: "Working hours",
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
                                        createAgent res;
                                        res = createAgent(
                                            uid: widget.profile.uid,
                                            working_hrs: workingTime.text,
                                            hq_address: hqAddress.text,
                                            company: company.text);
                                        var model = createAgentToJson(res);
                                        agentNotifier.applyAgent(
                                            model, context);
                                      } else {
                                        Get.snackbar("Invalid fields",
                                            "Please fill out every fields",
                                            colorText: Color(kLight.value),
                                            backgroundColor:
                                                Color(kOrange.value),
                                            icon: const Icon(
                                              Icons.add_alert,
                                              color: Colors.white,
                                            ),
                                            borderRadius: 5);
                                      }
                                    },
                                    child: customOutlineButton(
                                      text: "Apply For Agent",
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
