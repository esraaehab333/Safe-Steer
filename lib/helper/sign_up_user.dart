// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';

Future<void> SignUpUser(String email, String password) async {
  UserCredential user = await FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: email, password: password);
  String Id = FirebaseAuth.instance.currentUser!.uid;
}
