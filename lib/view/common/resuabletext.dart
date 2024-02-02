import 'package:flutter/material.dart';

class reusableText extends StatelessWidget {
  const reusableText({super.key, required this.text, required this.style});

  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      softWrap: false,
      textAlign: TextAlign.left,
      overflow: TextOverflow.fade,
      style: style,
    );
  }
}
