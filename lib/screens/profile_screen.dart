import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safe_steer/constants/colors.dart';
import 'package:safe_steer/helper/delete_dialog.dart';
import 'package:safe_steer/widgets/custom_car_button.dart';
import '../helper/show_snack_bar.dart';
import '../widgets/profile_item.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? username;
  late String phone;
  late String? imageUrl;
  late User? user;
  File? _image;
  bool isuploaded = false;
  static const spinkit = SpinKitThreeBounce(
    color: Colors.white,
    size: 50.0,
  );

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      isuploaded = true;
    }
    print(_image);
  }

  Future<void> _uploadImage() async {
    if (_image == null) return;
    try {
      String fileName = user!.uid;
      Reference storageRef =
          FirebaseStorage.instance.ref().child('uploads/${fileName}.jpg');
      SettableMetadata metadata = SettableMetadata(
        contentType: 'image/jpeg',
      );
      UploadTask uploadTask = storageRef.putFile(_image!, metadata);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      print('Upload complete. Download URL: $downloadUrl');
    } catch (e) {
      print('Error occurred during upload: $e');
    }
  }

  Future<void> initializeData() async {
    final ref = FirebaseDatabase.instance.ref();
    final auth = FirebaseAuth.instance;
    user = auth.currentUser;
    final snapshot = await ref.child('Users/${user!.uid}').get();
    Map<dynamic, dynamic> data = snapshot.value as Map;
    phone = data["phone"];
    username = data["username"];
    imageUrl = data["imageUrl"];
    setState(() {});
  }

  Future<String> _getImageUrl() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child('uploads/${user!.uid}.jpg');
    try {
      await ref.getMetadata();
      String url = await ref.getDownloadURL();
      print(url);
      return url;
    } catch (e) {
      // If the user's image doesn't exist, get the default image
      ref = storage.ref().child('uploads/default.jpg');
      String url = await ref.getDownloadURL();
      print(url);
      return url;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: MyBlack,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [MyBlack, MyBlueGradiant1, MyBlack],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft),
            ),
            child: username == null
                ? spinkit
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: Alignment.bottomCenter,
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.324,
                              width: double.infinity,
                              child: FutureBuilder(
                                future: _getImageUrl(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text('error has occures');
                                  } else {
                                    return CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: _image == null
                                          ? snapshot.data!
                                          : _image!.path,
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          Image.file(
                                        _image!,
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  }
                                },
                              )),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.324,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(43, 64, 67, 0.6),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 12, left: 2, top: 38),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(
                                      Icons.arrow_back_ios_new_rounded,
                                      color: MyWhite,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      "PROFILE",
                                      style: GoogleFonts.inter(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: MyWhite,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      showDialog(
                                        context: context,
                                        builder: (context) => Dialog(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: MyWhite1,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 10),
                                              child: SizedBox(
                                                height: 120,
                                                width: 220,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    SaveChanges(),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    DoYouWantSaveChanges(),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        InkWell(
                                                          onTap: () async {
                                                            DatabaseReference
                                                                ref =
                                                                FirebaseDatabase
                                                                    .instance
                                                                    .ref(
                                                                        "Users/${user!.uid}");
                                                            await ref.update({
                                                              "username":
                                                                  username,
                                                              "phone": phone,
                                                            });
                                                            _uploadImage();
                                                            Navigator.of(
                                                                    context,
                                                                    rootNavigator:
                                                                        true)
                                                                .pop(context);
                                                            Navigator.pop(
                                                                context);
                                                            showSnackBar(
                                                                context,
                                                                "Changes saved");
                                                          },
                                                          child: Text(
                                                            "yes",
                                                            style: GoogleFonts
                                                                .inter(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: MyRed,
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 35,
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            Navigator.of(
                                                                    context,
                                                                    rootNavigator:
                                                                        true)
                                                                .pop(context);
                                                            Navigator.pop(
                                                                context);
                                                            showSnackBar(
                                                                context,
                                                                "Changes discarded");
                                                          },
                                                          child: Text(
                                                            "no",
                                                            style: GoogleFonts
                                                                .inter(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: MyBlack,
                                                            ),
                                                          ),
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
                                    icon: Icon(
                                      Icons.check,
                                      color: MyWhite,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: -61,
                            child: Stack(
                              clipBehavior: Clip.none,
                              alignment: Alignment.topRight,
                              children: [
                                Container(
                                  height: 120,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(60),
                                    color: MyWhite,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(60),
                                        child: FutureBuilder(
                                          future: _getImageUrl(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return CircularProgressIndicator();
                                            } else if (snapshot.hasError) {
                                              print(snapshot.error);
                                              return Text(
                                                  'Error: ${snapshot.error}');
                                            } else {
                                              return CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                imageUrl: _image == null
                                                    ? snapshot.data!
                                                    : _image!.path,
                                                placeholder: (context, url) =>
                                                    CircularProgressIndicator(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Image.file(
                                                  _image!,
                                                  fit: BoxFit.cover,
                                                ),
                                              );
                                            }
                                          },
                                        )),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _pickImage();
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(60),
                                      color: MyBlueGradiant5,
                                    ),
                                    child: Icon(
                                      Icons.add_a_photo_outlined,
                                      color: MyWhite3,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 70,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ProfileItem(
                              hinttext: "enter your Id",
                              enable: false,
                              initialValue:
                                  user!.uid, //////////////////////////
                              label: "Your ID",
                              initialColor: MYBlueGradiant3,
                            ),
                            ProfileItem(
                              hinttext: "enter your email",
                              enable: false,
                              initialValue: user!.email!,
                              label: "Email",
                              initialColor: MYBlueGradiant3,
                            ),
                            ProfileItem(
                              hinttext: "enter your username",
                              enable: true,
                              initialValue: username!,
                              label: "Username",
                              initialColor: MYBlueGradiant3,
                              onchange: (p0) {
                                username = p0;
                                setState(() {});
                              },
                            ),
                            ProfileItem(
                              hinttext: "enter your phone",
                              enable: true,
                              initialValue: phone!,
                              label: "Phone",
                              initialColor: MYBlueGradiant3,
                              onchange: (p0) {
                                phone = p0;
                                setState(() {});
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CarButton(
                              ontap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => DeleteAlert(),
                                );
                              },
                              text: "Delete Account",
                              color1: MyRed,
                              color2: MyRed,
                              colortext: MyWhite,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class DoYouWantSaveChanges extends StatelessWidget {
  const DoYouWantSaveChanges({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: 2,
      "Do you want to save changes ?",
      style: GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: MyBlack,
      ),
    );
  }
}

class SaveChanges extends StatelessWidget {
  const SaveChanges({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Save Changes !!",
        style: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: MyRed,
        ),
      ),
    );
  }
}
