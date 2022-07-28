import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Common {
  static void toastMsg(String? msg){
    Fluttertoast.showToast(
        msg: "$msg",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey.withOpacity(1),
        textColor: Colors.white,
        fontSize: 16.0
    );
    // showToast(
    //   '$msg',
    //   duration: const Duration(milliseconds: 3500),
    //   position: ToastPosition.bottom,
    //   backgroundColor: Colors.black.withOpacity(0.7),
    //   radius: 6.0,
    //   dismissOtherToast: true,
    //   textPadding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
    //   textStyle: const TextStyle(fontSize: 16.0),
    // );
  }
}