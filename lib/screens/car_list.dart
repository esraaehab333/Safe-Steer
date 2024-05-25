/*// ignore_for_file: prefer_const_constructors, non_constant_identifier_names
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safe_steer/constants/colors.dart';
import 'package:safe_steer/models/car_card_model.dart';
import 'package:safe_steer/widgets/custom_button.dart';
import 'package:safe_steer/widgets/custom_form_text_filed.dart';
import 'package:safe_steer/widgets/custom_menu_drawer.dart';
import 'package:firebase_database/firebase_database.dart';

class CarList extends StatefulWidget {
  const CarList({super.key});

  @override
  State<CarList> createState() => _CarListState();
}

class _CarListState extends State<CarList> {
  List<CarCardModel> carmodelList = [];

  var _name = "";
  void _saveInputCarName(String InputName) {
    setState(() {
      _name = InputName;
    });
  }

  var _Id = "";
  void _saveInputCarId(String InputId) {
    setState(() {
      _Id = InputId;
    });
  }

  late DatabaseReference ref;
  @override
  void initState() {
    ref = FirebaseDatabase.instance.ref().child("Cars");
    super.initState();
  }

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
        // height: double.infinity,
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "choose",
                          style: GoogleFonts.genos(
                              color: MyWhite,
                              fontSize: 32,
                              fontWeight: FontWeight.w900),
                        ),
                        Text(
                          "a car",
                          style: GoogleFonts.genos(
                              color: MyWhite,
                              fontSize: 32,
                              fontWeight: FontWeight.w100),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        // drop menu
                      },
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (ctx) => Container(
                              height: 600,
                              width: double.infinity,
                              decoration: ShapeDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      MyColorMenuGradiant1,
                                      MyBlueGradiant1
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    topRight: Radius.circular(25),
                                  ),
                                ),
                                shadows: [
                                  BoxShadow(
                                    color: MyBlack,
                                    blurRadius: 4,
                                    offset: const Offset(0, 4),
                                    spreadRadius: 0,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    bottom: 30, right: 30, left: 30),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        height: 4,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: MyWhite1.withOpacity(0.5)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      "Add Car",
                                      style: GoogleFonts.inter(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: MyWhite),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    CustomFormTextFiled(
                                      hintText: "Car name",
                                      onChanged: _saveInputCarName,
                                      paddingValue1: 20,
                                      paddingValue2: 0,
                                      value: TextInputType.text,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    CustomFormTextFiled(
                                      hintText: "Car id",
                                      onChanged: _saveInputCarId,
                                      paddingValue1: 20,
                                      paddingValue2: 0,
                                      value: TextInputType.number,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    CustomButton(
                                      lable: "Add",
                                      onTap: () {
                                        Map<String, dynamic> cars = {
                                          "Battery": 0,
                                          "Heartbeat": 0,
                                          "Id": _Id,
                                          "Name": _name,
                                          "Speed": 0,
                                        };
                                        ref.push().set(cars);
                                        setState(() {
                                          CarCardModel cardModel = CarCardModel(
                                              carId: _Id, carName: _name);
                                          carmodelList.add(cardModel);
                                        });
                                        Navigator.pop(context);
                                      },
                                      height: 50,
                                      width: 250,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
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
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 400,
                child: FirebaseAnimatedList(
                  scrollDirection: Axis.horizontal,
                  query: dbref,
                  itemBuilder: (context, snapshot, animation, index) {
                    Map car = snapshot.value as Map;
                    car['Key'] = snapshot.key;
                    return CarCard(car: car);
                    // carId: , carName: car['Name']);
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
*/