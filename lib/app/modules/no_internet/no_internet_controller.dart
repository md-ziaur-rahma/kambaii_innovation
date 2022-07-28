import 'dart:io';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/utils/my_sharedpreferences.dart';
import '../../routes/routes.dart';

class NoInternetController extends GetxController{
  var isLoading = false.obs;

  void checkInternet()async {
    isLoading.value = true;
    update();
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? userId = localStorage.getString(MySharedPreference.sUserId);
    String? token = localStorage.getString(MySharedPreference.sToken);
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        if(userId != null){
          MySharedPreference.userId = int.parse(userId);
          MySharedPreference.token = token!;
          Get.toNamed(Routes.HOME);
        } else {
          MySharedPreference.userId = 0;
          MySharedPreference.token = "";
          Get.toNamed(Routes.LOGIN);
        }
      }else{
        // not connected
      }
      isLoading.value = false;
      update();
    } on SocketException catch (_) {
      print('not connected');
      isLoading.value = false;
      update();
    }
  }
}