
import 'package:flutter/material.dart';
import 'package:safe_steer/constants/colors.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text , style: TextStyle(color: MyWhite),),
      backgroundColor: MyBlueGradiant1,
      behavior: SnackBarBehavior.floating,
    ),
  );
}