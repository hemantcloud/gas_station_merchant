import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gas_station_merchant/views/utilities/loader.dart';
import 'package:gas_station_merchant/views/utilities/urls.dart';
import 'package:gas_station_merchant/views/utilities/utilities.dart';
import 'package:gas_station_merchant/models/review_model.dart';
// apis
import 'dart:async';
import 'dart:convert' as convert;
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
// apis

class MyReviews extends StatefulWidget {
  const MyReviews({Key? key}) : super(key: key);

  @override
  State<MyReviews> createState() => _MyReviewsState();
}

class _MyReviewsState extends State<MyReviews> {
  ScrollController scrollController = ScrollController();
  bool isLoading = false;
  int page = 1;
  List<Ratings>? reviewList = [];
  late String authToken;
  late String userId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, (){
      allProcess();
    });
  }
  allProcess() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      authToken = prefs.getString('authToken').toString();
      userId = prefs.getString('userId').toString();
      print('my auth token is >>>>> {$authToken}');
      print('my user id is >>>>> {$userId}');
    });
    initApiCall();
    apiRefresh();
  }
  initApiCall(){
    reviewList!.clear();
    Future.delayed(Duration(seconds: 0),(){
      setState(()=> WidgetsBinding.instance.addPostFrameCallback((_) => reviewsApi(context)));
      //  Notificationapi(context);
    });
  }
  apiRefresh() async{
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        if (!isLoading) {
          // isLoading = !isLoading;
          page = page+1;
          isLoading = !isLoading;
          print("page>>>>>>>><<<<<<<${page}");

          setState(()=> WidgetsBinding.instance.addPostFrameCallback((_) => reviewsApi(context)));
        }
      }
    });
    // Future.delayed(const Duration(seconds: 0), () {
    //   notificationController.getNotificationApiCall(context);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
          title: const Text('My Reviews',style: TextStyle(fontSize: 18.0,)),
          elevation: 0.0,
        ),
        body: reviewList!.isEmpty ? const Center(child: Text("Data not found"),) : SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 10.0),
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: reviewList!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          reviewList![index].customerName.toString(),
                          style: const TextStyle(
                              fontSize: 16.0,
                              color: AppColors.black,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                        reviewList![index].starRating == "0.5" ?
                        Row(
                          children: [
                            Image.asset('assets/icons/half_star.png',width: 15.0),
                          ],
                        ) :
                        reviewList![index].starRating == "1" ?
                        Row(
                          children: [
                            Image.asset('assets/icons/star.png',width: 15.0),
                          ],
                        ) :
                        reviewList![index].starRating == "1.5" ?
                        Row(
                          children: [
                            Image.asset('assets/icons/star.png',width: 15.0),
                            Image.asset('assets/icons/half_star.png',width: 15.0),
                          ],
                        ) :
                        reviewList![index].starRating == "2" ?
                        Row(
                          children: [
                            Image.asset('assets/icons/star.png',width: 15.0),
                            Image.asset('assets/icons/star.png',width: 15.0),
                          ],
                        ) :
                        reviewList![index].starRating == "2.5" ?
                        Row(
                          children: [
                            Image.asset('assets/icons/star.png',width: 15.0),
                            Image.asset('assets/icons/star.png',width: 15.0),
                            Image.asset('assets/icons/half_star.png',width: 15.0),
                          ],
                        ) :
                        reviewList![index].starRating == "3" ?
                        Row(
                          children: [
                            Image.asset('assets/icons/star.png',width: 15.0),
                            Image.asset('assets/icons/star.png',width: 15.0),
                            Image.asset('assets/icons/star.png',width: 15.0),
                          ],
                        ) :
                        reviewList![index].starRating == "3.5" ?
                        Row(
                          children: [
                            Image.asset('assets/icons/star.png',width: 15.0),
                            Image.asset('assets/icons/star.png',width: 15.0),
                            Image.asset('assets/icons/star.png',width: 15.0),
                            Image.asset('assets/icons/half_star.png',width: 15.0),
                          ],
                        ) :
                        reviewList![index].starRating == "4" ?
                        Row(
                          children: [
                            Image.asset('assets/icons/star.png',width: 15.0),
                            Image.asset('assets/icons/star.png',width: 15.0),
                            Image.asset('assets/icons/star.png',width: 15.0),
                            Image.asset('assets/icons/star.png',width: 15.0),
                          ],
                        ) :
                        reviewList![index].starRating == "4.5" ?
                        Row(
                          children: [
                            Image.asset('assets/icons/star.png',width: 15.0),
                            Image.asset('assets/icons/star.png',width: 15.0),
                            Image.asset('assets/icons/star.png',width: 15.0),
                            Image.asset('assets/icons/star.png',width: 15.0),
                            Image.asset('assets/icons/half_star.png',width: 15.0),
                          ],
                        ) :
                        Row(
                          children: [
                            Image.asset('assets/icons/star.png',width: 15.0),
                            Image.asset('assets/icons/star.png',width: 15.0),
                            Image.asset('assets/icons/star.png',width: 15.0),
                            Image.asset('assets/icons/star.png',width: 15.0),
                            Image.asset('assets/icons/star.png',width: 15.0),
                          ],
                        ),
                        Text(
                          reviewList![index].comment.toString(),
                          style: const TextStyle(color: AppColors.secondary),
                          overflow: TextOverflow.clip,
                        ),
                        const SizedBox(height: 20.0),
                        const Divider(
                          height: 1,
                          thickness: 0.2,
                          color: AppColors.black,
                        ),
                      ],
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
  // reviewsApi
  Future<void> reviewsApi(BuildContext context) async {
    Loader.progressLoadingDialog(context, true);
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    var request = {};
    request['page'] = page;
    var response = await http.post(Uri.parse(Urls.reviews),
        body: convert.jsonEncode(request),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "X-AUTHTOKEN" : authToken,
          "X-USERID" : userId,
        });
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    Loader.progressLoadingDialog(context, false);
    ReviewModel res = await ReviewModel.fromJson(jsonResponse);
    if (res.status == true) {
      // reviewList = res.data!.ratings;
      // setState(() {});
      var data = jsonResponse['data']['ratings'];

      if (data != null) {
        print("data>>>${data}");
        data.forEach((e) {
          Ratings nModel = Ratings.fromJson(e);
          // print("NotificationModel...${nModel.date}");
          reviewList!.add(nModel);
          setState((){});
        });
      }
    } else {
      Utilities().toast(res.message.toString());
      setState(() {});
    }
    return;
  }
// reviewsApi
}