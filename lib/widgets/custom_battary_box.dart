import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safe_steer/constants/colors.dart';
import 'package:safe_steer/widgets/custom_battery.dart';
import 'package:safe_steer/widgets/custom_container.dart';

class CustomBatteryBox extends StatefulWidget {
  const CustomBatteryBox({
    Key? key,
    required this.battery,
  }) : super(key: key);

  final String battery;

  @override
  _CustomBatteryBoxState createState() => _CustomBatteryBoxState();
}

class _CustomBatteryBoxState extends State<CustomBatteryBox> {
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height * 0.19,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                "Battery",
                style: GoogleFonts.genos(
                  color: MyWhite1,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "${widget.battery}%",
                style: GoogleFonts.genos(
                  color: MyWhite1,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 15,
          ),
          CustomBattery(
            battery: widget.battery,
          ),
        ],
      ),
    );
  }
}
