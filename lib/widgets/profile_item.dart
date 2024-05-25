import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem(
      {super.key,
        required this.initialValue,
        required this.label,
        required this.initialColor,
        required this.enable,
        required this.hinttext,
        this.onchange});
  final String label;
  final String initialValue;
  final Color initialColor;
  final bool enable;
  final String hinttext;
  final void Function(String)? onchange;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.cairo(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: MyWhite1,
            ),
          ),
          TextFormField(
            onChanged: onchange,
            enabled: enable,
            initialValue: initialValue,
            style: GoogleFonts.cairo(color: initialColor),
            clipBehavior: Clip.none,
            cursorColor: MYBlueGradiant3,
            decoration: InputDecoration(
              hintText: hinttext,
              isDense: true,
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: MYBlueGradiant3),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: MYBlueGradiant3),
              ),
              hintStyle: GoogleFonts.cairo(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: MyHintColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}