import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safe_steer/constants/colors.dart';
import 'package:safe_steer/screens/car_choose_list.dart';
import 'package:safe_steer/screens/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    Timer(
      const Duration(seconds: 3),
      () {
        if (user != null) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (BuildContext context) => const CarChooseList()),
          );
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (BuildContext context) => const WelcomeScreen()),
          );
        }
      },
    );
  }

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
        child: Center(
          child: Image.asset('assets/images/car.png'),
        ),
      ),
    );
  }
}
