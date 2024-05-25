import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:safe_steer/constants/colors.dart';
import 'package:safe_steer/helper/show_snack_bar.dart';
import 'package:safe_steer/screens/sign_in_screen.dart';
import 'package:safe_steer/widgets/custom_lable_text_form_filed.dart';
import '../widgets/my_elevated_button.dart';
import '../widgets/my_text_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;
  String? email_singin;
  String? password_singin;
  String? phone_singin;
  String? username_singin;
  late DatabaseReference ref;
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
                    end: Alignment.bottomCenter),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                    "Welcome Back! You ‘ve been missed",
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w200,
                      color: MyWhite,
                    ),
                  ),
                  SizedBox(height: 14.h),
                  CustomLableTextFormFiled(
                    labelText: 'Username',
                    hintText: 'enter your username',
                    onChanged: (data) => {
                      username_singin = data,
                      //_username = data,
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter username";
                      }
                      return null;
                    },
                    value: TextInputType.name,
                  ),
                  CustomLableTextFormFiled(
                    labelText: "Email",
                    hintText: 'enter your email',
                    onChanged: (data) => {
                      email_singin = data,
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter email";
                      }
                      return null;
                    },
                    value: TextInputType.emailAddress,
                  ),
                  CustomLableTextFormFiled(
                    value: TextInputType.visiblePassword,
                    obscureText: showpassword,
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return"Please enter password";
                      }
                      return null;
                    },
                    onChanged: (data) {
                      password_singin = data;
                    },
                    labelText: "Password",
                    hintText: "enter your password",
                  ),
                  CustomLableTextFormFiled(
                    labelText: 'Phone',
                    hintText: 'enter your phone number',
                    onChanged: (data) => {
                      phone_singin = data,
                      //_phone = data,
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter phone number";
                      }
                      return null;
                    },
                    value: TextInputType.phone,
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: MyElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          isLoading = true;
                          setState(() {});
                          try {
                            UserCredential user = await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: email_singin!,
                                    password: password_singin!);
                            String Id = FirebaseAuth.instance.currentUser!.uid;
                            print("ID:$Id");
                            ref = FirebaseDatabase.instance.ref("Users/$Id");
                            showSnackBar(
                                context, "Signing Up Successfully !!!");
                            Map<String, dynamic> users = {};
                            ref.set({
                              "username": username_singin,
                              "phone": phone_singin,
                              "imageUrl": "assets/images/profile.png",
                            });
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          } on FirebaseException catch (e) {
                            if (e.code == "weak-password") {
                              showSnackBar(context,
                                  "Password should be at least 6 characters");
                            } else if (e.code == "invalid-email") {
                              showSnackBar(context,
                                  "The email address is badly formatted.");
                            } else if (e.code == "email-already-in-use") {
                              showSnackBar(context, "email already in use");
                            } else if (e.code == 'network-request-failed') {
                              showSnackBar(context, 'No internet connection');
                            } else {
                              print(e);
                              showSnackBar(
                                  context, "An undefined Error happened.");
                            }
                            showSnackBar(context, e.code);
                          } catch (e) {
                            showSnackBar(context, "error");
                          }
                          isLoading = false;
                          setState(() {});
                        } else {}
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
                        "Sign Up",
                        style: GoogleFonts.georama(
                          color: MyWhite,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
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
                              // LoginScreen(),
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
