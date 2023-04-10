import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gas_station_merchant/views/authentication/login.dart';
import 'package:gas_station_merchant/views/home/dashboard.dart';
import 'package:gas_station_merchant/views/utilities/utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLogin = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, (){
      allProcess();
    });
  }
  Future<void> allProcess() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("prefs.getBool('isLogin') is -----------${prefs.getBool('isLogin')}");
    setState(() {
      if(prefs.getBool('isLogin') == true){
        Timer(const Duration(seconds: 2),() => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => Dashboard(bottomIndex: 0))));
      }else{
        Timer(const Duration(seconds: 2),() => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const Login())));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        // decoration: const BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage(
        //       'assets/images/bg.png',
        //     ),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        color: AppColors.primary,
        child: Center(
          child: SvgPicture.asset(
            'assets/icons/gas_station.svg',
            color: AppColors.white,
            // width: 177.0,
            // height: 183.0,
          ),
        ),
      ),
    );
  }
}
