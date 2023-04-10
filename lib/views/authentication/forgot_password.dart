import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gas_station_merchant/views/authentication/phone_or_mail.dart';
import 'package:gas_station_merchant/views/utilities/utilities.dart';
import 'package:page_transition/page_transition.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String phone = '9685326984';
  String mail = 'hemantcloudwapp@gmail.com';
  String select = '';
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
                padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width * 0.1),
                child: const Text(
                  'Forgot Password',
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
                  'Select credential which should we use to recover your password.',
                  style: TextStyle(color: AppColors.secondary),
                  textAlign: TextAlign.start,
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    select = 'phone';
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 10.0),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    color: Color(0xFFEEEEEE),
                  ),
                  child: Row(
                    children: [
                      select == 'phone' ?
                      SvgPicture.asset('assets/icons/selected.svg') :
                      SvgPicture.asset('assets/icons/unselected.svg'),
                      const SizedBox(width: 10.0),
                      SvgPicture.asset('assets/icons/phone.svg'),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: Text(
                          'XXX XXX ${phone.substring(6,10)}',
                          style: const TextStyle(color: AppColors.black,fontSize: 16.0),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              InkWell(
                onTap: () {
                  setState(() {
                    select = 'mail';
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 10.0),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    color: Color(0xFFEEEEEE),
                  ),
                  child: Row(
                    children: [
                      select == 'mail' ?
                      SvgPicture.asset('assets/icons/selected.svg') :
                      SvgPicture.asset('assets/icons/unselected.svg'),
                      const SizedBox(width: 10.0),
                      SvgPicture.asset('assets/icons/mail.svg'),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: Text(
                          '****${mail.substring(mail.length - 10)}',
                          style: const TextStyle(color: AppColors.black,fontSize: 16.0),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  if(select.isEmpty){
                    Utilities().toast('Please Select something');
                  }else {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeftWithFade,
                        alignment: Alignment.topCenter,
                        duration: const Duration(milliseconds: 1000),
                        isIos: true,
                        child: PhoneOrMail(type: select),
                      ),
                    );
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
}
