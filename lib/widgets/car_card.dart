/*
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safe_steer/constants/colors.dart';
import 'package:safe_steer/screens/monitor_screen.dart';

class CarCard extends StatelessWidget {
  const CarCard({
    super.key,
    required this.car,
  });

  final Map car;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: MyCard),
        width: 260,
        child: Column(

          children: [
            const SizedBox(height: 20,),
            Image.asset("assets/images/car.png",
            height: 135,),
            Text(
              car['Name'],
              style: GoogleFonts.genos(
                  fontSize: 40.sp,
                  color: MyWhite3,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              car['Id'],
              style: GoogleFonts.cairo(
                  fontSize: 16.sp,
                  color: MyWhite3,
                  fontWeight: FontWeight.w200),
            ),
            const SizedBox(
              height: 70,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MonitorScreen(
                      id_car: car["Id"],
                      name_car: car["Name"], statusText: '',
                    ),
                  ),
                );
              },
              child: Container(
                height: 42,
                width: 173,
                decoration: BoxDecoration(
                  color: MyWhite3,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    "GET IN",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/