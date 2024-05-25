// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safe_steer/constants/colors.dart';

class CustomButton extends StatelessWidget {
  CustomButton({super.key, required this.lable, this.onTap, required this.height , required this.width});
  final String lable;
  VoidCallback? onTap;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.h),
        height: height,
        width: width,
        decoration: ShapeDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [MyBlueGradiant1, MYBlueGradiant3],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.w),
          ),
          shadows: [
            BoxShadow(
              color: MyBlack,
              blurRadius: 4,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Center(
          child: Text(
            lable,
            style: GoogleFonts.georama(
              color: MyWhite,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
