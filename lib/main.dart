
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_steer/screens/car_choose_list.dart';
import 'package:safe_steer/screens/splash_screen.dart';
import 'package:safe_steer/screens/welcome_screen.dart';
import 'package:safe_steer/services/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            '/welcome': (BuildContext context) => WelcomeScreen(),
            '/carlist': (BuildContext context) => CarChooseList(),
          },
          home: SplashScreen()),
    );
  }
}
