import 'package:flutter/material.dart';

class reusableText extends StatelessWidget {
  reusableText(
      {super.key, required this.text, required this.style, this.overflow});

  final String text;
  final TextStyle style;
  bool? overflow = false;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      softWrap: false,
      textAlign: TextAlign.left,
      overflow: overflow ?? false ? TextOverflow.visible : TextOverflow.fade,
      style: style,
    );
  }
}
