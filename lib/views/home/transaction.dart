import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gas_station_merchant/views/utilities/utilities.dart';
import 'package:page_transition/page_transition.dart';
class Transaction extends StatefulWidget {
  const Transaction({Key? key}) : super(key: key);

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  TextEditingController amountController = TextEditingController();
  List<Transactions> transactionlist = [
    Transactions(name: 'Quick Stop Station',image: 'assets/icons/credit.svg',type: 'credit',money: '21200'),
    Transactions(name: 'Topup',image: 'assets/icons/debit.svg',type: 'debit',money: '20000'),
    Transactions(name: 'Quick Stop Station',image: 'assets/icons/credit.svg',type: 'credit',money: '21200'),
    Transactions(name: 'Topup',image: 'assets/icons/debit.svg',type: 'debit',money: '20000'),
    Transactions(name: 'Quick Stop Station',image: 'assets/icons/credit.svg',type: 'credit',money: '21200'),
    Transactions(name: 'Topup',image: 'assets/icons/debit.svg',type: 'debit',money: '20000'),
    Transactions(name: 'Topup',image: 'assets/icons/credit.svg',type: 'credit',money: '21200'),
    Transactions(name: 'Quick Stop Station',image: 'assets/icons/debit.svg',type: 'debit',money: '20000'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        backgroundColor: const Color(0xFFEEE7F6),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: AppColors.primary,
          title: const Text('Transaction',style: TextStyle(fontSize: 18.0,)),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 10.0),
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: transactionlist.length,
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
                        // border: Border.all(
                        //   width: 1.0,
                        //   color: AppColors.border,
                        //   style: BorderStyle.solid,
                        // ),
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
                          SvgPicture.asset(transactionlist[index].image.toString(),width: 50.0,),
                          const SizedBox(width: 10.0),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  transactionlist[index].name.toString(),
                                  style: const TextStyle(
                                      fontSize: 16.0,
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w600
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                const Text(
                                  "15 oct 2022",
                                  style: TextStyle(color: AppColors.secondary,fontSize: 12.0),
                                ),
                                const Text(
                                  "ID : 001625498",
                                  style: TextStyle(color: AppColors.secondary,fontSize: 12.0),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Text(
                            transactionlist[index].type == 'debit' ? '- \$${transactionlist[index].money.toString()}' : '+  \$${transactionlist[index].money.toString()}',
                            style: TextStyle(
                                color: transactionlist[index].type == 'debit' ? AppColors.green : AppColors.red,
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
}
class Transactions{
  String? name;
  String? image;
  String? money;
  String? type;
  Transactions({required this.name,required this.image,required this.money,required this.type});
}
