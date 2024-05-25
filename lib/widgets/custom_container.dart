
import 'package:flutter/material.dart';
import 'package:safe_steer/constants/colors.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key , required this.height , required this.width , required this.child});
  final double height;
  final double width;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: ShapeDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [MyBlack,MyBlueGradiant4,MyBlueGradiant1],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        shadows: [
          BoxShadow(
            color: MyBlack,
            blurRadius: 4,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child:child ,
    );
  }
}