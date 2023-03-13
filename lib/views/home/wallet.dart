import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gas_station_merchant/views/home/dashboard.dart';
import 'package:gas_station_merchant/views/utilities/utilities.dart';
import 'package:page_transition/page_transition.dart';
class Wallet extends StatefulWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  TextEditingController amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEE7F6),
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primary,
        title: const Text('My Wallet',style: TextStyle(fontSize: 18.0,)),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0,),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: const Text(
                      'Quick Stop Station',
                      style: TextStyle(color: AppColors.black,fontSize: 16.0),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: const Text(
                        '\$2000',
                        style: TextStyle(color: AppColors.primary,fontSize: 20.0,fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Divider(
                    color: AppColors.secondary,
                    thickness: 0.3,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    padding: const EdgeInsets.only(top: 10.0),
                    child: const Text(
                      'Topup Wallet',
                      style: TextStyle(color: AppColors.black,fontSize: 16.0),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primary, width: 1.0),
                      borderRadius: BorderRadius.circular(5.0),
                      // color: const Color(0xFFEAEAEA),
                      // color: Colors.red,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            controller: amountController,
                            style: const TextStyle(fontSize: 14.0, color: AppColors.black),
                            cursorColor: AppColors.primary,
                            decoration: myInputDecoration('Enter Amount'),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: const Text(
                      'Recommended',
                      style: TextStyle(color: AppColors.black,)
                    ),
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 10.0),
                      InkWell(
                        onTap: () {
                          amountController.text = 1000.toString();
                          setState(() {});
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 0.0),
                          margin: const EdgeInsets.only(right: 10.0),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: const BorderRadius.all(Radius.circular(19.0)),
                            border: Border.all(width: 1,color: AppColors.primary),
                          ),
                          child: Container(
                            margin: const EdgeInsets.only(right: 5.0),
                            child: const Text(
                              '\$1000',
                              style: TextStyle(color: AppColors.primary),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          amountController.text = 2000.toString();
                          setState(() {});
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 0.0),
                          margin: const EdgeInsets.only(right: 10.0),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: const BorderRadius.all(Radius.circular(19.0)),
                            border: Border.all(width: 1,color: AppColors.primary),
                          ),
                          child: Container(
                            margin: const EdgeInsets.only(right: 5.0),
                            child: const Text(
                              '\$2000',
                              style: TextStyle(color: AppColors.primary),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          amountController.text = 5000.toString();
                          setState(() {});
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 0.0),
                          margin: const EdgeInsets.only(right: 10.0),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: const BorderRadius.all(Radius.circular(19.0)),
                            border: Border.all(width: 1,color: AppColors.primary),
                          ),
                          child: Container(
                            margin: const EdgeInsets.only(right: 5.0),
                            child: const Text(
                              '\$5000',
                              style: TextStyle(color: AppColors.primary),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  InkWell(
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
                      //   (route) => false,
                      // );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50.0,
                      margin: const EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 0.0),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.all(Radius.circular(19.0)),
                      ),
                      child: const Text(
                        'PROCEED TO TOPUP',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
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
                    child: Dashboard(bottomIndex: 2),
                  ),
                );
              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16.0,),
                margin: const EdgeInsets.only(top: 20.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 10.0),
                    SvgPicture.asset('assets/icons/transaction2.svg'),
                    const SizedBox(width: 10.0),
                    const Expanded(
                      flex: 1,
                      child: Text(
                        'Wallet Transaction History',
                        style: TextStyle(color: AppColors.black,fontSize: 16.0),
                      ),
                    ),
                    SvgPicture.asset('assets/icons/right.svg',width: 12.0),
                    const SizedBox(width: 10.0),
                  ],
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
