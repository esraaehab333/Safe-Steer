import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safe_steer/constants/colors.dart';
import 'package:safe_steer/widgets/custom_app_bar.dart';
import 'package:safe_steer/widgets/custom_battary_box.dart';
import 'package:safe_steer/widgets/custom_health_box.dart';
import 'package:safe_steer/widgets/custom_heart_rate_box.dart';
import 'package:safe_steer/widgets/custom_speed_box.dart';
import 'package:safe_steer/widgets/custom_status_box.dart';
import 'package:safe_steer/widgets/my_elevated_button.dart';
import '../widgets/dialog_item_add_car.dart';

class MonitorScreen extends StatefulWidget {
  const MonitorScreen({
    super.key,
    required this.idcar,
    required this.namecar,
    required this.statusText,
    required this.healthText,
    required this.heartbeat,
    required this.speedValue,
    required this.battaryvalue,
    this.speedLimit,
    required this.keyId,
  });

  final String namecar;
  final String idcar;
  final String statusText;
  final String healthText;
  final String heartbeat;
  final String speedValue;
  final String battaryvalue;
  final String? speedLimit;
  final String keyId;
  @override
  State<MonitorScreen> createState() => _MonitorScreenState();
}

class _MonitorScreenState extends State<MonitorScreen> {
  var key = GlobalKey<FormState>();
  late DatabaseReference _databaseReference;

  @override
  void initState() {
    super.initState();
    _databaseReference =
        FirebaseDatabase.instance.ref().child('Cars/${widget.keyId}');
  }

  static bool isdeleted = false;
  @override
  void dispose() {
    if (isdeleted == true) {
      FirebaseDatabase.instance.ref('Cars/${widget.keyId}').remove();
    }
    isdeleted = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    late String carName;
    late String carId;
    late String speedlimit;
    return StreamBuilder(
      stream: _databaseReference.onValue,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
          return const CircularProgressIndicator();
        }

        var data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
        carId = data["Id"];
        carName = data["Name"];
        speedlimit = data["SpeedLimit"];
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            backgroundColor: Colors.black,
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [MyBlack, MyBlueGradiant1, MyBlack],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  CustomAppBar(
                    arrowbackOnpressed: () {
                      Navigator.pop(context);
                    },
                    settingsOnpressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          backgroundColor: Colors.transparent,
                          child: Container(
                            height: 340,
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(25),
                              ),
                              gradient: LinearGradient(
                                colors: [MyBlueGradiant6, MyGradiantBlue],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Form(
                                key: key,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    DialogItem(
                                      carLabel: 'Car Name',
                                      hintText: 'enter car name',
                                      initialValue: data["Name"],
                                      focuseColor: MyBlueText,
                                      enableColor: MYBlueGradiant3,
                                      validator: (p0) {
                                        if (p0 == null || p0.isEmpty) {
                                          return 'please enter car name';
                                        }
                                      },
                                      onChanged: (p0) {
                                        carName = p0;
                                      },
                                      value: TextInputType.text,
                                    ),
                                    DialogItem(
                                      carLabel: 'Car ID',
                                      hintText: 'enter car id',
                                      initialValue: data["Id"],
                                      focuseColor: MyBlueText,
                                      enableColor: MYBlueGradiant3,
                                      validator: (p0) {
                                        if (p0 == null || p0.isEmpty) {
                                          return 'please enter car id';
                                        }
                                      },
                                      onChanged: (p0) {
                                        carId = p0;
                                      },
                                      value: TextInputType.number,
                                    ),
                                    DialogItem(
                                      carLabel: 'Speed Limit',
                                      hintText: 'enter car speed limit',
                                      initialValue: data["SpeedLimit"],
                                      focuseColor: MyBlueText,
                                      enableColor: MYBlueGradiant3,
                                      validator: (p0) {
                                        if (p0 == null || p0.isEmpty) {
                                          return 'please enter speed limit';
                                        }
                                      },
                                      onChanged: (p0) {
                                        speedlimit = p0;
                                      },
                                      value: TextInputType.number,
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: MyElevatedButton(
                                            onPressed: () {
                                              isdeleted = true;
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pop(context);
                                              // Close the dialog
                                              Navigator.pop(context);
                                            },
                                            height: 30,
                                            width: 180,
                                            gradient: LinearGradient(
                                                colors: [MyRed, MyRed]),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Text(
                                              "delete the car",
                                              style: GoogleFonts.cairo(
                                                  fontSize: 13.sp,
                                                  color: MyWhite,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            MyElevatedButton(
                                              onPressed: () async {
                                                if (key.currentState!
                                                    .validate()) {
                                                  DatabaseReference ref =
                                                      FirebaseDatabase.instance.ref(
                                                          "Cars/${widget.keyId}");
                                                  await ref.update({
                                                    "Name": carName,
                                                    "Id": carId,
                                                    "SpeedLimit": speedlimit,
                                                  });
                                                  Navigator.of(context,
                                                          rootNavigator: true)
                                                      .pop(
                                                          context); // Close the dialog
                                                }
                                              },
                                              height: 30,
                                              width: 80,
                                              gradient: LinearGradient(
                                                  colors: [
                                                    MyBlueGradiant5,
                                                    MyBlueGradiant5
                                                  ],
                                                  end: Alignment.bottomCenter,
                                                  begin: Alignment.topCenter),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: Text(
                                                "save",
                                                style: GoogleFonts.cairo(
                                                    fontSize: 13.sp,
                                                    color: MyWhite,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            MyElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context,
                                                        rootNavigator: true)
                                                    .pop(
                                                        context); // Close the dialog
                                              },
                                              height: 30,
                                              width: 80,
                                              gradient: LinearGradient(
                                                  colors: [
                                                    MyBlueGradiant6,
                                                    MyBlueGradiant6
                                                  ],
                                                  end: Alignment.bottomCenter,
                                                  begin: Alignment.topCenter),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: Text(
                                                "cancel",
                                                style: GoogleFonts.cairo(
                                                    fontSize: 13.sp,
                                                    color: MyWhite,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Text(
                    "Your car",
                    style: GoogleFonts.genos(
                      fontSize: 26.sp,
                      color: MyWhite,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    data["Name"],
                    style: GoogleFonts.genos(
                      fontSize: 34.sp,
                      color: MyWhite,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      "assets/images/car.png",
                      height: MediaQuery.of(context).size.height * .2,
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                    ),
                  ),
                  Text(
                    "ID: ${data["Id"]}",
                    style: GoogleFonts.cairo(
                      fontSize: 18.sp,
                      color: MyWhite,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.005,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            CustomBatteryBox(
                              battery: data["Battery"]!,
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.0177,
                            ),
                            CustomStatusBox(statustext: data["Status"]),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.0177,
                            ),
                            CustomHealthBox(healthtext: data["Health"]),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            CustomSpeedBox(speedvalue: data["Speed"]),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.0177,
                            ),
                            CustomHeartRateBox(heartbeats: data["Heartbeat"]),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
