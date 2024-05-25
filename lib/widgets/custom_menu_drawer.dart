import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safe_steer/constants/colors.dart';
import 'package:safe_steer/helper/log_out_user.dart';
import 'package:safe_steer/screens/profile_screen.dart';
import 'package:safe_steer/widgets/custom_list_tile.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 230,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [MyColorMenuGradiant1, MyBlueGradiant1],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: MyMenuColor,
              ),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.menu_outlined,
                          size: 25,
                          color: MyWhite,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Menu",
                          style: GoogleFonts.inter(
                            color: MyWhite,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            CustomListTile(
              iconData: Icons.person_2_outlined,
              text: 'Your Profile',
              onTap: () async {
                /*final auth = FirebaseAuth.instance;
                final user = auth.currentUser;
                String userId = user!.uid;
                final String email = user.email.toString();
                final ref = FirebaseDatabase.instance.ref();
                final snapshot = await ref.child('Users/$userId').get();
                Map<dynamic, dynamic> data = snapshot.value as Map;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(
                      email: email,
                      id: userId,
                      phone: data["phone"],
                      username: data["username"],
                    ),
                  ),
                );*/
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(),
                  ),
                );
              },
            ),
            Divider(
              color: MyBlueGradiant1,
            ),
            CustomListTile(
              iconData: Icons.info_outline,
              text: 'About Us',
              onTap: () {

              },
            ),
            Divider(
              color: MyBlueGradiant1,
            ),
            CustomListTile(
              iconData: Icons.logout_rounded,
              text: 'Log Out',
              onTap: ()  {
                Navigator.of(context).pop();
               showDialog(context: context, builder: (context) =>  Dialog(
                 child: Container(
                   decoration: BoxDecoration(
                     color: MyWhite1,
                     borderRadius: BorderRadius.circular(15),
                   ),
                   child: Padding(
                     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                     child: Container(
                       height: 120,
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
                               "Log Out !!",
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
                             "Do you want to Log out ?",
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
                                   Navigator.pop(context);
                                   await logOut(context);
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
                                   Navigator.of(context , rootNavigator: true).pop(context);
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
               ),);
                //await logOut(context);
              },
            ),
          ],
        ),
      ),
    );
  } //
}
