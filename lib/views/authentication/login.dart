// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gas_station_merchant/models/login_model.dart';
import 'package:gas_station_merchant/views/authentication/forgot_password.dart';
import 'package:gas_station_merchant/views/authentication/register.dart';
import 'package:gas_station_merchant/views/home/dashboard.dart';
import 'package:gas_station_merchant/views/utilities/loader.dart';
import 'package:gas_station_merchant/views/utilities/urls.dart';
import 'package:gas_station_merchant/views/utilities/utilities.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart' as loc;
// apis
import 'dart:io';
import 'dart:async';
import 'dart:convert' as convert;
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
// apis

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isHidden = false;
  String? deviceType;
  String? deviceId;
  String text = "Loading...";
  loc.LocationData? locationData;
  String? lat;
  String? long;
  String? timeZone;
  String? fcmToken;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero,(){
      allProcess();
    });
  }
  Future<void> allProcess() async {
    loadInfo();
    getPermission();
    getTimeZone();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    fcmToken = prefs.getString("fcmToken");
  }
  Future getPermission() async {
    if (await Permission.location.isGranted) {
      getLatLong();
    } else {
      Permission.location.request();
      locationData = await loc.Location.instance.getLocation();
      lat = locationData!.latitude.toString();
      long = locationData!.longitude.toString();
      print('lat : ---------' + locationData!.latitude.toString());
      print('long : ---------' + locationData!.longitude.toString());
      setState(() {});
    }
  }
  Future getLatLong() async {
    locationData = await loc.Location.instance.getLocation();
    lat = locationData!.latitude.toString();
    long = locationData!.longitude.toString();
    print('lat : ---------' + locationData!.latitude.toString());
    print('long : ---------' + locationData!.longitude.toString());
    setState(() {});
  }
  getTimeZone() async{
    timeZone = await FlutterNativeTimezone.getLocalTimezone();
    print("timeZone is -----------$timeZone");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.width * 0.3,
            left: 16.0,
            right: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SvgPicture.asset('assets/icons/gas_station.svg'),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width * 0.1),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 26.0,
                    fontWeight: FontWeight.w600,
                    // foreground: Paint()..shader = LinearGradient(
                    //   colors: <Color>[
                    //     Colors.red,
                    //     Colors.green,
                    //     Colors.yellow,
                    //     //add more color here.
                    //   ],
                    // ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 100.0))
                  ),
                ),
              ),
              TextFormField(
                controller: emailController,
                cursorColor: AppColors.primary,
                // keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w600,
                      fontSize: 15.0),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: passwordController,
                obscureText: _isHidden == true ? false : true,
                cursorColor: AppColors.primary,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: const TextStyle(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w600,
                      fontSize: 15.0),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  // hintText: '••••••••',
                  // hintStyle: const TextStyle(color: AppColors.black),
                  suffixIcon: InkWell(
                    onTap: () {
                      _isHidden = !_isHidden;
                      setState(() {});
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: _isHidden == false
                        ? Image.asset('assets/icons/hide.png',color: AppColors.secondary)
                        : Image.asset('assets/icons/show.png',color: AppColors.secondary),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      alignment: Alignment.topCenter,
                      duration: const Duration(milliseconds: 1000),
                      isIos: true,
                      child: const ForgotPassword(),
                    ),
                  );
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(color: AppColors.primary),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              InkWell(
                onTap: () {
                  String email = emailController.text;
                  String password = passwordController.text;
                  // RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                  if(email.isEmpty) {
                    Utilities().toast('Please enter email ID');
                  } else if(!email.contains("@gmail.com")){
                    Utilities().toast('Please enter valid email address');
                  } else if(password.isEmpty){
                    Utilities().toast('Please enter password');
                  } else if(password.length < 6){
                    Utilities().toast('Please enter strong password');
                  }else {
                    loginApi(context);
                    // waitingAlert(context);
                  }
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Container(
                  height: 55.0,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.all(Radius.circular(19.0)),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      alignment: Alignment.topCenter,
                      duration: const Duration(milliseconds: 1000),
                      isIos: true,
                      child: const Register(),
                    ),
                  );
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 10.0),
                  child: const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: 'Don’t have an account? ',style: TextStyle(color: AppColors.black)),
                        TextSpan(
                            text: 'Sign up',
                            style: TextStyle(color: AppColors.primary)
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> loginApi(BuildContext context) async {
    Loader.ProgressloadingDialog(context, true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var request = {};
    request['email'] = emailController.text;
    request['password'] = passwordController.text;
    request['device_type'] = deviceType!;
    request['device_id'] = deviceId!;
    request['fcm_token'] = fcmToken!;
    request['timezone'] = timeZone!;
    request['latitude'] = lat!;
    request['longitude'] = long!;
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    var response = await http.post(Uri.parse(Urls.login),
        body: convert.jsonEncode(request),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
          "X_CLIENT": Urls.x_client_token,
        });
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    Loader.ProgressloadingDialog(context, false);
    LoginModel res = await LoginModel.fromJson(jsonResponse);
    if (res.status == true) {
      Utilities().toast(res.message);
      prefs.setString('authToken', res.data!.userData!.authToken.toString());
      prefs.setString('userId', res.data!.userData!.id.toString());
      prefs.setBool('isLogin', true);
      Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeftWithFade,
          alignment: Alignment.topCenter,
          duration: const Duration(milliseconds: 1000),
          isIos: true,
          child: Dashboard(bottomIndex: 0),
        ),
        (route) => false,
      );
    } else {
      if(res.message == "Waiting for admin approval."){
        waitingAlert(context);
      }else{
        Utilities().toast(res.message);
      }
    }
    return;
  }
  /// loads device info
  void loadInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (kIsWeb) {
      WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
      // e.g. "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:61.0) Gecko/20100101 Firefox/61.0"
      print('Web - Running on ${webBrowserInfo.userAgent}');
      setState(() {
        text = webBrowserInfo.toMap().toString();
      });
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      print('iOS - Running on ${iosInfo.utsname.machine}'); // e.g. "iPod7,1"
      deviceId = iosInfo.model.toString();
      deviceType = 'ios';
      setState(() {
        text = iosInfo.toMap().toString();
      });
    } else if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      /*print('Android - Running on ${androidInfo.id}'); // e.g. "Moto G (4)"
      print('androidInfo.model -------${androidInfo.model}');
      print('androidInfo.type -------${androidInfo.type}');
      print('androidInfo.device -------${androidInfo.device}');
      print('androidInfo.board -------${androidInfo.board}');
      print('androidInfo.bootloader -------${androidInfo.bootloader}');
      print('androidInfo.brand -------${androidInfo.brand}');
      print('androidInfo.display -------${androidInfo.display}');
      print('androidInfo.fingerprint -------${androidInfo.fingerprint}');
      print('androidInfo.hardware -------${androidInfo.hardware}');
      print('androidInfo.host -------${androidInfo.host}');
      print('androidInfo.isPhysicalDevice -------${androidInfo.isPhysicalDevice}');
      print('androidInfo.manufacturer -------${androidInfo.manufacturer}');
      print('androidInfo.product -------${androidInfo.product}');
      print('androidInfo.tags -------${androidInfo.tags}');*/
      deviceId = androidInfo.id;
      print("deviceid is ---------------$deviceId");
      deviceType = 'android';
      print("devicetype is ---------------$deviceType");
      setState(() {
        text = androidInfo.toMap().toString();
      });
    } else if (Platform.isWindows) {
      WindowsDeviceInfo windowsInfo = await deviceInfo.windowsInfo;
      print(windowsInfo.toMap().toString());
      setState(() {
        text = windowsInfo.toMap().toString();
      });
    } else if (Platform.isMacOS) {
      MacOsDeviceInfo macOSInfo = await deviceInfo.macOsInfo;
      print(macOSInfo.toMap().toString());
      setState(() {
        text = macOSInfo.toMap().toString();
      });
    } else if (Platform.isLinux) {
      LinuxDeviceInfo linuxInfo = await deviceInfo.linuxInfo;
      print(linuxInfo.toMap().toString());
      setState(() {
        text = linuxInfo.toMap().toString();
      });
    }
  }
  Future waitingAlert(context) {
    setState(() {});
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        insetPadding: const EdgeInsets.symmetric(horizontal: 20.0/*,vertical: MediaQuery.of(context).size.height * 0.18*/),
        content: Container(
          // padding: EdgeInsets.symmetric(vertical: 10.0),
          height: 280.0,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            border: Border.all(color: Colors.white),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset('assets/icons/waiting_for_approval.svg',height: 120.0,color: AppColors.primary,),
              // Container(
              //   padding: const EdgeInsets.symmetric(vertical: 10.0),
              //   child: const Text(
              //     'Registration Completed\nSuccessfully',
              //     style: TextStyle(
              //         fontSize: 20.0,
              //         color: AppColors.black,
              //         fontWeight: FontWeight.w600
              //     ),
              //     textAlign: TextAlign.center,
              //   ),
              // ),
              const SizedBox(height: 10.0),
              const Text(
                'Your account is under review.\nPlease wait for some time.',
                style: TextStyle(
                  color: AppColors.secondary,
                ),
                textAlign: TextAlign.center,
                // maxLines: 3,
                // overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10.0,),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        // Navigator.pushAndRemoveUntil(
                        //   context,
                        //   PageTransition(
                        //     type: PageTransitionType.rightToLeftWithFade,
                        //     alignment: Alignment.topCenter,
                        //     duration: const Duration(milliseconds: 1000),
                        //     isIos: true,
                        //     child: const Login(),
                        //   ),
                        //       (route) => false,
                        // );
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50.0,
                        margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.15),
                        // padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.all(Radius.circular(19.0)),
                        ),
                        child: const Text(
                          'OK',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
