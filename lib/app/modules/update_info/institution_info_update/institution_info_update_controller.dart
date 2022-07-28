import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:innovation/app/modules/home/home_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/utils/my_sharedpreferences.dart';
import '../../../core/utils/urls.dart';
import '../../../global_widget/common.dart';
import '../../../routes/routes.dart';

class StudentInstituteUpdateController extends GetxController {
  var isLoading = false.obs;
  final instituteUpdateKey = GlobalKey<FormState>();

  final homeController = Get.put(HomeController());

  Client client = Client();

  @override
  void onInit(){
    // todo code .....
    super.onInit();
  }

  @override
  void onClose(){
    client.close();
    super.onClose();
  }

  List<String> groupList = ["Select Group","Science","Commerce","Arts","Others"];
  List<String> participatingGroupList = ["Please Select","Junior (Class 6-8)","Secondary (Class 9-10)"];

  var schoolNameController = TextEditingController();
  var classController = TextEditingController();
  var rollNotController = TextEditingController();
  var groupController = TextEditingController();
  var participatingController = TextEditingController();
  String? schoolName;
  String? className;
  String? rollNo;
  String? group = "Select Group";
  String? participatingGroup = "Please Select";

  bool isCheck = false;
  var canLoading = false.obs;
  final obscureText = true.obs;

  void toggle() {
    obscureText.toggle();
  }

  void loadingToggle() {
    canLoading.toggle();
  }


  String? validationSchoolName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Empty School Name!';
    } else {
      return null;
    }
  }

  String? validationClass(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter Class!';
    } else {
      return null;
    }
  }

  String? validationRollNo(String? value) {
    if (value!.isEmpty) {
      return 'Enter Roll No';
    } else {
      return null;
    }
  }

  String? validationGroup(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter Group!';
    } else {
      return null;
    }
  }

  String? validationParticipation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter Participation Group!';
    } else {
      return null;
    }
  }

  void selectGroup(value){
    group = value;
    update();
  }

  void selectParticipatingGroup(value){
    participatingGroup = value;
    update();
  }

  void changeLoading(bool value){
    isLoading.value = value;
    update();
  }
  void saveThirdStepData()async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? type = "";
    type = localStorage.getString(MySharedPreference.sTeamOrIndividual);
    changeLoading(true);
    Client client = Client();
    Uri url = Uri.parse(Urls.baseUrl+Urls.participantInfoUpdate);
    try{
      var response = await client.post(url,body: {
        'user_id': "${MySharedPreference.participantId}",
        'step': "step3",
        "school_name": "$schoolName",
        'class': className,
        "group": group,
        "p_group": participatingGroup
      }, headers: {
        "Accept":"application/json",
        "Authorization": "Bearer ${MySharedPreference.token}",
      });
      print(response.body);
      final Map<String, dynamic> body = await json.decode(response.body);
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          if(body["error"] == false){
            Common.toastMsg("${body["msg"]}");
            homeController.getParticipantData();
            if(type == homeController.teamText){
              Get.toNamed(Routes.TEAM_MEMBER);
            }else {
              Get.toNamed(Routes.IDEA_TYPE_CHOOSE);
            }
          } else {

          }
        }
      }else {
        Get.snackbar("Server Message", body["msg"],duration: const Duration(seconds: 3));
        throw Exception('Failed to load post');
      }
      changeLoading(false);
    }on Exception catch(e){
      print(e);
      changeLoading(false);
    }
  }
}