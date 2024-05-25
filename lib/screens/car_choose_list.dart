// ignore_for_file: prefer_const_constructors, non_constant_identifier_names
import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:safe_steer/constants/colors.dart';
import 'package:safe_steer/screens/create_new_car.dart';
import 'package:safe_steer/widgets/custom_car_card.dart';
import 'package:safe_steer/widgets/custom_menu_drawer.dart';
import 'package:firebase_database/firebase_database.dart';

import '../helper/notification_services.dart';
List<dynamic> ids = [];
class CarChooseList extends StatefulWidget {
  const CarChooseList({super.key});
  @override
  State<CarChooseList> createState() => _CarChooseListState();
}

class _CarChooseListState extends State<CarChooseList> {

  final databaseRef = FirebaseDatabase.instance.ref('Cars');
  late StreamSubscription<DatabaseEvent> _dataSubscription;
  List<String> childrenIds = [];
  final ScrollController controller = ScrollController();
  late DatabaseReference ref;
  Query dbref = FirebaseDatabase.instance.ref().child("Cars");

  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    super.initState();
    getConnectivity();
    _listenForDataChanges();
  }

  @override
  void dispose() {
    subscription.cancel();
    _dataSubscription.cancel();
    super.dispose();
  }

  void _listenForDataChanges() {
    _dataSubscription = databaseRef.onValue.listen((event) {
      final dataSnapshot = event.snapshot;
      final data = event.snapshot.value as Map;
      childrenIds = dataSnapshot.children.map((child) => child.key!).toList();
      for(int i=0;i<childrenIds.length;i++)
      {

        final carData = data[childrenIds[i]];
        final carName = carData["Name"];
        final speed = int.parse(carData["Speed"]);
        final speedLimit = int.parse(carData["SpeedLimit"]);
        final status = carData["Status"];
        final health = carData["Health"];
        final heartbeat = int.parse(carData["Heartbeat"]);

        if(speed >= speedLimit)
        {
          NotificationService().showNotification(body: "Speed is high !!", title:carName, id: generateUniqueNotificationId(i, "Speed"),);
        }
        if(status == "Not Hold")
        {
          NotificationService().showNotification(body: "Please, hold the steering wheel.",title:carName,  id: generateUniqueNotificationId(i, "Status"),);
        }
        if(health =="Drunk" )
        {
          NotificationService().showNotification(body: "Please, don’t drive as you are drunk.",title:carName,  id: generateUniqueNotificationId(i, "Health"),);
        }
        if(heartbeat >=190 )
        {
          NotificationService().showNotification(body: "Please, Be calm and breathe.",title:carName, id: generateUniqueNotificationId(i, "Heartbeat"),);
        }
        // Update your UI with the new data
        setState(() {
          // Update your state variables
        });
      }
    });
  }

  int generateUniqueNotificationId(int carIndex, String type) {
    return carIndex * 10 + type.hashCode;
  }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
            (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() => isAlertSet = true);
          }
        },
      );
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: MYBlueGradiant3,
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back,
          color: MyBlack,
        ),
        backgroundColor: MyBlack,
      ),
      endDrawer: MainDrawer(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [MyBlack, MyBlueGradiant1, MyBlack],
              begin: Alignment.center,
              end: Alignment.bottomLeft),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: Text(
                            "choose",
                            style: GoogleFonts.genos(
                              color: MyWhite,
                              fontSize: 40,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 2,
                          child: Text(
                            "a car",
                            style: GoogleFonts.genos(
                              color: MyWhite,
                              fontSize: 30,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () async {
                         Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateNewCar(controller :controller),
                          ),
                        );
                       // NotificationService().showNotification(title: "ll",id:1,body:"k",payload: "ll");
                      },
                      child: Container(
                        decoration: ShapeDecoration(
                          color: MyWhite1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          shadows: [
                            BoxShadow(
                              color: MyBlack,
                              blurRadius: 2,
                              offset: Offset(0, 1),
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Row(
                            children: [
                              Icon(Icons.add_rounded),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Add Car",
                                style: GoogleFonts.cairo(
                                    fontSize: 14,
                                    color: MyBlack,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: FirebaseAnimatedList(
                  query: dbref,
                  controller: controller,
                  itemBuilder: (context, snapshot, animation, index) {
                    Map car = snapshot.value as Map;
                    car['Key'] = snapshot.key;
                    ids.add(snapshot.key);
                    return CustomCarCard(
                      keyId : snapshot.key!,
                      carId: car['Id'],
                      carName: car['Name'],
                      healthText: car['Health'],
                      batteryValue: car['Battery'],
                      heartbeat: car['Heartbeat'],
                      speedValue: car['Speed'],
                      statusText: car['Status'],
                      speedLimit: car['SpeedLimit'],
                    );

                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showDialogBox() => showCupertinoDialog<String>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Text('No Connection'),
      content: const Text('Please check your internet connectivity'),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            Navigator.pop(context, 'Cancel');
            setState(() => isAlertSet = false);
            isDeviceConnected =
            await InternetConnectionChecker().hasConnection;
            if (!isDeviceConnected && isAlertSet == false) {
              showDialogBox();
              setState(() => isAlertSet = true);
            }
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
