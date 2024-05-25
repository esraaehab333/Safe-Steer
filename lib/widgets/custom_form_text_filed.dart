import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_steer/constants/colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      this.validator,
      this.hintText,
      this.labelText,
      this.onChanged,
      this.controller,
      this.initialValue,
      required this.paddingValue1,
      required this.paddingValue2,
      required this.value});
  final String? Function(String?)? validator;
  final String? hintText;
  final String? labelText;
  final String? initialValue;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final double paddingValue1;
  final double paddingValue2;
  final TextInputType value;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: MyBlueGradiant6,
      keyboardType: value,
      initialValue: initialValue,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: MyWhite1,
        contentPadding: EdgeInsets.symmetric(
            horizontal: paddingValue1, vertical: paddingValue2),
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
    );
  }
}
