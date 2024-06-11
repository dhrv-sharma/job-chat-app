import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:jobchat/constants/app_constants.dart';
import 'package:jobchat/view/common/appstyle.dart';

class addSkill extends StatelessWidget {
  const addSkill({super.key, required this.skill, required this.onTap});

  // controller
  final TextEditingController skill;

  // function
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(2.w),
        height: 54.w,
        child: skillField(
          controller: skill,
          hintText: "Add A New Skill",
          onTap: onTap,
        ));
  }
}

class skillField extends StatelessWidget {
  skillField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.onTap});

  TextEditingController controller;
  String hintText;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: appStyle(
                14, Color(kDark.value).withOpacity(0.6), FontWeight.w500),
            suffixIcon: GestureDetector(
              onTap: onTap,
              child: Icon(
                Entypo.upload_to_cloud,
                size: 30,
                color: Color(kBlueColor.value),
              ),
            ),

            // when user interacts this border activates
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(color: Colors.blue, width: 1.5)),

            // ideal condition
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(color: Colors.black, width: 1))));
  }
}
