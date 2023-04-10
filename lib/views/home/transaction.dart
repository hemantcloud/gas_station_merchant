import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gas_station_merchant/models/wallet_model.dart';
import 'package:gas_station_merchant/views/utilities/loader.dart';
import 'package:gas_station_merchant/views/utilities/urls.dart';
import 'package:gas_station_merchant/views/utilities/utilities.dart';

// apis
import 'dart:async';
import 'dart:convert' as convert;
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
// apis

class Transaction extends StatefulWidget {
  const Transaction({Key? key}) : super(key: key);

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
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
    walletApi(context, "");
  }
  List<TransactionHistory>? transactionList = [];
  String selected = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFEEE7F6),
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
          title: const Text('Transaction History',style: TextStyle(fontSize: 18.0,)),
          actions: [
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
              child: Row(
                children: [
                  const SizedBox(width: 16.0),
                  PopupMenuButton(
                    elevation: 0.0,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0))
                    ),
                    icon: SvgPicture.asset('assets/icons/funnel.svg',color: Colors.white),
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem<String>(
                          value: 'All',
                          child: InkWell(
                            onTap: (){
                              selected = "Daily";
                              Navigator.pop(context);
                              walletApi(context, "Daily");
                              setState(() {});
                            },
                            child: Row(
                              children: [
                                selected == 'Daily' ?
                                SvgPicture.asset('assets/icons/selected_circle.svg') :
                                SvgPicture.asset('assets/icons/unselected_circle.svg'),
                                const SizedBox(width: 5.0),
                                const Text('Daily'),
                              ],
                            ),
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'All',
                          child: InkWell(
                            onTap: (){
                              selected = "Monthly";
                              Navigator.pop(context);
                              walletApi(context, "Monthly");
                              setState(() {});
                            },
                            child: Row(
                              children: [
                                selected == 'Monthly' ?
                                SvgPicture.asset('assets/icons/selected_circle.svg') :
                                SvgPicture.asset('assets/icons/unselected_circle.svg'),
                                const SizedBox(width: 5.0),
                                const Text('Monthly'),
                              ],
                            ),
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'All',
                          child: InkWell(
                            onTap: (){
                              selected = "Quarterly";
                              Navigator.pop(context);
                              walletApi(context, "Quarterly");
                              setState(() {});
                            },
                            child: Row(
                              children: [
                                selected == 'Quarterly' ?
                                SvgPicture.asset('assets/icons/selected_circle.svg') :
                                SvgPicture.asset('assets/icons/unselected_circle.svg'),
                                const SizedBox(width: 5.0),
                                const Text('Quarterly'),
                              ],
                            ),
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'All',
                          child: InkWell(
                            onTap: (){
                              selected = "Yearly";
                              Navigator.pop(context);
                              walletApi(context, "Yearly");
                              setState(() {});
                            },
                            child: Row(
                              children: [
                                selected == 'Yearly' ?
                                SvgPicture.asset('assets/icons/selected_circle.svg') :
                                SvgPicture.asset('assets/icons/unselected_circle.svg'),
                                const SizedBox(width: 5.0),
                                const Text('Yearly'),
                              ],
                            ),
                          ),
                        ),
                      ];
                    },
                  ),
                  const SizedBox(width: 16.0),
                ],
              ),
            ),
          ],
          elevation: 0.0,
        ),
        body: transactionList!.isEmpty ? const Center(child: Text("Data not found"),) : SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 10.0),
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: transactionList!.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   PageTransition(
                      //     type: PageTransitionType.rightToLeftWithFade,
                      //     alignment: Alignment.topCenter,
                      //     duration: const Duration(milliseconds: 1000),
                      //     isIos: true,
                      //     child: const StationProfile(),
                      //   ),
                      // );
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      margin: const EdgeInsets.only(bottom: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.0),
                        color: Colors.white,
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
                                  style: TextStyle(color: AppColors.secondary,fontSize: 12.0),
                                ),
                                Text(
                                  "ID : ${transactionList![index].id}",
                                  style: TextStyle(color: AppColors.secondary,fontSize: 12.0),
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
                    ),
                  );
                },
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
  Future<void> walletApi(BuildContext context, String filter) async {
    Loader.ProgressloadingDialog(context, true);
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    var request = {};
    request['filter'] = filter;
    var response = await http.post(Uri.parse(Urls.myWallet),
        body: convert.jsonEncode(request),
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
      transactionList!.clear();
      transactionList = res.data!.transactionHistory;
      setState(() {});
    } else {
      Utilities().toast(res.message.toString());
      setState(() {});
    }
    return;
  }
  // walletApi api
}