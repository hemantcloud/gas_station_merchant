// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gas_station_merchant/models/logout_model.dart';
import 'package:gas_station_merchant/models/profile_model.dart';
import 'package:gas_station_merchant/views/authentication/login.dart';
import 'package:gas_station_merchant/views/home/discount.dart';
import 'package:gas_station_merchant/views/home/help_and_support.dart';
import 'package:gas_station_merchant/views/home/my_reviews.dart';
import 'package:gas_station_merchant/views/home/notification.dart';
import 'package:gas_station_merchant/views/home/privacy_policy.dart';
import 'package:gas_station_merchant/views/home/terms_and_conditions.dart';
import 'package:gas_station_merchant/views/home/transaction.dart';
import 'package:gas_station_merchant/views/home/update_profile.dart';
import 'package:gas_station_merchant/views/utilities/loader.dart';
import 'package:gas_station_merchant/views/utilities/urls.dart';
import 'package:gas_station_merchant/views/utilities/utilities.dart';
import 'package:page_transition/page_transition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:share_plus/share_plus.dart';
// apis
import 'dart:async';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/gestures.dart';
// apis

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final ImagePicker imagePicker = ImagePicker();
  XFile? photoController;
  XFile? imageFile;
  var bytes;
  late String authToken;
  late String userId;
  Data? userData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    all_process();
  }
  Future<void> all_process() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      authToken = prefs.getString('authToken')!;
      userId = prefs.getString('userId')!;
      print('my auth token is >>>>> {$authToken}');
      print('my user id is >>>>> {$userId}');
    });
    profileApi(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: AppColors.primary,
          title: const Text('Settings',style: TextStyle(fontSize: 18.0,)),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 10.0),
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      child: Stack(
                        children: [
                          /*photoController == null ?
                          Image.asset(
                            'assets/images/profile.png',
                            fit: BoxFit.cover,
                          ) :
                          ClipRRect(
                            borderRadius: BorderRadius.circular(60.0),
                            child: Image.file(
                              File(photoController!.path),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: InkWell(
                              onTap: () {
                                bottomsProfileImage(context);
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: SvgPicture.asset(
                                  'assets/icons/camera.svg',
                                  height: 15.0,
                                  width: 15.0,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),*/
                          userData == null || userData!.profileImage!.isEmpty ?
                          ClipRRect(
                            borderRadius: BorderRadius.circular(60.0),
                            child: Image.asset(
                              'assets/images/profile_default.png',
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              fit: BoxFit.cover,
                            ),
                          ) :
                          ClipRRect(
                            borderRadius: BorderRadius.circular(60.0),
                            child: Image.network(
                              userData!.profileImage.toString(),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: InkWell(
                              onTap: () {
                                bottomsProfileImage(context);
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: SvgPicture.asset(
                                  'assets/icons/camera.svg',
                                  height: 15.0,
                                  width: 15.0,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      userData == null ? '' :userData!.fullName.toString(),
                      style: const TextStyle(color: AppColors.black,fontSize: 16.0,fontWeight: FontWeight.w600),
                    ),
                    Text(
                      userData == null ? '' :userData!.email.toString(),
                      style: const TextStyle(color: AppColors.secondary,),
                    ),
                    const SizedBox(height: 5.0),
                    userData == null ? Container() :
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        userData!.avgRating == "0.00" ?
                        Container() :
                        SvgPicture.asset('assets/icons/star.svg'),
                        userData!.avgRating == "0.00" ?
                        Container() :
                        const SizedBox(width:5.0),
                        Text(
                          userData!.avgRating == "0.00" ? "No ratings yet" : userData!.avgRating!,
                          style: const TextStyle(color: AppColors.secondary,fontSize: 12.0),
                        ),
                        const SizedBox(width: 5.0),
                        SvgPicture.asset('assets/icons/right.svg',width: 6.0),
                      ],
                    ),
                  ],
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
                      child: UpdateProfile(userData: userData!),
                    ),
                  ).then((value) {
                    profileApi(context);
                  });
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
                      child: const Discount(),
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
                      SvgPicture.asset('assets/icons/discount.svg'),
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
                          'Discount',
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
                      child: const Transaction(),
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
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      alignment: Alignment.topCenter,
                      duration: const Duration(milliseconds: 1000),
                      isIos: true,
                      child: const NotificationScreen(),
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
                  _share();
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
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      alignment: Alignment.topCenter,
                      duration: const Duration(milliseconds: 1000),
                      isIos: true,
                      child: const MyReviews(),
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
                          'My Reviews',
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
                      child: const HelpAndSupport(),
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
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      alignment: Alignment.topCenter,
                      duration: const Duration(milliseconds: 1000),
                      isIos: true,
                      child: const PrivacyPolicy(),
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
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      alignment: Alignment.topCenter,
                      duration: const Duration(milliseconds: 1000),
                      isIos: true,
                      child: const TermAndCondition(),
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
          insetPadding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
          backgroundColor: AppColors.white,
          title: Column(
            children: [
              // const Text('?',style: TextStyle(color: AppColors.primary,fontSize: 50.0),),
              // SvgPicture.asset("assets/icons/alert2.svg",width: 100.0,color: AppColors.primary,),
              SvgPicture.asset('assets/icons/logout.svg',height: 60,),
              const SizedBox(height: 20.0),
              const Text(
                'Are you sure\ndo you want to exit',
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
                        logoutApi(context);
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
  /// Image pick Bottom dialog.............
  bottomsProfileImage(BuildContext context){
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Wrap(children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () {
                //Navigator.pop(context);
                pickImage(context,ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_album),
              title: const Text('Gallery'),
              onTap: () {
                // Navigator.pop(context);
                pickImage(context,ImageSource.gallery);
              },
            ),
          ]);
        });
  }
  ///Image picker...............
  Future pickImage(BuildContext context,imageSource) async {
    Navigator.pop(context);
    if(!kIsWeb){
      var image = await imagePicker.pickImage(
        source: imageSource,
        imageQuality: 10,
      );
      if (image == null) {
        print('+++++++++null');
      } else {
        photoController = XFile(image.path);
        print("photoController!.path is ----------${photoController!.path}");
        updateProfileApi(context);
        // _cropImage(File(photoController!.path));
      }
      setState((){});
    }else if(kIsWeb){
      var image = await imagePicker.pickImage(source: imageSource,
          imageQuality: 10);
      if (image == null) {
        print('+++++++++null');
      } else {
        photoController = XFile(image.path);
        print("photoController!.path is ----------${photoController!.path}");
        updateProfileApi(context);
        // _cropImage(File(photoController!.path));
      }
      setState((){});
      print('image path is ${bytes}');
    }
  }
  void _share() {
    Share.share('check out my website https://example.com', subject: 'Look what I made!');
  }
  // logoutApi
  Future<void> logoutApi(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Loader.ProgressloadingDialog(context, true);
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    var response = await http.get(Uri.parse(Urls.logout),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
          "X-AUTHTOKEN" : authToken,
          "X-USERID" : userId,
        });
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    Loader.ProgressloadingDialog(context, false);
    LogoutModel res = await LogoutModel.fromJson(jsonResponse);
    if(res.status == true){
      prefs.setBool('isLogin',false);
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
      Utilities().toast(res.message);
      setState(() {});
    }else{
      Utilities().toast(res.message);
      setState(() {});
    }
    return;
  }
  // logoutApi
  // profileApi api
  Future<void> profileApi(BuildContext context) async {
    Loader.ProgressloadingDialog(context, true);
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    var response = await http.get(Uri.parse(Urls.profile),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "X-AUTHTOKEN" : authToken,
          "X-USERID" : userId,
        });
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    Loader.ProgressloadingDialog(context, false);
    ProfileModel res = await ProfileModel.fromJson(jsonResponse);
    if (res.status == true) {
      userData = res.data;
      setState(() {});
    } else {
      Utilities().toast(res.message.toString());
      setState(() {});
    }
    return;
  }
  // profileApi api
  // profileApi api
  Future<void> profileApi2(BuildContext context) async {
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    var response = await http.get(Uri.parse(Urls.profile),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "X-AUTHTOKEN" : authToken,
          "X-USERID" : userId,
        });
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    ProfileModel res = await ProfileModel.fromJson(jsonResponse);
    if (res.status == true) {
      userData = res.data;
      setState(() {});
    } else {
      Utilities().toast(res.message.toString());
      setState(() {});
    }
    return;
  }
  // profileApi api
  // updateProfileApi
  Future<void> updateProfileApi(BuildContext context) async {
    // Loader.ProgressloadingDialog(context, true);
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(Urls.updateProfileImage),
      );
      Map<String, String> header = {
        "content-type": "application/json",
        "accept": "application/json",
        "X-AUTHTOKEN" : authToken,
        "X-USERID" : userId,
      };
      request.headers.addAll(header);
      if (photoController == null || photoController == "") {
      }else {
        request.files.add(await http.MultipartFile.fromPath('profileImage', photoController!.path));
      }
      var response = await request.send();
      // Loader.ProgressloadingDialog(context, false);

      print("response is----------${response.headers.toString()}");
      response.stream.transform(convert.utf8.decoder).listen((event) {
        Map map = convert.jsonDecode(event);

        print("map is -------------------$map");
        if (map["status"] == true) {
          Utilities().toast(map["message"]);
          profileApi2(context);
          // setState(() {});
          /// SUCCESS
        } else {
          Utilities().toast(map["message"]);
          // Navigator.of(context).pop();
          /// FAIL
        }
      });
    } catch (e) {
      ///EXCEPTION
      Loader.ProgressloadingDialog(context, false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('error: $e')),
      );
    }
  }
  // updateProfileApi
}