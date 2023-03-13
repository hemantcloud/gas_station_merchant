import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gas_station_merchant/views/authentication/forgot_password.dart';
import 'package:gas_station_merchant/views/authentication/register.dart';
import 'package:gas_station_merchant/views/home/dashboard.dart';
import 'package:gas_station_merchant/views/utilities/utilities.dart';
import 'package:page_transition/page_transition.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isHidden = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    fontWeight: FontWeight.w600),
              ),
            ),
            TextFormField(
              controller: emailController,
              cursorColor: AppColors.primary,
              keyboardType: TextInputType.emailAddress,
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
              obscureText: _isHidden == true ? true : false,
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
    );
  }
}
