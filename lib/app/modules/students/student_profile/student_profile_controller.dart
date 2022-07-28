import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:innovation/app/modules/home/home_controller.dart';
import 'package:innovation/app/modules/welcome/welcome_screen.dart';
import 'package:innovation/app/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/utils/my_sharedpreferences.dart';
import '../../../core/utils/urls.dart';
import '../../../data/models/participant_data_model.dart';

class StudentProfileController extends GetxController {
  var isLoading = false.obs;
  Client client = Client();

  ParticipantDataModel participantDataModel = ParticipantDataModel();

  final homeController = Get.put(HomeController());

  @override
  void onInit(){
    getParticipantData();
    super.onInit();
  }

  @override
  void onClose(){
    client.close();
    super.onClose();
  }

  void changeLoading(value){
    isLoading.value = value;
    update();
  }

  void temporaryLogout(BuildContext context)async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.clear();
    Navigator.of(context).pushNamedAndRemoveUntil(Routes.WELCOME, (Route<dynamic> route) => false);
    Get.offNamedUntil(Routes.WELCOME, (route) => true);
  }
  void logout()async{
    changeLoading(true);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? token = localStorage.getString(MySharedPreference.sToken);

    print("Token : $token");
    Uri url = Uri.parse(Urls.baseUrl+Urls.logout);
    try{
      var response = await client.get(url,headers: {
        "Accept":"application/json",
        "Authorization": "Bearer $token",
      });
      final Map<String, dynamic> body = await json.decode(response.body);
      if (response.statusCode == 200) {
        if(response.body.isNotEmpty){
          final Map<String, dynamic> body = await json.decode(response.body);
          if(body["error"] == false){
            Get.offAllNamed(Routes.WELCOME);
          }
        }

        changeLoading(false);
      }else {
        changeLoading(false);
        Get.snackbar("Logout Response", body["msg"],duration: const Duration(seconds: 3));
        throw Exception('Failed to load post');
      }
    }on Exception catch(e){
      changeLoading(false);
      print(e);
    }
  }

  String? getAddress(){
    return "${participantDataModel.data?.unions},${participantDataModel.data?.upozila},${participantDataModel.data?.district},${participantDataModel.data?.division}";
  }

  void getParticipantData()async{
    changeLoading(true);
    // SharedPreferences localStorage = await SharedPreferences.getInstance();
    Uri url = Uri.parse(Urls.baseUrl+Urls.participantData);
    try{
      var response = await client.get(url,headers: {
        "Accept":"application/json",
        "Authorization": "Bearer ${MySharedPreference.token}",
      });
      print(response.body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> body = await json.decode(response.body);
        if (response.body.isNotEmpty) {
          if(body["error"] == false){
            participantDataModel = ParticipantDataModel.fromJson(body);
          } else {
            // Get.snackbar("Login Message", body["msg"],snackPosition: SnackPosition.BOTTOM);
          }
        }
      }else {
        throw Exception('Failed to load post');
      }
      changeLoading(false);
    }on Exception catch(e){
      print(e);
      changeLoading(false);
    }
  }

}