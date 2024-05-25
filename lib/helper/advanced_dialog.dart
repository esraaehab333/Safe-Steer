import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safe_steer/constants/colors.dart';
class AdvancedDialog extends StatelessWidget {
  const AdvancedDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: MyWhite1,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 150,
              width: 220,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    "f",
                    style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: MyWhite),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "dd",
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: MyWhite),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        "ok",
                        style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: MyWhite),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: -62,
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: MyWhite,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: Image.asset(
                    "assets/icons/Frame 2.png",
                    height: 70,
                    width: 70,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
