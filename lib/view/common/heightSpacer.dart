import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class heightSpacer extends StatelessWidget {
  const heightSpacer({super.key, required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.h,
    );
  }
}
