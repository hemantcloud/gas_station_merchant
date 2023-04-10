

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:gas_station_merchant/models/categories_model.dart';
import 'package:gas_station_merchant/models/profile_model.dart';
import 'package:gas_station_merchant/views/utilities/loader.dart';
import 'package:gas_station_merchant/views/utilities/urls.dart';
import 'package:gas_station_merchant/views/utilities/utilities.dart';
import 'package:path_provider/path_provider.dart';

// apis
import 'dart:async';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
// apis

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoriesData> categoriesList = [];
  Data? userData;
  late String authToken;
  late String userId;
  File? file2;
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
    profileApi(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.primary,
          title: const Text('Home',style: TextStyle(fontSize: 18.0,)),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 16.0),
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(14.0),
                  color: Colors.white,
                  border: Border.all(color: const Color(0xFFbfbfbf),width: 0,style: BorderStyle.solid),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFFbfbfbf),
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
                  children: [
                    userData == null ?
                    const CircleAvatar(
                      maxRadius: 30.0,
                      backgroundImage: AssetImage('assets/images/profile_default.png'),
                    ) :
                    CircleAvatar(
                      maxRadius: 30.0,
                      backgroundImage: NetworkImage(userData!.profileImage.toString()),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userData == null ? '' :'Welcome, ${userData!.fullName}',
                            style: const TextStyle(
                                fontSize: 16.0,
                                color: AppColors.black,
                                fontWeight: FontWeight.w600
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text(
                            userData == null ? '' :'${userData!.email}',
                            style: const TextStyle(color: AppColors.secondary,fontSize: 12.0),
                          ),
                          userData == null ? Container() :
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              userData!.avgRating == "0.00" ?
                              Container() :
                              SvgPicture.asset('assets/icons/star.svg'),
                              userData!.avgRating == "0.00" ?
                              Container() :
                              const SizedBox(width:5.0),
                              Text(
                                userData!.avgRating == "0.00" ? "No ratings yet" : userData!.avgRating!,
                                style: const TextStyle(color: AppColors.black,fontSize: 10.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: const Color(0xFFE1E1E1),width: 1,style: BorderStyle.solid),
                ),
                child: Column(
                  children: [
                    userData == null ?
                    Image.asset('assets/images/qr.png') :
                    Image.network(Urls.url + userData!.qrCode.toString()),
                    const SizedBox(height: 20.0),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              _save();
                            },
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: SvgPicture.asset('assets/icons/download.svg',width: 50.0,),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              _share2(Urls.url + userData!.qrCode.toString());
                            },
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: SvgPicture.asset('assets/icons/share.svg',width: 50.0,),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // extendBodyBehindAppBar: true,
      ),
    );
  }
  void _save() async {
    showSnackBar('Download in progress.....');
    GallerySaver.saveImage(Urls.url + userData!.qrCode.toString()).then((value) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      showSnackBar('Image downloaded in gallery.');
    });
  }
  void showSnackBar(String value) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(value),
        action: SnackBarAction(
          label: 'Dismiss',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  void _share(String fileP) async {
    // print('object');
    // Directory? directory;
    // if (Platform.isAndroid) {
    //   directory = await getExternalStorageDirectory();
    // } else {
    //   directory = await getApplicationDocumentsDirectory();
    // }
    // // final String localPath = '${directory!.path}/${DateTime.now().toIso8601String()}/$fileP.png';
    // // newFile = File(localPath);
    // final dirPath = '${directory!.path}/folder' ;
    // print("dirPath>>>>> "+dirPath);
    // final dirPathnew = await new Directory(dirPath).create();
    // file2 = File("${dirPathnew.path}"+".png");
    // setState(() {});
    // print('file2 is --------------$file2');
    // await Future.delayed(Duration.zero,() async {
    //   await FlutterShare.shareFile(
    //       title: 'Gas Station',
    //       filePath: file2!.path,
    //       fileType: 'image/png'
    //   );
    // });
  }
  void _share2(String fileP) async {
    showSnackBar('Sharing in progress.....');
    final url = Uri.parse(fileP);
    final res = await http.get(url);
    final bytes = res.bodyBytes;
    // final temp = await getTemporaryDirectory();
    Directory? temp;
    if (Platform.isAndroid) {
      temp = await getExternalStorageDirectory();
    } else {
      temp = await getApplicationDocumentsDirectory();
    }
    final path = '${temp!.path}/image.png';
    File(path).writeAsBytes(bytes);
    file2 = File(path);
    await Share.shareFiles(
      [path],
      // text: "Gas Station",
      subject: "Gas Station",
    );
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    setState(() {});
  }
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

}