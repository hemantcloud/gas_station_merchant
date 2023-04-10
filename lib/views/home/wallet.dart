import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gas_station_merchant/models/wallet_model.dart';
import 'package:gas_station_merchant/views/home/transaction.dart';
import 'package:gas_station_merchant/views/home/withdrawal.dart';
import 'package:gas_station_merchant/views/utilities/loader.dart';
import 'package:gas_station_merchant/views/utilities/urls.dart';
import 'package:gas_station_merchant/views/utilities/utilities.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

// apis
import 'dart:async';
import 'dart:convert' as convert;
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
// apis

class Wallet extends StatefulWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  late String authToken;
  late String userId;
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
  List<TransactionHistory>? transactionList = [];
  // Data? walletData;
  String? totalEarning;
  String? walletBalance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFEEE7F6),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: AppColors.primary,
          title: const Text('My Wallet',style: TextStyle(fontSize: 18.0,)),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 10.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 40.0),
                      margin: const EdgeInsets.only(right: 5.0,top: 20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color(0xFFDFF1C4),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Wallet Amount ',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10.0,),
                          Text(
                            '\$${walletBalance == null ? '0' : walletBalance}',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: AppColors.gunpowder,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w900
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 40.0),
                      margin: const EdgeInsets.only(right: 5.0,top: 20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        // color: const Color(0xFFDFF1C4),
                        color: const Color(0xFFEFEFF7),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total Earnings',
                            // overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10.0,),
                          Text(
                            '\$${totalEarning == null ? '0' : totalEarning}',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: AppColors.gunpowder,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
                              fontSize: 16.0,
                              fontWeight: FontWeight.w900
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              InkWell(
                onTap: () {
                  if(walletBalance == "0"){
                    Utilities().toast("Don't have enough balance to withdrawal.");
                  }else {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeftWithFade,
                        alignment: Alignment.topCenter,
                        duration: const Duration(milliseconds: 1000),
                        isIos: true,
                        child: const Withdrawal(),
                      ),
                    ).then((value) {
                      walletApi(context);
                    });
                  }
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Container(
                  height: 55.0,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  ),
                  child: const Text(
                    'WITHDRAW NOW',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Recent Transactions',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: AppColors.gunpowder,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 20.0),
              transactionList!.isEmpty ?
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("No transactions found !")
              ) :
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: transactionList!.length > 9 ? 10 : transactionList!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: const EdgeInsets.all(10.0),
                    margin: const EdgeInsets.only(bottom: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14.0),
                      color: AppColors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0xFFe6e6e6),
                          offset: Offset(
                            0.0,
                            0.0,
                          ),
                          blurRadius: 4.0,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(transactionList![index].type == "Debit" ? "assets/icons/debit.svg" : "assets/icons/credit.svg",width: 50.0,),
                        const SizedBox(width: 10.0),
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                transactionList![index].title.toString(),
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w600
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              Text(
                                "${Utilities().DatefomatToDate(transactionList![index].createdAt!)} ${Utilities().DatefomatToMonth(transactionList![index].createdAt!)} ${Utilities().DatefomatToYear(transactionList![index].createdAt!)}",
                                style: const TextStyle(color: AppColors.secondary,fontSize: 12.0),
                              ),
                              Text(
                                "ID : ${transactionList![index].id}",
                                style: const TextStyle(color: AppColors.secondary,fontSize: 12.0),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Text(
                          transactionList![index].amount!,
                          style: TextStyle(
                            color: transactionList![index].type == 'Debit' ? AppColors.red : AppColors.green,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              transactionList!.isEmpty ? Container() :
              InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      alignment: Alignment.topCenter,
                      duration: const Duration(milliseconds: 1000),
                      isIos: true,
                      child: const Transaction(),
                    ),
                  );
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Container(
                  child: Column(
                    children: [
                      const SizedBox(height: 10.0),
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text("See more....")
                      ),
                      const SizedBox(height: 10.0),
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
  // walletApi api
  Future<void> walletApi(BuildContext context) async {
    Loader.ProgressloadingDialog(context, true);
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
    Loader.ProgressloadingDialog(context, false);
    WalletModel res = await WalletModel.fromJson(jsonResponse);
    if (res.status == true) {
      transactionList = res.data!.transactionHistory;
      totalEarning = res.data!.totalEarning;
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
}