import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserInformation extends StatefulWidget {
  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('Users').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            return ListTile(
              title: Text(data['full_name']),
              subtitle: Text(data['company']),
            );
          }).toList(),
        );
      },
    );
  }
}
/* MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            backgroundColor: Colors.black,
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [MyBlack, MyBlueGradiant1, MyBlack],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
              ),
              child: Column(
                children: [
                  CustomAppBar(
                    arrowbackOnpressed: () {
                      /*showDialog(
                        context: context,
                        builder: (context) {
                          return AdvancedDialog();
                        });*/
                      Navigator.pop(context);
                    },
                    settingsOnpressed: () => AdvancedDialog(),
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
                    namecar1,
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
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * .2,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      alignment: Alignment.center,
                    ),
                  ),
                  Text(
                    "ID: ${widget.idcar}",
                    style: GoogleFonts.cairo(
                      fontSize: 18.sp,
                      color: MyWhite,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.005,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            CustomBattaryBox(battaty: widget.battaryvalue),
                            SizedBox(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.0177,
                            ),
                            CustomStatusBox(statustext: widget.statusText),
                            SizedBox(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.0177,
                            ),
                            CustomHealthBox(healthtext: widget.healthText),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            CustomSpeedBox(speedvalue: widget.speedValue),
                            SizedBox(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.0177,
                            ),
                            CustomHeartRateBox(heartbeats: widget.heartbeat),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );*/