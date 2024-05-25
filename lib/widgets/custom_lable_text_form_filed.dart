import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safe_steer/constants/colors.dart';
import 'package:safe_steer/widgets/custom_form_text_filed.dart';

class CustomLableTextFormFiled extends StatelessWidget {
  const CustomLableTextFormFiled(
      {super.key,
      this.validator,
      this.hintText,
      this.labelText,
      this.onChanged,
      this.controller,
      this.initialValue,
      required this.value,
      this.suffixIcon,
        this.obscureText=false,
      });
  final String? Function(String?)? validator;
  final String? hintText;
  final String? labelText;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final String? initialValue;
  final TextInputType value;
  final Widget? suffixIcon;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Text(
              labelText!,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: MyWhite,
              ),
            ),
          ),
          TextFormField(
            textAlign: TextAlign.start,
           // autofocus: true,
            cursorColor: MyBlueGradiant6,
            keyboardType: value,
            initialValue: initialValue,
            validator: validator,
            onChanged: onChanged,
            obscureText: obscureText,
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              filled: true,
              fillColor: MyWhite1,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MYBlueGradiant3, width: 2.0),
                borderRadius: BorderRadius.all(
                  Radius.circular(20.w),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyWhite, width: 1.0),
                borderRadius: BorderRadius.all(
                  Radius.circular(20.w),
                ),
              ),
              hintText: hintText,
            ),
          ),
        ],
      ),
    );
  }
}
