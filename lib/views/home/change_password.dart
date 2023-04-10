// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gas_station_merchant/models/change_password_model.dart';
import 'package:gas_station_merchant/views/authentication/forgot_password.dart';
import 'package:gas_station_merchant/views/authentication/register.dart';
import 'package:gas_station_merchant/views/home/dashboard.dart';
import 'package:gas_station_merchant/views/utilities/loader.dart';
import 'package:gas_station_merchant/views/utilities/urls.dart';
import 'package:gas_station_merchant/views/utilities/utilities.dart';
import 'package:page_transition/page_transition.dart';
// apis
import 'dart:io';
import 'dart:async';
import 'dart:convert' as convert;
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
// apis

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
  bool _isHiddenOld = false;
  bool _isHidden = false;
  bool _isHidden2 = false;
  late String authToken;
  late String userId;
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
    setState(() {
      authToken = prefs.getString('authToken')!;
      userId = prefs.getString('userId')!;
      print('my auth token is >>>>> {$authToken}');
      print('my user id is >>>>> {$userId}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.primary,
          leading: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              padding: const EdgeInsets.only(top: 15.0,bottom: 15.0),
              child: SvgPicture.asset('assets/icons/left.svg',color: Colors.white,),
            ),
          ),
          title: const Text('Change Password',style: TextStyle(fontSize: 18.0,)),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.width * 0.05,
            left: 16.0,
            right: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width * 0.1),
                child: const Text(
                  'Change Password',
                  style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 26.0,
                      fontWeight: FontWeight.w600),
                ),
              ),
              TextFormField(
                obscureText: _isHiddenOld == true ? false : true,
                controller: oldPasswordController,
                cursorColor: AppColors.primary,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: 'Old Password',
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
                      _isHiddenOld = !_isHiddenOld;
                      setState(() {});
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: _isHiddenOld == false
                        ? Image.asset('assets/icons/hide.png',color: AppColors.secondary)
                        : Image.asset('assets/icons/show.png',color: AppColors.secondary),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                obscureText: _isHidden == true ? false : true,
                controller: passwordController,
                cursorColor: AppColors.primary,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: 'New Password',
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
              TextFormField(
                controller: cPasswordController,
                obscureText: _isHidden2 == true ? false : true,
                cursorColor: AppColors.primary,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
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
                      _isHidden2 = !_isHidden2;
                      setState(() {});
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: _isHidden2 == false
                        ? Image.asset('assets/icons/hide.png',color: AppColors.secondary)
                        : Image.asset('assets/icons/show.png',color: AppColors.secondary),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              InkWell(
                onTap: () {
                  String oldPass = oldPasswordController.text;
                  String pass = passwordController.text;
                  String cPass = cPasswordController.text;
                  // RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                  if(oldPass.isEmpty){
                    Utilities().toast('Please enter old password');
                  } else if(pass.isEmpty){
                    Utilities().toast('Please enter new password');
                  } else if(pass.length < 6){
                    Utilities().toast('Please enter password strong');
                  } else if(cPass.isEmpty){
                    Utilities().toast('Please enter confirm password');
                  } else if(cPass.length < 6){
                    Utilities().toast('Please enter confirm password strong');
                  } else if(pass != cPass){
                    Utilities().toast('Password must be same as above');
                  }else {
                    changePasswordApi(context);
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
                    'Update',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
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
  // changePassword Api
  Future<void> changePasswordApi(BuildContext context) async {
    Loader.progressLoadingDialog(context, true);
    var request = {};
    request['old_password'] = oldPasswordController.text;
    request['new_password'] = passwordController.text;
    request['confirm_password'] = cPasswordController.text;
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    var response = await http.post(Uri.parse(Urls.changePassword),
        body: convert.jsonEncode(request),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
          "X-AUTHTOKEN" : authToken,
          "X-USERID" : userId,
        });
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    Loader.progressLoadingDialog(context, false);
    ChangePasswordModel res = await ChangePasswordModel.fromJson(jsonResponse);
    if(res.status == true){
      Utilities().toast(res.message);
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
      setState(() {});
    }else{
      Utilities().toast(res.message);
      setState(() {});
    }
    return;
  }
  // changePassword Api
}
