// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gas_station_merchant/models/reset_password_model.dart';
import 'package:gas_station_merchant/views/authentication/login.dart';
import 'package:gas_station_merchant/views/utilities/loader.dart';
import 'package:gas_station_merchant/views/utilities/urls.dart';
import 'package:gas_station_merchant/views/utilities/utilities.dart';
import 'package:page_transition/page_transition.dart';
// apis
import 'dart:async';
import 'dart:convert' as convert;
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:flutter/foundation.dart';
// apis

class CreatePassword extends StatefulWidget {
  String EmailOrPhone;
  String otp;
  String type;
  CreatePassword({Key? key,required this.EmailOrPhone,required this.otp,required this.type}) : super(key: key);

  @override
  State<CreatePassword> createState() => _CreatePasswordState();
}

class _CreatePasswordState extends State<CreatePassword> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
  bool _isHidden = false;
  bool _isHidden2 = false;

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
                  'Create New Password',
                  style: TextStyle(
                      color: AppColors.black,
                      fontSize: 26.0,
                      fontWeight: FontWeight.w600),
                ),
              ),
              TextFormField(
                controller: passwordController,
                obscureText: _isHidden == true ? false : true,
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
              InkWell(
                onTap: () {
                  String pass = passwordController.text;
                  String cPass = cPasswordController.text;
                  // RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                  if(pass.isEmpty){
                    Utilities().toast('Please enter new password');
                  } else if(pass.length < 6){
                    Utilities().toast('Please enter strong password');
                  } else if(cPass.isEmpty){
                    Utilities().toast('Please enter confirm password');
                  } else if(cPass.length < 6){
                    Utilities().toast('Please enter confirm strong password');
                  } else if(pass != cPass){
                    Utilities().toast('Password must be same as above');
                  }else {
                    if(widget.type == "mail"){
                      resetEmailPassApi(context);
                    }else{
                      resetPhonePassApi(context);
                    }
                  }
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Container(
                  height: 55.0,
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.05),
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
  Future filterAlert(context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        insetPadding: EdgeInsets.symmetric(horizontal: 20.0,vertical: MediaQuery.of(context).size.height * 0.18),
        content: Container(
          // padding: EdgeInsets.symmetric(vertical: 10.0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            border: Border.all(color: Colors.white),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('assets/icons/check.gif',height: 150.0,),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: const Text(
                  'Congratulation',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: AppColors.black,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
              const Text(
                'You have successfully changed your password',
                style: TextStyle(
                  color: AppColors.secondary,
                ),
                textAlign: TextAlign.center,
                // maxLines: 3,
                // overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeftWithFade,
                            alignment: Alignment.topCenter,
                            duration: const Duration(milliseconds: 1000),
                            isIos: true,
                            child: const Login(),
                          ),
                          (route) => false,
                        );
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
  // resetPassApi
  Future<void> resetEmailPassApi(BuildContext context) async {
    Loader.ProgressloadingDialog(context, true);
    var request = {};
    request['email'] = widget.EmailOrPhone;
    request['otp'] = widget.otp;
    request['country_code'] = "91";
    request['new_password'] = passwordController.text;
    request['confirm_password'] = cPasswordController.text;
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    var response = await http.post(Uri.parse(Urls.resetPassword),
        body: convert.jsonEncode(request),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
          "X-CLIENT" : Urls.x_client_token,
        });
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    Loader.ProgressloadingDialog(context, false);
    ResetPasswordModel res = await ResetPasswordModel.fromJson(jsonResponse);
    if(res.status == true){
      // Utilities().toast(res.message);
      filterAlert(context);
      setState(() {});
    }else{
      Utilities().toast(res.message);
      setState(() {});
    }
    return;
  }
  // resetPassApi
  // resetPassApi
  Future<void> resetPhonePassApi(BuildContext context) async {
    Loader.ProgressloadingDialog(context, true);
    var request = {};
    request['mobile_number'] = widget.EmailOrPhone;
    request['country_code'] = "91";
    request['otp'] = widget.otp;
    request['new_password'] = passwordController.text;
    request['confirm_password'] = cPasswordController.text;
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    var response = await http.post(Uri.parse(Urls.resetPassword),
        body: convert.jsonEncode(request),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
          "X-CLIENT" : Urls.x_client_token,
        });
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    Loader.ProgressloadingDialog(context, false);
    ResetPasswordModel res = await ResetPasswordModel.fromJson(jsonResponse);
    if(res.status == true){
      // Utilities().toast(res.message);
      filterAlert(context);
      setState(() {});
    }else{
      Utilities().toast(res.message);
      setState(() {});
    }
    return;
  }
  // resetPassApi
}
