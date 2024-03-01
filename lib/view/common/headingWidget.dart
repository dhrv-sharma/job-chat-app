import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'package:jobchat/constants/app_constants.dart';
import 'package:jobchat/view/common/appstyle.dart';
import 'package:jobchat/view/common/resuabletext.dart';

class headingWidget extends StatelessWidget {
  const headingWidget({super.key, required this.text, required this.onTap});

  final String text;

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        reusableText(
            text: text,
            style: appStyle(18, Color(kDark.value), FontWeight.w600)),
        GestureDetector(
            onTap: onTap,
            child: Icon(
              AntDesign.appstore_o,
              color: Colors.grey.shade800,
            ))
      ],
    );
  }
}
