import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/utils/my_sharedpreferences.dart';
import '../../routes/routes.dart';

class SplashController extends GetxController {
  @override
  void onInit(){
    // todo implementation...
    super.onInit();
    startTime();
  }

  startTime() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? userId = localStorage.getString(MySharedPreference.sUserId);
    String? token = localStorage.getString(MySharedPreference.sToken);
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // connected
        if(userId != null){
          MySharedPreference.userId = int.parse(userId);
          MySharedPreference.token = token!;
          var _duration = const Duration(seconds: 2);
          return Timer(_duration, navigationPage);
        } else {
          MySharedPreference.userId = 0;
          MySharedPreference.token = "";
          var _duration = const Duration(seconds: 2);
          return Timer(_duration, navigateToLogin);
        }
      }else{
        // not connected
        var _duration = const Duration(seconds: 2);
        return Timer(_duration, noInternetPage);
      }
    } on SocketException catch (_) {
      print('not connected');
      var _duration = const Duration(seconds: 2);
      return Timer(_duration, noInternetPage);
    }
  }

  void navigationPage() {
    Get.offAllNamed(Routes.HOME);
  }

  void navigateToLogin(){
    Get.offAllNamed(Routes.WELCOME);
  }

  void noInternetPage() {
    Get.offAllNamed(Routes.NO_INTERNET);
  }
  @override
  void onClose(){
    // todo implementation...
    super.onClose();
  }

}