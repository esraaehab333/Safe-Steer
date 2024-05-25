
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safe_steer/constants/colors.dart';
import 'package:safe_steer/helper/notification_services.dart';
import 'package:safe_steer/widgets/custom_container.dart';
bool g = true;
class CustomHealthBox extends StatefulWidget {
  const CustomHealthBox({
    Key? key,
    required this.healthtext,
  }) : super(key: key);

  final String healthtext;

  @override
  State<CustomHealthBox> createState() => _CustomHealthBoxState();
}

class _CustomHealthBoxState extends State<CustomHealthBox> {

  bool _showDialog = false;
  @override
  Widget build(BuildContext context) {

    if (widget.healthtext == "Drunk" && !_showDialog) {
    //  NotificationService().showNotification(body: "Please, don’t drive as you are drunk.",title:"You Are Drunk !!",id: 1);
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
                            "You Are Drunk !!",
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: drunkAlert,),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Please, don’t drive as you are drunk.",
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
                            "assets/icons/Frame 2.png",
                            height: 70,
                            width: 70,
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
              "Health",
              style: GoogleFonts.genos(
                color: MyWhite1,
                fontSize: 17,
                fontWeight: FontWeight.w800,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.healthtext,
                  style: GoogleFonts.genos(
                      fontSize: 18,
                      color: (widget.healthtext == "Sober") ? MyGray2 : MyRed,
                      fontWeight: FontWeight.w600),
                ),
                Image.asset(
                  (widget.healthtext=="Sober")?"assets/icons/no-alcohol.png":"assets/icons/alcohol.png",
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
