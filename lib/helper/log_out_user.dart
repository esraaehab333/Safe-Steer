
  import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safe_steer/helper/log_in_user.dart';

import 'package:safe_steer/screens/welcome_screen.dart';


Future<void> logOut(BuildContext context) async {
    FirebaseAuth.instance.signOut();
    if (!context.mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const WelcomeScreen(),
      ),
    );
  }