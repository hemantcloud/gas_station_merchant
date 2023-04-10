import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gas_station_merchant/models/wallet_model.dart';
import 'package:gas_station_merchant/views/home/dashboard.dart';
import 'package:gas_station_merchant/views/utilities/loader.dart';
import 'package:gas_station_merchant/views/utilities/urls.dart';
import 'package:gas_station_merchant/views/utilities/utilities.dart';
import 'package:page_transition/page_transition.dart';


// apis
import 'dart:async';
import 'dart:convert' as convert;
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
// apis

class Withdrawal extends StatefulWidget {
  const Withdrawal({Key? key}) : super(key: key);

  @override
  State<Withdrawal> createState() => _WithdrawalState();
}

class _WithdrawalState extends State<Withdrawal> {
  TextEditingController amountController = TextEditingController();
  late String authToken;
  late String userId;
  String? walletBalance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero,(){
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
    // categoriesApi(context);
    walletApi(context);
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
          title: const Text('Withdrawal',style: TextStyle(fontSize: 18.0,)),
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
                        'Wallet Balance',
                        style: TextStyle(color: AppColors.black,fontSize: 16.0),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        '\$${walletBalance == null ? "0" : walletBalance}',
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
                        'Amount',
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
                    InkWell(
                      onTap: () {
                        String amt = amountController.text;
                        print(amt);
                        print(amt.runtimeType);
                        if(amt.isEmpty) {
                          Utilities().toast("Payment must be at least \$1.");
                        }else if(int.parse(amt.toString()) < 1){
                          Utilities().toast("Payment must be at least \$1.");
                        }else {
                          withdrawalApi(context, amt);
                        }
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
                          'Withdrawal',
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
  // walletApi api
  Future<void> walletApi(BuildContext context) async {
    Loader.progressLoadingDialog(context, true);
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    var response = await http.post(Uri.parse(Urls.myWallet),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "X-AUTHTOKEN" : authToken,
          "X-USERID" : userId,
        });
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    Loader.progressLoadingDialog(context, false);
    WalletModel res = await WalletModel.fromJson(jsonResponse);
    if (res.status == true) {
      if(res.data!.walletbalance == null){
        walletBalance = "0";
      }else {
        walletBalance = res.data!.walletbalance!.balance;
      }
      setState(() {});
    } else {
      Utilities().toast(res.message.toString());
      setState(() {});
    }
    return;
  }
  // walletApi api
  // walletApi api
  Future<void> withdrawalApi(BuildContext context, String amt) async {
    Loader.progressLoadingDialog(context, true);
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    var request = {};
    request['withdrawal_amount'] = amountController.text;
    var response = await http.post(Uri.parse(Urls.withdrawal),
        body: convert.jsonEncode(request),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "X-AUTHTOKEN" : authToken,
          "X-USERID" : userId,
        });
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    Loader.progressLoadingDialog(context, false);
    WalletModel res = await WalletModel.fromJson(jsonResponse);
    if (res.status == true) {
      Utilities().toast(res.message.toString());
      Navigator.of(context).pop();
      setState(() {});
    } else {
      Utilities().toast(res.message.toString());
      setState(() {});
    }
    return;
  }
  // walletApi api
}
