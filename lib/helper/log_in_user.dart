// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';

Future<void> LoginUser(String email, String password) async {
  UserCredential user = await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: email, password: password);
}

class Keys {
  static String isLogined = 'isLogined';
}
