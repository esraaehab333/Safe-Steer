import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_steer/constants/colors.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.arrowbackOnpressed , required this.settingsOnpressed});
  final void Function()? arrowbackOnpressed;
  final void Function()? settingsOnpressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 24.h, left: 15.w, right: 15.w),
      child: Row(
        children: [
          IconButton(
            onPressed: arrowbackOnpressed,
            icon: Icon(
              Icons.arrow_back_ios,
              color: MyWhite1,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: settingsOnpressed,
            icon: Icon(
              Icons.settings,
              color: MyWhite1,
            ),
          ),
        ],
      ),
    );
  }
}
