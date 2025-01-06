// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:safe_steer/constants/colors.dart';
import 'package:safe_steer/screens/car_choose_list.dart';
import 'package:safe_steer/screens/sign_up_screen.dart';
import 'package:safe_steer/widgets/my_text_button.dart';

import '../helper/log_in_user.dart';
import '../helper/show_snack_bar.dart';
import '../widgets/custom_lable_text_form_filed.dart';
import '../widgets/my_elevated_button.dart';

bool showpassword = true;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email;

  String? password;

  bool isLoading = false;

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: MyBlack,
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [MyBlack, MyBlueGradiant1, MyBlack],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /* SizedBox(
                    height: 120.h,
                  ),*/
                  Text(
                    "Safe Steer",
                    style: GoogleFonts.genos(
                      fontSize: 48.sp,
                      color: MyWhite,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    "Welcome Back! You ‘ve been missed",
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w200,
                      color: MyWhite,
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  CustomLableTextFormFiled(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter email";
                      }
                      return null;
                    },
                    labelText: "Email",
                    hintText: 'enter your email',
                    onChanged: (data) {
                      email = data;
                    },
                    value: TextInputType.emailAddress,
                  ),
                  CustomLableTextFormFiled(
                    obscureText: showpassword,
                    value: TextInputType.visiblePassword,
                    hintText: "enter your password",
                    labelText: "Password",
                    onChanged: (data) {
                      password = data;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter password";
                      }
                      return null;
                    },
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          showpassword = !showpassword;
                        });
                      },
                      icon: Icon(
                        showpassword ? Icons.visibility_off : Icons.visibility,
                        color: MyGray2,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 40.h),
                    child: MyElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          isLoading = true;
                          setState(() {});
                          try {
                            await LoginUser(email!, password!);
                            showSnackBar(
                                context, "Signing Up Successfully !!!");
                            /*Navigator.pushAndRemoveUntil<dynamic>(
                              context,
                              MaterialPageRoute<dynamic>(
                                builder: (BuildContext context) =>
                                    CarChooseList(),
                              ),
                              (route) =>
                                  false, //if you want to disable back feature set to false
                            );*/
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CarChooseList(),
                              ),
                            );
                            // Your login code here
                          } catch (ex) {
                            if (ex is FirebaseAuthException) {
                              if (ex.code == 'invalid-login-credentials') {
                                showSnackBar(context, 'User not found');
                              } else if (ex.code == 'invalid-email') {
                                showSnackBar(context, 'Invalid email');
                              } else if (ex.code == 'wrong-password') {
                                showSnackBar(context, 'Wrong password');
                              } else if (ex.code == 'network-request-failed') {
                                showSnackBar(context, 'No internet connection');
                              } else if (ex.code == "invalid-credential") {
                                showSnackBar(
                                    context, "Invalid email or pssword");
                              } else {
                                showSnackBar(context, 'Something went wrong!');
                              }
                            } else {
                              showSnackBar(context, 'Something went wrong!');
                            }
                          }
                          isLoading = false;
                          setState(() {});
                        }
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
                        "Log in",
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
          ),
        ),
      ),
    );
  }
}
