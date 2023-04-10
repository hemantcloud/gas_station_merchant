import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gas_station_merchant/models/notification_model.dart';
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

class NotificationScreen extends StatefulWidget {
  String status;
  NotificationScreen({Key? key,required this.status}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<DataListOfNotification>? notificationList = [];
  late String authToken;
  late String userId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("widget.status is --------------------${widget.status}");
    Future.delayed(Duration.zero, (){
      allProcess();
    });
  }
  allProcess() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      authToken = prefs.getString('authToken')!;
      userId = prefs.getString('userId')!;
      print('my auth token is >>>>> {$authToken}');
      print('my user id is >>>>> {$userId}');
    });
    NotificationApi(context);
  }
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: WillPopScope(
        onWillPop: (){
          return onWillPopFunction();
        },
        child: Scaffold(
          // backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: AppColors.primary,
            leading: InkWell(
              onTap: () {
                if(widget.status == "notification"){
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
                }else {
                  Navigator.of(context).pop();
                }
              },
              child: Container(
                padding: const EdgeInsets.only(top: 15.0,bottom: 15.0),
                child: SvgPicture.asset('assets/icons/left.svg',color: Colors.white,),
              ),
            ),
            title: const Text('Notification',style: TextStyle(fontSize: 18.0,)),
            elevation: 0.0,
          ),
          body: notificationList!.isEmpty ? const Center(child: Text("No data found.")) : SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 10.0),
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: notificationList!.length,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset('assets/icons/bell2.svg',width: 60.0,),
                            const SizedBox(width: 10.0),
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    notificationList![index].title.toString(),
                                    style: const TextStyle(
                                        fontSize: 16.0,
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                  Text(
                                    notificationList![index].description.toString(),
                                    style: const TextStyle(color: AppColors.secondary),
                                    overflow: TextOverflow.clip,
                                    maxLines: 2,
                                  ),
                                ],
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
  onWillPopFunction(){
    if(widget.status == "notification"){
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
    }else {
      Navigator.of(context).pop();
    }
  }
  // NotificationApi
  Future<void> NotificationApi(BuildContext context) async {
    Loader.progressLoadingDialog(context, true);
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    var response = await http.post(Uri.parse(Urls.notification),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "X-AUTHTOKEN" : authToken,
          "X-USERID" : userId,
        });
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    Loader.progressLoadingDialog(context, false);
    NotificationModel res = await NotificationModel.fromJson(jsonResponse);
    if (res.status == true) {
      notificationList = res.data!;
      setState(() {});
    } else {
      Utilities().toast(res.message.toString());
      setState(() {});
    }
    return;
  }
// NotificationApi
}
