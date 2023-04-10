import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gas_station_merchant/models/help_and_support_model.dart';
import 'package:gas_station_merchant/views/utilities/loader.dart';
import 'package:gas_station_merchant/views/utilities/urls.dart';
import 'package:gas_station_merchant/views/utilities/utilities.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
// apis
import 'dart:async';
import 'dart:convert' as convert;
import 'package:pretty_http_logger/pretty_http_logger.dart';
// apis

class HelpAndSupport extends StatefulWidget {
  const HelpAndSupport({Key? key}) : super(key: key);

  @override
  State<HelpAndSupport> createState() => _HelpAndSupportState();
}

class _HelpAndSupportState extends State<HelpAndSupport> {
  String supportText = '';
  String _phone = '';
  String _email = '';
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
        backgroundColor: Colors.white,
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
          title: const Text('Help and Support',style: TextStyle(fontSize: 18.0,)),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.width * 0.05,
            left: 16.0,
            right: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset('assets/images/help_and_support.png',width: MediaQuery.of(context).size.width * 0.4,),
              ),
              /*Container(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.1,bottom: 10.0),
                alignment: Alignment.center,
                child: const Text(
                  'How can we help you',
                  style: TextStyle(
                      color: AppColors.black,
                      fontSize: 18.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),*/
              const SizedBox(height: 10.0),
              Align(
                alignment: Alignment.center,
                child: Container(
                  alignment: Alignment.center,
                  child: supportText == null || supportText == '' ? Container() : Html(
                    data: supportText,
                    style: {
                      supportText : Style(
                        color: AppColors.secondary,
                        alignment: Alignment.center,
                        textAlign: TextAlign.center
                      )
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: (){
                        _makePhoneCall(_phone);
                        setState(() {});
                      },
                      child: SvgPicture.asset(
                        'assets/images/call_us.svg',
                        height: 150.0,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: (){
                        _sendMail(_email);
                        setState(() {});
                      },
                      child: SvgPicture.asset(
                        'assets/images/email_us.svg',
                        height: 150.0,
                      ),
                    ),
                  ),
                ],
              ),
              /*Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFF0F9FB),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        boxShadow: [
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
                    ),
                  ),
                ],
              ),*/
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
    var response = await http.get(Uri.parse(Urls.helpSupport),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "X_CLIENT": Urls.x_client_token,
        });
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    Loader.progressLoadingDialog(context, false);
    HelpAndSupportModel res = await HelpAndSupportModel.fromJson(jsonResponse);
    if (res.status == true) {
      supportText = res.data!.supportText.toString();
      _phone = res.data!.supportMobileMo.toString();
      _email = 'mailto:${res.data!.supportEmail}';
      setState(() {});
    } else {
      Utilities().toast(res.message.toString());
      setState(() {});
    }
    return;
  }
  // privacyPolicyApi
  Future<void> _makePhoneCall(String phoneNumber) async {
    print('phoneNumber is ------------------------$phoneNumber');
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
  _sendMail(String eml) async {
    // Android and iOS
    if (await canLaunch(eml)) {
      await launch(eml);
    } else {
      throw 'Could not launch $eml';
    }
  }

}
