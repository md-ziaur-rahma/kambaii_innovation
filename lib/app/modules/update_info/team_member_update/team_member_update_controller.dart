import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:innovation/app/modules/home/home_controller.dart';

import '../../../core/utils/my_sharedpreferences.dart';
import '../../../core/utils/urls.dart';
import '../../../global_widget/common.dart';
import '../../../routes/routes.dart';

class TeamMemberUpdateController extends GetxController {
  var isLoading = false.obs;
  Client client = Client();

  final teamMemberUpdateKey = GlobalKey<FormState>();
  final homeController = Get.put(HomeController());

  var teamNameController = TextEditingController();
  var fMNameController = TextEditingController();
  var fMContactController = TextEditingController();
  var sMNameController = TextEditingController();
  var sMContactController = TextEditingController();
  String? teamName;
  String? fMName;
  String? fMContact;
  String? sMName;
  String? sMContact;

  final _phoneNORegex = RegExp(
    r'^(?:\+?88)?01[135-9]\d{8}$',
  );

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
  @override
  void onClose() {
    client.close();
    super.onClose();
  }

  String? validationFMName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter 1st Member Name!';
    } else {
      return null;
    }
  }

  String? validationFMContact(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter Mobile Number!';
    } else if (!_phoneNORegex.hasMatch(value)) {
      return 'Enter Valid Phone Number';
    } else {
      return null;
    }
  }

  String? validationSMName(String? value) {
    if (value!.isEmpty) {
      return 'Enter 2nd Member Name';
    } else {
      return null;
    }
  }

  String? validationTeamName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter A Group Name';
    } else {
      return null;
    }
  }

  void changeLoading(bool value){
    isLoading.value = value;
    update();
  }
  void saveThirdStepData()async{
    changeLoading(true);
    Client client = Client();
    Uri url = Uri.parse(Urls.baseUrl+Urls.participantInfoUpdate);
    try{
      var response = await client.post(url,body: {
        'user_id': "${MySharedPreference.participantId}",
        'step': "step5",
        "team_name": "$teamName",
        'first_member_name': fMName,
        "first_member_contact": fMContact,
        "second_member_name": sMName,
        "second_member_contact": sMContact
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
            Get.toNamed(Routes.IDEA_TYPE_CHOOSE);
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