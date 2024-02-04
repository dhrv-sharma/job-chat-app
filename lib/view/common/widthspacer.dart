import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class widthSpacer extends StatelessWidget {
  const widthSpacer({super.key, required this.size});
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.w,
    );
  }
}
