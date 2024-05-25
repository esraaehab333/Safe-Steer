import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safe_steer/constants/colors.dart';
import 'package:safe_steer/widgets/my_elevated_button.dart';
import '../helper/show_snack_bar.dart';

import '../widgets/dialog_item_add_car.dart';
List<String> _ids = [];
class CreateNewCar extends StatefulWidget {
  final ScrollController controller;
  const CreateNewCar({Key? key , required this.controller});

  @override
  State<CreateNewCar> createState() => _CreateNewCarState();
}

class _CreateNewCarState extends State<CreateNewCar> {
  String? _name;
  String? _id;
  String? _speedLimit;
  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.controller.hasClients) {
        // Get the maximum scroll extent
        final maxScrollExtent = widget.controller.position.maxScrollExtent;

        // Calculate the scroll position to reach the end plus 1 item
        final scrollPosition = maxScrollExtent + widget.controller.position.viewportDimension;

        // Animate the scroll to the calculated position
        widget.controller.animateTo(
          scrollPosition,
          duration: Duration(seconds: 1),
          curve: Curves.easeIn,
        );
      }
    });
  }

  late DatabaseReference ref;
  @override
  void initState() {
    ref = FirebaseDatabase.instance.ref().child("Cars");
    super.initState();
  }

  var key = GlobalKey<FormState>();
  Query dbref = FirebaseDatabase.instance.ref().child("Cars");
  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height *0.25);
    return Scaffold(
      backgroundColor: MyBlack,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [MyBlack, MyBlueGradiant1, MyBlack],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               SizedBox(
                height: 30.h,
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: MyWhite1,
                ),
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 30.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Creation",
                      style: GoogleFonts.genos(
                          color: MyWhite,
                          fontSize: 40.sp,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "of new car",
                      style: GoogleFonts.cairo(
                          color: MyWhite,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Image.asset(
                  "assets/images/carr.png",
                  height:MediaQuery.of(context).size.height *0.2,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.topRight,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xff1B5459),
                            Color(0xff152324),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Form(
                          key: key,
                          child: Column(// noi space
                            children: [
                              DialogItem(
                                carLabel: 'Car Name',
                                hintText: 'enter car name',
                                focuseColor: MyBlueText,
                                enableColor: MYBlueGradiant3,
                                validator: (p0) {
                                  if (p0 == null || p0.isEmpty) {
                                    return 'please enter car name';
                                  }
                                },
                                onChanged: (p0) {
                                  _name = p0;
                                },
                                value: TextInputType.text,
                              ),
                              DialogItem(
                                carLabel: 'Car ID',
                                hintText: 'enter car id',
                                focuseColor: MyBlueText,
                                enableColor: MYBlueGradiant3,
                                validator: (p0) {
                                  if (p0 == null || p0.isEmpty) {
                                    return 'please enter car id';
                                  }
                                },
                                onChanged: (p0) {
                                  _id = p0;
                                },
                                value: TextInputType.number,
                              ),
                              DialogItem(
                                carLabel: 'Speed Limit',
                                hintText: 'enter car speed limit',
                                focuseColor: MyBlueText,
                                enableColor: MYBlueGradiant3,
                                validator: (p0) {
                                  if (p0 == null || p0.isEmpty) {
                                    return 'please enter speed limit';
                                  }
                                },
                                onChanged: (p0) {

                                  _speedLimit = p0;
                                },
                                value: TextInputType.number,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    MyElevatedButton(
                      onPressed: () {
                        /////////////////////////////////////////////////////

                        print(_ids.toList());
                        if (key.currentState!.validate()) {
                          if(_ids.isEmpty == true){
                            Map<String, dynamic> cars = {
                              "Battery": "100",
                              "Heartbeat": "190",
                              "Id": _id,
                              "Name": _name,
                              "SpeedLimit": _speedLimit,
                              "Speed": "120",
                              "Health": "Sober",
                              "Status": "Hold",
                            };
                            ref.push().set(cars);
                            _ids.add(_id!);

                            showSnackBar(context, "Sucess creation");
                            Navigator.pop(context);
                          }
                          else{
                            print(_id);
                            print(_ids.contains(_id));
                            if(_ids.contains(_id) == true){
                              showSnackBar(context, "this id has already taken");
                            }
                            else{
                              _ids.add(_id!);
                              Map<String, dynamic> cars = {
                                "Battery": "0",
                                "Heartbeat": "0",
                                "Id": _id,
                                "Name": _name,
                                "SpeedLimit": _speedLimit,
                                "Speed": "0",
                                "Health": "0",
                                "Status": "0",
                              };
                              ref.push().set(cars);
                              showSnackBar(context, "Sucess creation");
                              Navigator.pop(context);
                            }
                          }
                        }
                        scrollToBottom();
                      },
                      borderRadius: BorderRadius.circular(23),
                      height: 40,
                      width: 220,
                      gradient: LinearGradient(
                          colors: [
                            MyGradiantAddCarButton1,
                            MyGradiantAddCarButton2
                          ],
                          end: Alignment.bottomCenter,
                          begin: Alignment.topCenter),
                      child: Text(
                        "create a new car",
                        style: GoogleFonts.cairo(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: MyBlueG,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    MyElevatedButton(
                      onPressed: () {
                        showSnackBar(context, "Changes Discard");
                         Navigator.pop(context);
                      },
                      borderRadius: BorderRadius.circular(23),
                      height: 40,
                      width: 220,
                      gradient: LinearGradient(
                          colors: [
                            MyGradiantCancelCarButton1,
                            MyGradiantCancelCarButton2
                          ],
                          end: Alignment.bottomCenter,
                          begin: Alignment.topCenter),
                      child: Text(
                        "cancel the changes",
                        style: GoogleFonts.cairo(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: MyWhite,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
