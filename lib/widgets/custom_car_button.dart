
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class CarButton extends StatelessWidget {
  const CarButton(
      {super.key,
      required this.text,
      required this.color1,
      required this.color2,
      required this.colortext,
      required this.ontap,});
  final String text;
  final Color color1;
  final Color color2;
  final Color colortext;
  final void Function()? ontap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        focusColor: Colors.orange,
        onTap:ontap,
        child: Container(
          height: 45,
          width: 220,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(23),
            gradient: LinearGradient(
              colors: [color1, color2],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              text,
              style: GoogleFonts.cairo(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: colortext,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

