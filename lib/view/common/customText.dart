import 'package:flutter/material.dart';
import 'package:jobchat/constants/app_constants.dart';
import 'package:jobchat/view/common/appstyle.dart';

class customTextField extends StatelessWidget {
  const customTextField(
      {super.key,
      required this.hintText,
      required this.suffixIcon,
      required this.keyBoardType,
      required this.controller,
      this.validator,
      required this.obsecureText});

  final String hintText;
  final Widget suffixIcon;
  final TextInputType keyBoardType;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool obsecureText;

/*
Enabled State:

Enabled Border (enabledBorder): This border is displayed when the TextFormField is enabled but not currently focused. It represents the default appearance of the border when the user is not interacting with the input field.
Focused State:

Focused Border (focusedBorder): This border is displayed when the TextFormField is focused, meaning the user has tapped on the input field, and it is ready to receive input. The focused border represents the appearance of the border when the input field is actively selected.
*/
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(kLightGrey.value).withOpacity(0.3),
          borderRadius: const BorderRadius.all(Radius.circular(9))),
      child: TextFormField(
        keyboardType:
            keyBoardType, //  the keyboardType property of the TextFormField widget is used to specify the type of keyboard that should be displayed when the user interacts with the text input field. The keyboardType property takes an instance of the TextInputType
        obscureText:
            obsecureText, // wheather the text should be visible or not in the field
        decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: suffixIcon,
            hintStyle: appStyle(
                14, Color(kDark.value).withOpacity(0.6), FontWeight.w500),
            errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: Colors.red, width: 0.5)),
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: Colors.transparent, width: 0)),
            focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(
                  color: Colors.red,
                  width: 0.5,
                )),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide:
                    BorderSide(color: Color(kDarkGrey.value), width: 0.5)),
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: Colors.transparent, width: 0.5)),
            border: InputBorder.none),
        controller: controller,
        cursorHeight: 25,
        style: appStyle(14, Color(kDark.value), FontWeight.w500),
        validator: validator,
      ),
    );
  }
}
