
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gas_station_merchant/models/privacy_policy_model.dart';
import 'package:gas_station_merchant/views/utilities/loader.dart';
import 'package:gas_station_merchant/views/utilities/urls.dart';
import 'package:gas_station_merchant/views/utilities/utilities.dart';
// apis
import 'dart:async';
import 'dart:convert' as convert;
import 'package:pretty_http_logger/pretty_http_logger.dart';
// apis

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  String data = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, (){
      privacyPolicyApi(context);
    });
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
          title: const Text('Privacy Policy',style: TextStyle(fontSize: 18.0,)),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              data == null || data == '' ? Container() : Html(
                data: data,
                style: {
                  data.toString() : Style(
                      color: AppColors.secondary
                  )
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  // privacyPolicyApi
  Future<void> privacyPolicyApi(BuildContext context) async {
    Loader.progressLoadingDialog(context, true);
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    var response = await http.get(Uri.parse(Urls.privacyPolicy),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "X_CLIENT": Urls.x_client_token,
        });
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    Loader.progressLoadingDialog(context, false);
    PrivacyPoilcyModel res = await PrivacyPoilcyModel.fromJson(jsonResponse);
    if (res.status == true) {
      data = res.data!.description!;
      setState(() {});
    } else {
      Utilities().toast(res.message.toString());
      setState(() {});
    }
    return;
  }
  // privacyPolicyApi

}
