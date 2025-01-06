import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';
import '../screens/sign_in_screen.dart';
import 'my_text_button.dart';

class HaveAccount extends StatelessWidget {
  const HaveAccount({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "have an account? ",
          style: GoogleFonts.georama(
            fontSize: 16,
            color: MyWhite,
            fontWeight: FontWeight.w100,
          ),
        ),
        MyTextButton(
          borderRadius: BorderRadius.zero,
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
            );
          },
          child: Text(
            "Log in",
            style: GoogleFonts.georama(
              fontSize: 16,
              color: MyBlueText,
              fontWeight: FontWeight.w100,
            ),
          ),
        ),
      ],
    );
  }
}
