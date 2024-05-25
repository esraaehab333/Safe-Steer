import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safe_steer/constants/colors.dart';
import 'package:safe_steer/screens/sign_in_screen.dart';
import 'package:safe_steer/screens/sign_up_screen.dart';
import '../widgets/my_elevated_button.dart';
import '../widgets/my_text_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [MyBlack, MyBlueGradiant1, MyBlack],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.120,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Safe Steer",
                        style: GoogleFonts.genos(
                          fontSize: 48.sp,
                          color: MyWhite,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        "every thing you want to make ",
                        style: GoogleFonts.genos(
                          color: MyWhite,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                      Text(
                        "your drive safely",
                        style: GoogleFonts.genos(
                          color: MyWhite,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w100,
                        ),
                      )
                    ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Image.asset(
                "assets/images/car_welcome_screen.png",
                height: MediaQuery.of(context).size.height * .4,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.topRight,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: MyElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(25.w),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [MyBlueGradiant1, MYBlueGradiant3],
                ),
                height: 50.w,
                width: 300.w,
                child: Text(
                  "LOG IN",
                  style: GoogleFonts.georama(
                    color: MyWhite,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don’t have an account? ",
                  style: GoogleFonts.georama(
                    fontSize: 16.sp,
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
                        builder: (context) => const SignUpScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Sign Up",
                    style: GoogleFonts.georama(
                      fontSize: 16.sp,
                      color: MyBlueText,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
