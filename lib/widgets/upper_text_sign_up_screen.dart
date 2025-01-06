import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safe_steer/constants/colors.dart';

class UpperTextSignUpScreen extends StatelessWidget {
  const UpperTextSignUpScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Safe Steer",
          style: GoogleFonts.genos(
            fontSize: 48.sp,
            color: MyWhite,
            fontWeight: FontWeight.w900,
          ),
        ),
        Text(
          "Welcome Back! You’ve been missed",
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w200,
            color: MyWhite,
          ),
        ),
      ],
    );
  }
}
