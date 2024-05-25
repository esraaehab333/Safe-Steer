
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safe_steer/constants/colors.dart';
import 'package:safe_steer/widgets/custom_container.dart';

import '../helper/notification_services.dart';

class CustomStatusBox extends StatefulWidget {
  const CustomStatusBox({
    super.key, required this.statustext,
  });
  final statustext;

  @override
  State<CustomStatusBox> createState() => _CustomStatusBoxState();
}

class _CustomStatusBoxState extends State<CustomStatusBox> {
  bool _showDialog = false;
  @override
  Widget build(BuildContext context) {
    if (widget.statustext =="Not Hold" && !_showDialog) {
      /*FirebaseMessaging.instance.getInitialMessage().then((message) =>
      message!.messageId!.isNotEmpty
          ? print('we can now navigate to specific screen')
          : print('there is no new notification so default screen will be shown when application start from terminated state'));*/
      //NotificationService().showNotification(body: "Please, hold the steering wheel.",title:"Steering wheel is loose !!",id: 4 );
      // Show the dialog only if the battery percentage is 20% and the dialog is not already shown
      _showDialog = true; // Update the state to prevent showing the dialog multiple times
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        showDialog(
            context: context,
            builder: (_) =>  Dialog(
              child: Container(
                decoration: BoxDecoration(
                  color: MyWhite,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    SizedBox(
                      height: 150,
                      width: 220,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 35,
                          ),
                          Text(
                            "Steering wheel is loose !!",
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: steerAlert,),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Please, hold the steering wheel.",
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color:MyBlack,),
                          ),
                          const SizedBox(height: 10,),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context , rootNavigator: true).pop(context);// Close the dialog
                              },
                              child: Text(
                                "ok",
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: MyBlueGradiant5,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: -62,
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: MyWhite,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: Image.asset(
                            "assets/icons/steer.png",
                            height: 60,
                            width: 60,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
        );
      });
    }
    return CustomContainer(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height * 0.121,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Status",
              style: GoogleFonts.genos(
                color: MyWhite1,
                fontSize: 17.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.statustext,
                  style: GoogleFonts.genos(
                      fontSize: 18,
                      color: (widget.statustext == "Hold") ? MyGray2 : MyRed,
                      fontWeight: FontWeight.w600),
                ),
                Image.asset(
                  (widget.statustext=="Hold")?"assets/icons/hold.png":"assets/icons/nothold.png",
                  height: 40,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
