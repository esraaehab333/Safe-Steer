// ignore_for_file: prefer_const_constructors, non_constant_identifier_names
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safe_steer/constants/colors.dart';
import 'package:safe_steer/screens/create_new_car.dart';
import 'package:safe_steer/widgets/custom_car_card.dart';
import 'package:safe_steer/widgets/custom_menu_drawer.dart';
import 'package:firebase_database/firebase_database.dart';

class CarChooseList extends StatefulWidget {
  const CarChooseList({super.key});
  @override
  State<CarChooseList> createState() => _CarChooseListState();
}

class _CarChooseListState extends State<CarChooseList> {
  late ScrollController _scrollController; // Define ScrollController

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(); // Initialize ScrollController
  }

  // Function to scroll to the top of the list
  void scrollToTop() {
    _scrollController.animateTo(
      0.0, // Scroll to the top
      duration: Duration(milliseconds: 500), // Animation duration
      curve: Curves.easeInOut, // Animation curve
    );
  }

  late DatabaseReference ref;
  @override
  Query dbref = FirebaseDatabase.instance.ref().child("Cars");
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
                            builder: (context) => CreateNewCar(),
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                  controller: _scrollController,
                  itemBuilder: (context, snapshot, animation, index) {
                    Map car = snapshot.value as Map;
                    car['Key'] = snapshot.key;
                    return CustomCarCard(
                      carId: car['Id'],
                      carName: car['Name'],
                      healthText: car['Health'],
                      batteryValue: car['Battery'],
                      heartbeat: car['Heartbeat'],
                      speedValue: car['Speed'],
                      statusText: car['Status'],
                      speedLimit: car['SpeedLimit'],
                      keyId: snapshot.key!,
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
}
