import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import '../../core/utils/my_sharedpreferences.dart';
import '../../core/utils/urls.dart';
import '../../global_widget/common.dart';
import '../../routes/routes.dart';
import '../home/home_controller.dart';

class AddGuardianController extends GetxController {
  var isLoading = false.obs;
  Client client = Client();
  var title = "";

  final guardianFormKey = GlobalKey<FormState>();

  final homeController = Get.put(HomeController());

  @override
  void onInit() {
    var arguments = Get.arguments;
    // title = arguments["title"];
    super.onInit();
  }

  @override
  void onClose() {
    client.close();
    super.onClose();
  }

  var nameController = TextEditingController();
  var addressController = TextEditingController();
  var mobileController = TextEditingController();
  var nidController = TextEditingController();
  var relationController = TextEditingController();
  String? address;
  String? nid;
  String? relation;
  String? mobile;
  String? name;

  bool isCheck = false;
  var canLoading = false.obs;
  final obscureText = true.obs;

  void toggle() {
    obscureText.toggle();
  }

  void loadingToggle() {
    canLoading.toggle();
  }
  final _phoneNORegex = RegExp(
    r'^(?:\+?88)?01[135-9]\d{8}$',
  );

  String? validationUserName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Empty Name!';
    } else {
      return null;
    }
  }

  String? validationMobile(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    } else if (!_phoneNORegex.hasMatch(value)) {
      return 'Enter Valid Phone Number';
    } else {
      return null;
    }
  }

  String? validationNID(String? value) {
    if (value!.isEmpty) {
      // return 'Enter NID/Passport';
      return null;
    } else {
      return null;
    }
  }

  String? validationAddress(String? value) {
    if (value == null || value.isEmpty) {
      return null;
      // return 'Enter Address!';
    } else {
      return null;
    }
  }

  String? validationRelation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter Relation!';
    } else {
      return null;
    }
  }

  void changeLoading(bool value){
    isLoading.value = value;
    update();
  }
  void saveSecondStepData()async{
    changeLoading(true);
    Client client = Client();
    Uri url = Uri.parse(Urls.baseUrl+Urls.participantInfoUpdate);
    try{
      var response = await client.post(url,body: {
        'user_id': "${MySharedPreference.participantId}",
        'step': "step2",
        "parent_name": "$name",
        'relation': relation,
        "nid_passport": nid,
        "p_mobile": mobile,
        "p_address": address,
      }, headers: {
        "Accept":"application/json",
        "Authorization": "Bearer ${MySharedPreference.token}",
      });
      print(response.body);
      final Map<String, dynamic> body = await json.decode(response.body);
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          if(body["error"] == false){
            // Get.snackbar("Register Message", body["msg"]);
            // Get.defaultDialog(
            //   barrierDismissible: false,
            //     title: "Registration Status",
            //     content: Column(
            //       children: const [
            //         Text("Successfully Created An Account\nNow you need to login",textAlign: TextAlign.center,),
            //         SizedBox(
            //           height: 8,
            //         ),
            //         Text("Now Login",textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 16),)
            //       ],
            //     )
            // );
            Common.toastMsg("${body["msg"]}");
            homeController.getParticipantData();
            Get.toNamed(Routes.STUDENT_INSTITUTE_UPDATE);
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