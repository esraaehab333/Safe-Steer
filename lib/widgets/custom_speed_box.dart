
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safe_steer/constants/colors.dart';
import 'package:safe_steer/helper/speedo_meter.dart';
import 'package:safe_steer/widgets/custom_container.dart';
import '../helper/notification_services.dart';

class CustomSpeedBox extends StatefulWidget {
  const CustomSpeedBox({
    super.key, required this.speedvalue,required this.speedlimit
  });
  final  speedvalue ;
  final speedlimit;
  @override
  State<CustomSpeedBox> createState() => _CustomSpeedBoxState();
}

class _CustomSpeedBoxState extends State<CustomSpeedBox> {
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  bool _showDialog = false;
  @override
  Widget build(BuildContext context) {
    if (int.parse(widget.speedvalue) >= int.parse(widget.speedlimit) && !_showDialog) {
     // NotificationService().showNotification(body: "Please, slow down  because you are nervous.",title:"High Speed !!" ,id:3);
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
                            "High Speed !!",
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: speedAlert,),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Please, slow down  because you are nervous.",
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
                            "assets/icons/speed.png",
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
      height: MediaQuery.of(context).size.height * 0.19,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Speed",
            style: GoogleFonts.genos(
              color: MyWhite1,
              fontSize: 17.sp,
              fontWeight: FontWeight.w800,),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              height: 100,
              width: 100,
              child: SpeedMeter(speed: widget.speedvalue,),
            ),
          ),
        ],
      ),
    );
  }
}