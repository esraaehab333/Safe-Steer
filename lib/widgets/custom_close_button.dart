import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safe_steer/constants/colors.dart';

class CustomCloseButton extends StatelessWidget {
  const CustomCloseButton({super.key, required this.lable, this.onTap, required this.height , required this.width});
  final String lable;
  final VoidCallback? onTap;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: MyWhite),
          borderRadius: BorderRadius.circular(25),
        ),
        height: height,
        width: width,
        child: Center(
          child: Text(
            lable,
            style: GoogleFonts.georama(
              color: MyWhite,
              fontSize: 16,
              fontWeight: FontWeight.w200,
            ),
          ),
        ),
      ),
    );
  }
}
