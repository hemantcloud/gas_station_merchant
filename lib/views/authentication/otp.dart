// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gas_station_merchant/models/verify_otp_for_change_pass.dart';
import 'package:gas_station_merchant/views/authentication/create_password.dart';
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

class Otp extends StatefulWidget {
  String EmailOrPhone;
  String type;
  Otp({Key? key,required this.EmailOrPhone,required this.type}) : super(key: key);

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  TextEditingController otpController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('widget.EmailOrPhone is --------------${widget.EmailOrPhone}');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              padding: const EdgeInsets.only(top: 10.0,bottom: 10.0),
              child: SvgPicture.asset('assets/icons/left.svg'),
            ),
          ),
          toolbarHeight: 50.0,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.width * 0.1,
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
                // alignment: Alignment.center,
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.1),
                child: const Text(
                  'Enter OTP',
                  style: TextStyle(
                      color: AppColors.black,
                      fontSize: 26.0,
                      fontWeight: FontWeight.w600
                  ),
                  // textAlign: TextAlign.center,
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.width * 0.05),
                child: const Text(
                  'Enter verification code to reset your password',
                  style: TextStyle(color: AppColors.secondary),
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                height: 50.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 10.0),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller: otpController,
                        style: const TextStyle(fontSize: 14.0, color: AppColors.black),
                        cursorColor: AppColors.primary,
                        decoration: myInputDecoration('Enter OTP'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  String otp = otpController.text;
                  if(otp.isEmpty){
                    Utilities().toast('Please enter otp');
                  } else if(otp.length != 4){
                    Utilities().toast('Please enter valid otp');
                  }else {
                    if(widget.type == "mail"){
                      verifyOtpEmailForChangePassApi(context);
                    }else{
                      verifyOtpPhoneForChangePassApi(context);
                    }
                  }
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Container(
                  height: 55.0,
                  margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.05),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.all(Radius.circular(19.0)),
                  ),
                  child: const Text(
                    'Submit',
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
  myInputDecoration(String s) {
    return InputDecoration(
      hintText: s,
      hintStyle: const TextStyle(
        color: AppColors.secondary,
        fontWeight: FontWeight.w500,
      ),
      border: InputBorder.none,
    );
  }
  // verifyOtpForChangePassApi
  Future<void> verifyOtpEmailForChangePassApi(BuildContext context) async {
    Loader.ProgressloadingDialog(context, true);
    var request = {};
    request['email'] = widget.EmailOrPhone;
    request['otp'] = otpController.text;
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    var response = await http.post(Uri.parse(Urls.verifyOtpForgotPassword),
        body: convert.jsonEncode(request),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
          "X-CLIENT" : Urls.x_client_token,
        });
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    Loader.ProgressloadingDialog(context, false);
    VerifyOtpChangePassModel res = await VerifyOtpChangePassModel.fromJson(jsonResponse);
    if(res.status == true){
      Utilities().toast(res.message);
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeftWithFade,
          alignment: Alignment.topCenter,
          duration: const Duration(milliseconds: 1000),
          isIos: true,
          child: CreatePassword(EmailOrPhone: widget.EmailOrPhone.toString(),otp: otpController.text,type: widget.type),
        ),
      );
      setState(() {});
    }else{
      Utilities().toast(res.message);
      setState(() {});
    }
    return;
  }
  // verifyOtpForChangePassApi
  // verifyOtpForChangePassApi
  Future<void> verifyOtpPhoneForChangePassApi(BuildContext context) async {
    Loader.ProgressloadingDialog(context, true);
    var request = {};
    request['mobile_number'] = widget.EmailOrPhone;
    request['country_code'] = "91";
    request['otp'] = otpController.text;
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    var response = await http.post(Uri.parse(Urls.verifyOtpForgotPassword),
        body: convert.jsonEncode(request),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
          "X-CLIENT" : Urls.x_client_token,
        });
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    Loader.ProgressloadingDialog(context, false);
    VerifyOtpChangePassModel res = await VerifyOtpChangePassModel.fromJson(jsonResponse);
    if(res.status == true){
      Utilities().toast(res.message);
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeftWithFade,
          alignment: Alignment.topCenter,
          duration: const Duration(milliseconds: 1000),
          isIos: true,
          child: CreatePassword(EmailOrPhone: widget.EmailOrPhone.toString(),otp: otpController.text,type: widget.type),
        ),
      );
      setState(() {});
    }else{
      Utilities().toast(res.message);
      setState(() {});
    }
    return;
  }
  // verifyOtpForChangePassApi
}
