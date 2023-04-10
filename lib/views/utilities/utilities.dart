// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class AppColors {
  static const Color primary = Color(0xFF5E43C3);
  static const Color secondary = Color(0xFF7C7C7C);
  static const Color border = Color(0xFFE2E2E2);
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color yellow = Color(0xFFEE992A);
  static const Color red = Color(0xFFFF0000);
  static const Color green = Color(0xFF10C530);
  static const Color gunpowder = Color(0xFF41405D);
}
class Utilities {

  toast(msg) {
    Fluttertoast.showToast(
      msg: msg.toString(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: AppColors.primary,
      textColor: Colors.white,
      // fontSize: 16.0
    );
  }

  String DatefomatToMonth(String bigTime) {
    DateTime tempDate = DateFormat("yyyy-MM-ddTHH:mm:ss.000000Z").parse(bigTime);
    // var dateFormat = DateFormat("MM-dd-yyyy"); // you can change the format here
    var dateFormat = DateFormat.MMMM(); // you can change the format here
    var utcDate = dateFormat.format(tempDate); // pass the UTC time here
    var localDate = dateFormat.parse(utcDate, false).toLocal().toString();
    String createdDate = dateFormat.format(DateTime.parse(localDate));
    // print("formated date is------------$createdDate");
    return createdDate;
  }
  String DatefomatToYear(String bigTime) {
    DateTime tempDate = DateFormat("yyyy-MM-ddTHH:mm:ss.000000Z").parse(bigTime);
    // var dateFormat = DateFormat("MM-dd-yyyy"); // you can change the format here
    var dateFormat = DateFormat.y(); // you can change the format here
    var utcDate = dateFormat.format(tempDate); // pass the UTC time here
    var localDate = dateFormat.parse(utcDate, false).toLocal().toString();
    String createdDate = dateFormat.format(DateTime.parse(localDate));
    // print("formated date is------------$createdDate");
    return createdDate;
  }
  String DatefomatToDate(String bigTime) {
    // DateTime tempDate = DateFormat("yyyy-MM-dd' 'HH:mm:ss").parse(bigTime);
    DateTime tempDate = DateFormat("yyyy-MM-ddTHH:mm:ss.000000Z").parse(bigTime);
    // var dateFormat = DateFormat("MM-dd-yyyy"); // you can change the format here
    var dateFormat = DateFormat.d(); // you can change the format here
    var utcDate = dateFormat.format(tempDate); // pass the UTC time here
    var localDate = dateFormat.parse(utcDate, false).toLocal().toString();
    String createdDate = dateFormat.format(DateTime.parse(localDate));
    // print("formated date is------------$createdDate");
    return createdDate;
  }


}