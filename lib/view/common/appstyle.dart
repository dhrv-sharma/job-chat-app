import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

// function takes a size font weight and color and return Textstyle as well
TextStyle appStyle(double size, Color color, FontWeight fw) {
  return GoogleFonts.poppins(fontSize: size.sp, color: color, fontWeight: fw);
}
