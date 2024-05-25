import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safe_steer/constants/colors.dart';

class DialogItem extends StatelessWidget {
  const DialogItem({
    super.key,
    required this.carLabel,
    required this.hintText,
    required this.focuseColor,
    required this.enableColor, this.onChanged, required this.value, this.validator,
    this.initialValue
  });
  final String carLabel;
  final String hintText;
  final Color focuseColor;
  final Color enableColor;
  final void Function(String)? onChanged;
  final TextInputType value;
  final String? Function(String?)? validator;
  final String? initialValue;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            carLabel,
            style: GoogleFonts.cairo(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: MyWhite,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: TextFormField(
              validator: validator,
              onChanged:onChanged,
              keyboardType: value,
              initialValue: initialValue,
              style: GoogleFonts.cairo(color: MyWhite),
              clipBehavior: Clip.none,
              cursorColor: MYBlueGradiant3,
              decoration: InputDecoration(
                isDense: true,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: focuseColor),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: enableColor),
                ),
                hintText: hintText,
                hintStyle: GoogleFonts.cairo(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: MyHintColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
