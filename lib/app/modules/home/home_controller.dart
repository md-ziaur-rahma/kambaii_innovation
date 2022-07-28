import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:innovation/app/core/utils/my_sharedpreferences.dart';
import 'package:innovation/app/core/utils/urls.dart';
import 'package:innovation/app/data/models/participant_data_model.dart';
import 'package:innovation/app/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/login_model.dart';
import '../../global_widget/common.dart';
import 'home_screen.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  Client client = Client();

  LoginModel loginModel = LoginModel();
  ParticipantDataModel participantDataModel = ParticipantDataModel();

  int typeOfUser = 1;
  // student = 1, teacher = 2, guardian = 3
  void changeOfType(int type)async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    typeOfUser = type;
    localStorage.setString(MySharedPreference.sUserType, type.toString());
    update();
  }

  void getTypeFromCache()async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String value = localStorage.getString(MySharedPreference.sUserType) ?? "1";
    typeOfUser = int.parse(value);
    update();
  }

  String getUserType(){
    if(typeOfUser == 1){
      return "Student";
    }
    if(typeOfUser == 2){
      return "Teacher";
    }
    if(typeOfUser == 3){
      return "Guardian";
    }

    return "";
  }

  String getButtonText(){
    if(typeOfUser == 2){
      return "Student";
    }
    if(typeOfUser == 3){
      return "Children";
    }

    return "";
  }

  final String studentText = "School_Participant";
  final String teacherText = "School_Teacher";
  final String guardianText = "School_Guardian";
  String getUserTypeNew(){
    if(typeOfUser == 1){
      return studentText;
    }
    if(typeOfUser == 2){
      return teacherText;
    }
    if(typeOfUser == 3){
      return guardianText;
    }

    return "";
  }

  String getUserTypePic(){
    if(typeOfUser == 1){
      return "student";
    }
    if(typeOfUser == 2){
      return "teacher";
    }
    if(typeOfUser == 3){
      return "guardian";
    }

    return "";
  }

  bool isReadyForIdeaSubmit(){
    if(participantDataModel.data?.registrationStep == null){
      return false;
    } else if(participantDataModel.data?.registrationStep == "step1" ||
        participantDataModel.data?.registrationStep == "step2" ||
        participantDataModel.data?.registrationStep == "step3" ||
        participantDataModel.data?.registrationStep == ""){
      return false;
    }
    return true;
  }

  final String individualText = "Individual";
  final String teamText = "Team";
  void saveTeamOrIndividual(value)async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString(MySharedPreference.sTeamOrIndividual, value);
  }

  @override
  void onInit(){
    getTypeFromCache();
    getLoginData();
    getParticipantData();
    super.onInit();
  }
  @override
  void onClose(){
    // client.close();
    super.onClose();
  }
  void changeLoading(bool value){
    isLoading.value = value;
    update();
  }

  void getLoginData()async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? data = localStorage.getString(MySharedPreference.sLoginResponse);
    if (data != null) {
      loginModel = LoginModel.fromJson(jsonDecode(data));
      update();
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

  List<Widget> studentsMenu = [

  ];
}