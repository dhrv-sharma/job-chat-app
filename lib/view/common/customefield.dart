import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:jobchat/constants/app_constants.dart';
import 'package:jobchat/view/common/appstyle.dart';
import 'package:jobchat/view/common/widthspacer.dart';

class CustomField extends StatefulWidget {
  const CustomField({super.key, this.onTap, required this.controller});

  final void Function()? onTap;
  final TextEditingController controller;

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  // controller provide text from the user
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50,
      decoration:
          BoxDecoration(color: Color(kLightGrey.value).withOpacity(0.3)),
      padding: EdgeInsets.only(bottom: 5.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const widthSpacer(size: 8),
              GestureDetector(
                onTap: () {
                  // get back to the page stack
                  Get.back();
                },
                child: Icon(
                  Ionicons.chevron_back_circle,
                  size: 32.h,
                  color: Color(kOrange.value),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 22.h),
                width: width *
                    0.7, // to provide text field  we have to provide width as we are in row
                child: TextFormField(
                  keyboardType: TextInputType
                      .text, //  the keyboardType property of the TextFormField widget is used to specify the type of keyboard that should be displayed when the user interacts with the text input field. The keyboardType property takes an instance of the TextInputType

                  decoration: InputDecoration(
                      hintText: "Search and a Find job",
                      hintStyle: appStyle(14,
                          Color(kDark.value).withOpacity(0.6), FontWeight.w500),
                      errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide:
                              BorderSide(color: Colors.red, width: 0.5)),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 0)),
                      focusedErrorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 0.5,
                          )),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(
                              color: Color(kDarkGrey.value), width: 0.5)),
                      enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.zero,
                          borderSide: BorderSide(
                              color: Colors.transparent, width: 0.5)),
                      border: InputBorder.none),
                  controller: widget.controller,
                  cursorHeight: 25,
                  style: appStyle(14, Color(kDark.value), FontWeight.w500),
                ),
              ),
            ],
          ),
          GestureDetector(
            // whenever user clicks on search button it calls set state function
            onTap: widget.onTap,
            child: Icon(
              Ionicons.search_circle_outline,
              size: 35.h,
              color: Color(kOrange.value),
            ),
          ),
          const widthSpacer(size: 5),
        ],
      ),
    );
  }
}
