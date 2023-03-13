import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gas_station_merchant/views/authentication/create_password.dart';
import 'package:gas_station_merchant/views/authentication/forgot_password.dart';
import 'package:gas_station_merchant/views/utilities/utilities.dart';
import 'package:page_transition/page_transition.dart';

class Otp extends StatefulWidget {
  const Otp({Key? key}) : super(key: key);

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeftWithFade,
                    alignment: Alignment.topCenter,
                    duration: const Duration(milliseconds: 1000),
                    isIos: true,
                    child: const CreatePassword(),
                  ),
                );
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
}
