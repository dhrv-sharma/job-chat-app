import 'package:flutter/material.dart';
import 'package:jobchat/constants/app_constants.dart';
import 'package:jobchat/view/common/appstyle.dart';
import 'package:jobchat/view/common/heightSpacer.dart';
import 'package:jobchat/view/common/resuabletext.dart';

class buildtextField extends StatelessWidget {
  buildtextField(
      {super.key,
      required this.hintText,
      required this.controller,
      this.label = "",
      this.maxLines = 1,
      required this.suffixIcon,
      required this.obsecureText,
      required this.validator,
      required this.type});

  String hintText;
  TextEditingController controller;
  String label;
  int maxLines;
  Widget suffixIcon;
  bool obsecureText;
  TextInputType type;

  final String? Function(String?)? validator;

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
          keyboardType: type,
          decoration: InputDecoration(
              suffixIcon: suffixIcon,
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
          obscureText: obsecureText,
          validator: validator,
        ),
      ],
    );
  }
}
