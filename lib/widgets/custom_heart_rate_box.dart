import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safe_steer/constants/colors.dart';
import 'package:safe_steer/widgets/custom_container.dart';

import '../helper/notification_services.dart';

class CustomHeartRateBox extends StatefulWidget {
  const CustomHeartRateBox({
    super.key,
    required this.heartbeats,
  });
  final heartbeats;

  @override
  State<CustomHeartRateBox> createState() => _CustomHeartRateBoxState();
}

class _CustomHeartRateBoxState extends State<CustomHeartRateBox> {
  bool _showDialog = false;
  @override
  Widget build(BuildContext context) {

    if (int.parse(widget.heartbeats) >=190  && !_showDialog) {
      //NotificationService().showNotification(body: "Please, Be calm and breathe.",title:"High heart rate !!" ,id: 2);
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
                      width: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 35,
                          ),
                          Text(
                            "High heart rate !!",
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: heartAlert,),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Please, Be calm and breathe.",
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
                            "assets/icons/heart.png",
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
      height: MediaQuery.of(context).size.height * 0.2596,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Heart beat",
            style: GoogleFonts.genos(
              color: MyWhite1,
              fontSize: 17.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            widget.heartbeats,
            style: GoogleFonts.genos(
              color: MyBlueGradiant5,
              fontSize: 35.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            "beats per minute",
            style: GoogleFonts.iceland(
              color: MyGray,
              fontSize: 12.sp,
            ),
          ),
          Image.asset(
            "assets/images/heartbeats.gif",
            //height: MediaQuery.of(context).size.height * 0.1271,
            width: MediaQuery.of(context).size.width * 0.35,
          ),
        ],
      ),
    );
  }
}
