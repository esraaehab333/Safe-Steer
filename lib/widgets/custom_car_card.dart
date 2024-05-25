import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safe_steer/constants/colors.dart';
import 'package:safe_steer/screens/monitor_screen.dart';

class CustomCarCard extends StatelessWidget {
  const CustomCarCard({
    super.key,
    required this.carId,
    required this.carName,
    required this.healthText,
    required this.heartbeat,
    required this.speedValue,
    required this.statusText,
    required this.batteryValue,
    this.speedLimit,
    required this.keyId
  });
  final String carName;
  final String carId;
  final String healthText;
  final String heartbeat;
  final String speedValue;
  final String statusText;
  final String batteryValue;
  final String? speedLimit;
  final String keyId;
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(10),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: ShapeDecoration(
              color: MyBlueGradiant1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              shadows: [
                BoxShadow(
                  color: MyBlack,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    carName,
                    style: GoogleFonts.genos(
                        color: MyWhite,
                        fontSize: 36,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "ID : $carId",
                    style: GoogleFonts.cairo(
                        color: MyWhite,
                        fontSize: 12,
                        fontWeight: FontWeight.w200),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 60, left: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MonitorScreen(
                            idcar: carId,
                            namecar: carName,
                            statusText: statusText,
                            healthText: healthText,
                            heartbeat: heartbeat,
                            speedValue: speedValue,
                            battaryvalue: batteryValue,
                            speedLimit : speedLimit,
                            keyId: keyId,
                          ),
                        ));
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: ShapeDecoration(
                      color: MyWhite1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      shadows: [
                        BoxShadow(
                          color: MyBlack,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: const Icon(Icons.arrow_back),
                  ),
                ),
                const SizedBox(),
                Image.asset(
                  "assets/images/car_card2.png",
                  height: 160,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
