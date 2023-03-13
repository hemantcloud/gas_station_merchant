import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gas_station_merchant/views/authentication/login.dart';
import 'package:gas_station_merchant/views/home/dashboard.dart';
import 'package:gas_station_merchant/views/utilities/utilities.dart';
import 'package:page_transition/page_transition.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: AppColors.primary,
          title: const Text('Account',style: TextStyle(fontSize: 18.0,)),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 10.0),
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    SvgPicture.asset('assets/icons/gas_station.svg'),
                    const SizedBox(height: 20.0),
                    const Text(
                      'Quick Stop Station',
                      style: TextStyle(color: AppColors.black,fontSize: 16.0,fontWeight: FontWeight.w600),
                    ),
                    const Text(
                      'steveaustin@gmail.com',
                      style: TextStyle(color: AppColors.secondary,),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   PageTransition(
                  //     type: PageTransitionType.rightToLeftWithFade,
                  //     alignment: Alignment.topCenter,
                  //     duration: const Duration(milliseconds: 1000),
                  //     isIos: true,
                  //     child: const UpdateProfile(),
                  //   ),
                  // );
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Container(
                  height: 58.0,
                  margin: const EdgeInsets.only(top: 10.0),
                  padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                  decoration: myBoxDecoration(),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/icons/profile.svg'),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: VerticalDivider(
                          color: AppColors.primary,
                          thickness: 1,
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: Text(
                          'Profile',
                          style: TextStyle(color: AppColors.secondary),
                        ),
                      ),
                      SvgPicture.asset('assets/icons/right.svg',width: 10.0),
                    ],
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
                      child: Dashboard(bottomIndex: 2),
                    ),
                  );
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Container(
                  height: 58.0,
                  margin: const EdgeInsets.only(top: 10.0),
                  padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                  decoration: myBoxDecoration(),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/icons/transaction_history.svg'),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: VerticalDivider(
                          color: AppColors.primary,
                          thickness: 1,
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: Text(
                          'Transaction History',
                          style: TextStyle(color: AppColors.secondary),
                        ),
                      ),
                      SvgPicture.asset('assets/icons/right.svg',width: 10.0),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   PageTransition(
                  //     type: PageTransitionType.rightToLeftWithFade,
                  //     alignment: Alignment.topCenter,
                  //     duration: const Duration(milliseconds: 1000),
                  //     isIos: true,
                  //     child: const Login(),
                  //   ),
                  // );
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Container(
                  height: 58.0,
                  margin: const EdgeInsets.only(top: 10.0),
                  padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                  decoration: myBoxDecoration(),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/icons/payment_method.svg'),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: VerticalDivider(
                          color: AppColors.primary,
                          thickness: 1,
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: Text(
                          'Payment Method',
                          style: TextStyle(color: AppColors.secondary),
                        ),
                      ),
                      SvgPicture.asset('assets/icons/right.svg',width: 10.0),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   PageTransition(
                  //     type: PageTransitionType.rightToLeftWithFade,
                  //     alignment: Alignment.topCenter,
                  //     duration: const Duration(milliseconds: 1000),
                  //     isIos: true,
                  //     child: const NotificationScreen(),
                  //   ),
                  // );
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Container(
                  height: 58.0,
                  margin: const EdgeInsets.only(top: 10.0),
                  padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                  decoration: myBoxDecoration(),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/icons/notification3.svg'),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: VerticalDivider(
                          color: AppColors.primary,
                          thickness: 1,
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: Text(
                          'Notification',
                          style: TextStyle(color: AppColors.secondary),
                        ),
                      ),
                      SvgPicture.asset('assets/icons/right.svg',width: 10.0),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   PageTransition(
                  //     type: PageTransitionType.rightToLeftWithFade,
                  //     alignment: Alignment.topCenter,
                  //     duration: const Duration(milliseconds: 1000),
                  //     isIos: true,
                  //     child: const Login(),
                  //   ),
                  // );
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Container(
                  height: 58.0,
                  margin: const EdgeInsets.only(top: 10.0),
                  padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                  decoration: myBoxDecoration(),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/icons/refer_a_friend.svg'),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: VerticalDivider(
                          color: AppColors.primary,
                          thickness: 1,
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: Text(
                          'Refer a friend',
                          style: TextStyle(color: AppColors.secondary),
                        ),
                      ),
                      SvgPicture.asset('assets/icons/right.svg',width: 10.0),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   PageTransition(
                  //     type: PageTransitionType.rightToLeftWithFade,
                  //     alignment: Alignment.topCenter,
                  //     duration: const Duration(milliseconds: 1000),
                  //     isIos: true,
                  //     child: const HelpAndSupport(),
                  //   ),
                  // );
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Container(
                  height: 58.0,
                  margin: const EdgeInsets.only(top: 10.0),
                  padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                  decoration: myBoxDecoration(),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/icons/help_and_support.svg'),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: VerticalDivider(
                          color: AppColors.primary,
                          thickness: 1,
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: Text(
                          'Help and Support',
                          style: TextStyle(color: AppColors.secondary),
                        ),
                      ),
                      SvgPicture.asset('assets/icons/right.svg',width: 10.0),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   PageTransition(
                  //     type: PageTransitionType.rightToLeftWithFade,
                  //     alignment: Alignment.topCenter,
                  //     duration: const Duration(milliseconds: 1000),
                  //     isIos: true,
                  //     child: const PrivacyPolicy(),
                  //   ),
                  // );
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Container(
                  height: 58.0,
                  margin: const EdgeInsets.only(top: 10.0),
                  padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                  decoration: myBoxDecoration(),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/icons/privacy_policy.svg'),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: VerticalDivider(
                          color: AppColors.primary,
                          thickness: 1,
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: Text(
                          'Privacy Policy',
                          style: TextStyle(color: AppColors.secondary),
                        ),
                      ),
                      SvgPicture.asset('assets/icons/right.svg',width: 10.0),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   PageTransition(
                  //     type: PageTransitionType.rightToLeftWithFade,
                  //     alignment: Alignment.topCenter,
                  //     duration: const Duration(milliseconds: 1000),
                  //     isIos: true,
                  //     child: const TermAndCondition(),
                  //   ),
                  // );
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Container(
                  height: 58.0,
                  margin: const EdgeInsets.only(top: 10.0),
                  padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                  decoration: myBoxDecoration(),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/icons/term_and_condition.svg'),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: VerticalDivider(
                          color: AppColors.primary,
                          thickness: 1,
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: Text(
                          'Terms & Condition',
                          style: TextStyle(color: AppColors.secondary),
                        ),
                      ),
                      SvgPicture.asset('assets/icons/right.svg',width: 10.0),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  dialogueBox(context);
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Container(
                  height: 58.0,
                  margin: const EdgeInsets.only(top: 10.0),
                  padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                  decoration: myBoxDecoration(),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/icons/logout.svg'),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: VerticalDivider(
                          color: AppColors.primary,
                          thickness: 1,
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: Text(
                          'Logout',
                          style: TextStyle(color: AppColors.secondary),
                        ),
                      ),
                      SvgPicture.asset('assets/icons/right.svg',width: 10.0),
                    ],
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
  myBoxDecoration(){
    return const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Color(0xFFe6e6e6),
          offset: Offset(
            0.0,
            0.0,
          ),
          blurRadius: 8.0,
          spreadRadius: 0,
        ),
      ],
    );
  }
  void dialogueBox(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(13.0)),
          ),
          insetPadding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.1),
          backgroundColor: AppColors.white,
          title: Column(
            children: [
              const Text('?',style: TextStyle(color: AppColors.primary,fontSize: 50.0),),
              const Text(
                'Are you sure do you want to exit',
                style: TextStyle(color: AppColors.secondary,fontSize: 14.0),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 42.0,
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        decoration: const BoxDecoration(
                          color: AppColors.red,
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        child: const Text(
                          'No',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 13.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.05),
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
                        height: 42.0,
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        child: const Text(
                          'Yes',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 13.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
class Transactions{
  String? name;
  String? image;
  String? money;
  String? type;
  Transactions({required this.name,required this.image,required this.money,required this.type});
}
