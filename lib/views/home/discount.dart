import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gas_station_merchant/models/delete_discount_model.dart';
import 'package:gas_station_merchant/models/discount_list_model.dart';
import 'package:gas_station_merchant/views/utilities/loader.dart';
import 'package:gas_station_merchant/views/utilities/urls.dart';
import 'package:gas_station_merchant/views/utilities/utilities.dart';
import 'package:internet_popup/internet_popup.dart';
// apis
import 'dart:async';
import 'dart:convert' as convert;
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
// apis
class Discount extends StatefulWidget {
  const Discount({Key? key}) : super(key: key);

  @override
  State<Discount> createState() => _DiscountState();
}

class _DiscountState extends State<Discount> {
  bool isConnected = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController desController = TextEditingController();
  List<DiscountListData> discountList = [];
  late String authToken;
  late String userId;
  int currentIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, (){
      allProcess();
    });
  }
  Future<void> allProcess() async {
    InternetPopup().initialize(context: context);
    isConnected = await InternetPopup().checkInternet();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      authToken = prefs.getString('authToken')!;
      userId = prefs.getString('userId')!;
      print('my auth token is >>>>> {$authToken}');
      print('my user id is >>>>> {$userId}');
    });
    if(isConnected) {
      discountApi(context, true);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        // backgroundColor: Colors.white,
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
          title: const Text('Discount',style: TextStyle(fontSize: 18.0,)),
          elevation: 0.0,
        ),
        body: discountList.isEmpty ? const Center(child: Text("No data found.")) : SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 10.0),
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: discountList.length,
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
                      currentIndex = index;
                      setState(() {});
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Container(
                      padding: const EdgeInsets.all(15.0),
                      margin: const EdgeInsets.only(bottom: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.0),
                        color: Colors.white,
                        border: currentIndex == index ?
                        Border.all(
                          width: 1.0,
                          color: AppColors.primary,
                          style: BorderStyle.solid,
                        ) :
                        Border.all(
                          width: 1.0,
                          color: Colors.transparent,
                          style: BorderStyle.solid,
                        ),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  discountList[index].title.toString(),
                                  style: const TextStyle(
                                      fontSize: 16.0,
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                              ),
                            //  currentIndex == index ?
                              Visibility(
                                  visible: currentIndex == index ? true : false,
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 10.0),
                                      InkWell(
                                        onTap:() {
                                          titleController.text = discountList[index].title!;
                                          desController.text = discountList[index].description!;
                                          editDiscountAlert(context, discountList[index].id!,discountList[index].title.toString(),discountList[index].description.toString());
                                          setState(() {});
                                        },
                                        // child: const Icon(Icons.edit),
                                        child: SvgPicture.asset("assets/icons/edit.svg",color: Colors.green,),
                                      ),
                                      const SizedBox(width: 10.0),
                                      InkWell(
                                        onTap:() {
                                          deleteConfirm(context,discountList[index].id!);
                                        },
                                        // child: const Icon(Icons.delete_rounded),
                                        child: SvgPicture.asset("assets/icons/delete.svg",color: AppColors.red,),
                                      ),
                                    ],
                                  )),
                                  //:
                              // Container(),
                              // currentIndex == index ?
                              // const Icon(Icons.edit) :
                              // Container(),
                              // currentIndex == index ?
                              // const SizedBox(width: 10.0) :
                              // Container(),
                              // currentIndex == index ?
                              // const Icon(Icons.delete_rounded) :
                              // Container(),
                            ],
                          ),
                          Text(
                            discountList[index].description.toString(),
                            style: const TextStyle(color: AppColors.secondary),
                            overflow: TextOverflow.clip,
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
        floatingActionButton: FloatingActionButton(
          onPressed: ()=> addDiscountAlert(context),
          backgroundColor: AppColors.primary,
          tooltip: 'Add new discount',
          child: const Icon(Icons.add,color: Colors.white,size: 30.0),
        ), //
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
  Future addDiscountAlert(BuildContext context) {
    titleController.clear();
    desController.clear();
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        title: const Center(child: Text('Add Discount')),
        titleTextStyle: const TextStyle(color: Color(0xFF41405D),fontSize: 18.0,fontWeight: FontWeight.w600,fontFamily: 'Poppins'),
        // insetPadding: EdgeInsets.symmetric(horizontal: 10.0,vertical: MediaQuery.of(context).size.height * 0.29),
        content: Container(
          height: 250.0,
          width: MediaQuery.of(context).size.width,
          // padding: EdgeInsets.symmetric(vertical: 10.0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            border: Border.all(color: Colors.white),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 10.0),
                margin: const EdgeInsets.only(bottom: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  border: Border.all(color: const Color(0xFF606060),width: 1,style: BorderStyle.solid),
                ),
                child: TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "Enter Title",
                    hintStyle: TextStyle(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.w600,
                        fontSize: 15.0,
                        fontFamily: 'Poppins'
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 10.0),
                margin: const EdgeInsets.only(bottom: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  border: Border.all(color: const Color(0xFF606060),width: 1,style: BorderStyle.solid),
                ),
                child: TextFormField(
                  controller: desController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "Description",
                    hintStyle: TextStyle(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.w600,
                        fontSize: 15.0,
                        fontFamily: 'Poppins'
                    ),
                  ),
                ),
              ),
              /*Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        String title = titleController.text;
                        String des = desController.text;
                        if(title.isEmpty){
                          Utilities().toast("Please enter title.");
                        }else if(des.isEmpty){
                          Utilities().toast("Please enter title.");
                        }else {
                          addDiscountApi(context);
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50.0,
                        margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.03),
                        // padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.all(Radius.circular(19.0)),
                        ),
                        child: const Text(
                          'Add',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),*/
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        titleController.clear();
                        desController.clear();
                        Navigator.of(context).pop();
                        setState(() {

                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50.0,
                        // margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.03),
                        // padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        decoration: const BoxDecoration(
                          color: AppColors.red,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: const Text(
                          'Back',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        String title = titleController.text;
                        String des = desController.text;
                        if(title.isEmpty){
                          Utilities().toast("Please enter title.");
                        }else if(des.isEmpty){
                          Utilities().toast("Please enter title.");
                        }else {
                          addDiscountApi(context);
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50.0,
                        // margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.03),
                        // padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: const Text(
                          'Add',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future editDiscountAlert(BuildContext context, int id, String title, String des) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        title: const Center(child: Text('Add Discount')),
        titleTextStyle: const TextStyle(color: Color(0xFF41405D),fontSize: 18.0,fontWeight: FontWeight.w600,fontFamily: 'Poppins'),
        // insetPadding: EdgeInsets.symmetric(horizontal: 10.0,vertical: MediaQuery.of(context).size.height * 0.29),
        content: Container(
          height: 250.0,
          width: MediaQuery.of(context).size.width,
          // padding: EdgeInsets.symmetric(vertical: 10.0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            border: Border.all(color: Colors.white),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 10.0),
                margin: const EdgeInsets.only(bottom: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  border: Border.all(color: const Color(0xFF606060),width: 1,style: BorderStyle.solid),
                ),
                child: TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "Enter Title",
                    hintStyle: TextStyle(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.w600,
                        fontSize: 15.0,
                        fontFamily: 'Poppins'
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 10.0),
                margin: const EdgeInsets.only(bottom: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  border: Border.all(color: const Color(0xFF606060),width: 1,style: BorderStyle.solid),
                ),
                child: TextFormField(
                  controller: desController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "Description",
                    hintStyle: TextStyle(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.w600,
                        fontSize: 15.0,
                        fontFamily: 'Poppins'
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        titleController.clear();
                        desController.clear();
                        Navigator.of(context).pop();
                        setState(() {

                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50.0,
                        // margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.03),
                        // padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        decoration: const BoxDecoration(
                          color: AppColors.red,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: const Text(
                          'Back',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        String title = titleController.text;
                        String des = desController.text;
                        if(title.isEmpty){
                          Utilities().toast("Please enter title.");
                        }else if(des.isEmpty){
                          Utilities().toast("Please enter title.");
                        }else {
                          // addDiscountApi(context);
                          editDiscountApi(context, id, title, des);
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50.0,
                        // margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.03),
                        // padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: const Text(
                          'Update',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  // addDiscountApi
  Future<void> addDiscountApi(BuildContext context) async {
    Loader.progressLoadingDialog(context, true);
    var request = {};
    request['title'] = titleController.text;
    request['description'] = desController.text;
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    var response = await http.post(Uri.parse(Urls.addDiscount),
        body: convert.jsonEncode(request),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "X-AUTHTOKEN" : authToken,
          "X-USERID" : userId,
        });
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    Loader.progressLoadingDialog(context, false);
    DiscountListModel res = await DiscountListModel.fromJson(jsonResponse);
    Navigator.of(context).pop();
    if (res.status == true) {
      titleController.clear();
      desController.clear();
      Utilities().toast(res.message.toString());
      Future.delayed(Duration.zero, (){
        discountApi(context, false);
      });
      setState(() {});
    } else {
      Utilities().toast(res.message.toString());
      setState(() {});
    }
    return;
  }
  // addDiscountApi
  // discountApi
  Future<void> discountApi(BuildContext context, bool isLoad) async {
    if(isLoad) {
      Loader.progressLoadingDialog(context, true);
    }
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    var response = await http.post(Uri.parse(Urls.discountList),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "X-AUTHTOKEN" : authToken,
          "X-USERID" : userId,
        });
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    if(isLoad) {
      Loader.progressLoadingDialog(context, false);
    }
    DiscountListModel res = await DiscountListModel.fromJson(jsonResponse);
    if (res.status == true) {
      discountList.clear();
      discountList = res.data!;
      setState(() {});
    } else {
      Utilities().toast(res.message.toString());
      if(res.message == "No Data found."){
        discountList.clear();
      }
      setState(() {});
    }
    return;
  }
  // discountApi
  // deleteDiscountApi
  Future<void> deleteDiscountApi(BuildContext context,int discountId) async {
    Loader.progressLoadingDialog(context, true);
    var request = {};
    request['discountId'] = discountId;
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    var response = await http.post(Uri.parse(Urls.deleteDiscount),
        body: convert.jsonEncode(request),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "X-AUTHTOKEN" : authToken,
          "X-USERID" : userId,
        });
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    Loader.progressLoadingDialog(context, false);
    DeleteDiscountModel res = await DeleteDiscountModel.fromJson(jsonResponse);
    Navigator.of(context).pop();
    if (res.status == true) {
      Utilities().toast(res.message.toString());
      Future.delayed(Duration.zero, (){
        discountApi(context, false);
      });
      setState(() {});
    } else {
      Utilities().toast(res.message.toString());
      setState(() {});
    }
    return;
  }
  // deleteDiscountApi
  // editDiscountApi
  Future<void> editDiscountApi(BuildContext context,int discountId, String title, String description) async {
    Loader.progressLoadingDialog(context, true);
    var request = {};
    request['discountId'] = discountId;
    request['title'] = title;
    request['description'] = description;
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    var response = await http.post(Uri.parse(Urls.editDiscount),
        body: convert.jsonEncode(request),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "X-AUTHTOKEN" : authToken,
          "X-USERID" : userId,
        });
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    Loader.progressLoadingDialog(context, false);
    DeleteDiscountModel res = await DeleteDiscountModel.fromJson(jsonResponse);
    Navigator.of(context).pop();
    if (res.status == true) {
      titleController.clear();
      desController.clear();
      Utilities().toast(res.message.toString());
      Future.delayed(Duration.zero, (){
        discountApi(context, false);
      });
      setState(() {});
    } else {
      Utilities().toast(res.message.toString());
      setState(() {});
    }
    return;
  }
  // editDiscountApi
  void deleteConfirm(BuildContext context,int discountId) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(13.0)),
          ),
          insetPadding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
          backgroundColor: AppColors.white,
          title: Column(
            children: [
              // const Text('?',style: TextStyle(color: AppColors.primary,fontSize: 50.0),),
              // SvgPicture.asset("assets/icons/alert2.svg",width: 100.0,color: AppColors.primary,),
              SvgPicture.asset('assets/icons/delete.svg',height: 60,color: Colors.red,),
              const SizedBox(height: 10.0),
              const Text(
                'Are you sure\ndo you want to Delete?',
                style: TextStyle(color: AppColors.secondary,fontSize: 14.0),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50.0,
                        // margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.03),
                        // padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        decoration: const BoxDecoration(
                          color: AppColors.red,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: const Text(
                          'No',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        deleteDiscountApi(context,discountId);
                        setState(() {});
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50.0,
                        // margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.03),
                        // padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: const Text(
                          'Yes',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0,
                          ),
                          textAlign: TextAlign.center,
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