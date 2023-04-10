import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:gas_station_merchant/views/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
String? fcmToken;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = await FirebaseMessaging.instance.getToken();
  prefs.setString("fcmToken", token.toString());
  fcmToken = token.toString();
  print("FCM token is -------------------$token");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gas Station (Merchant)',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
      // home: Test(title: "Test Page"),
    );
  }
}