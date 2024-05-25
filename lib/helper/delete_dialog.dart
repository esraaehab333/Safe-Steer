import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safe_steer/constants/colors.dart';
import 'package:safe_steer/screens/profile_screen.dart';
import 'package:safe_steer/screens/welcome_screen.dart';

class DeleteAlert extends StatelessWidget {
  const DeleteAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: MyWhite1,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SizedBox(
            height: 150,
            width: 220,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: Text(
                    "Delete Account !!",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: MyRed,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  maxLines: 2,
                  "Do you want to delete the account?",
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: MyBlack,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () async {
                        final auth = FirebaseAuth.instance;
                        final userId = auth.currentUser!.uid;
                        DatabaseReference ref = FirebaseDatabase.instance.ref("Users/$userId");
                        ref.remove().then((_) {
                          print("Data deleted successfully");
                        }).catchError((error) {
                          print("Failed to delete data: $error");
                        });
                        FirebaseAuth.instance.currentUser?.delete();
                        //await FirebaseAuth.instance.signOut();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const WelcomeScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "yes",
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: MyRed,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 35,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(),));
                      },
                      child: Text(
                        "no",
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: MyBlack,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
