import 'package:flutter/material.dart';
import 'package:safe_steer/constants/colors.dart';

class CustomBattery extends StatelessWidget {
  const CustomBattery({super.key , required this.battery});
  final battery;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Padding(
          padding: const EdgeInsets.all(1),
          child: Container(
            height: double.parse(battery),
            width: 49,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(5),
                bottomLeft: Radius.circular(5),
              ),
              gradient: LinearGradient(
                colors: [MyBlueGradiant5, MyColorMenuGradiant2],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        Container(
            height: 102,
            width: 50,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: MyWhite1),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Image.asset("assets/images/battery.png"),
            )),
      ],
    );
  }
}
