import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:innovation/app/modules/home/home_controller.dart';
import 'package:innovation/app/modules/students/student_list/student_list_controller.dart';

import '../../core/utils/my_sharedpreferences.dart';
import '../../core/utils/urls.dart';
import '../../global_widget/common.dart';
import '../../routes/routes.dart';

class AddStudentController extends GetxController {
  var isLoading = false.obs;
  Client client = Client();

  final studentFormKey = GlobalKey<FormState>();

  final homeController = Get.put(HomeController());
  final studentListController = Get.put(StudentListController());

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

  var nameController = TextEditingController();
  var mobileController = TextEditingController();
  var emailController = TextEditingController();
  var lastNameController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  String? confirmPassword;
  String? password;
  String? lastName;
  String? mobile;
  String? name;
  String? email;

  bool isCheck = false;
  var canLoading = false.obs;
  final obscureText = true.obs;
  void toggle() {
    obscureText.toggle();
    update();
  }
  void loadingToggle(){
    canLoading.toggle();
  }

  final _emailRegex = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
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
  String? validationLastName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter Last Name!';
    } else {
      return null;
    }
  }
  String? validationMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter Your Mobile!';
    } else if (!_phoneNORegex.hasMatch(value)) {
      return 'Enter Valid Phone Number';
    } else {
      return null;
    }
  }
  String? validationEmail(String? value) {
    if (value!.isEmpty) {
      return null;
    } else if (!_emailRegex.hasMatch(value)) {
      return 'Enter a valid email!';
    } else {
      return null;
    }
  }
  String? validationPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Empty Password!';
    } else if (value.length < 5) {
      return 'Enter minimum 5 digit';
    } else {
      return null;
    }
  }
  String? validationConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Empty Confirm Password!';
    } else if (value.compareTo(passwordController.text.toString()) == 0) {
      return null;
    } else {
      return 'Doesn\'t match with password';
    }
  }
  void changeLoading(bool value){
    isLoading.value = value;
    update();
  }
  void addStudentByTeacher()async{
    changeLoading(true);
    Client client = Client();
    Uri url = Uri.parse(Urls.baseUrl+Urls.register);
    try{
      var response = await client.post(url,body: {
        'teacher_id': "${MySharedPreference.userId}",
        "firstname": "$name",
        'lastname': lastName,
        "mobile": mobile,
        "email": "$email",
        "usertype": "School_Participant",
        "password": password,
      }, headers: {
        "Accept":"application/json",
        "Authorization": "Bearer ${MySharedPreference.token}",
      });
      print(response.body);
      final Map<String, dynamic> body = await json.decode(response.body);
      Common.toastMsg("${body["msg"]}");
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          if(body["error"] == false){
            // homeController.getParticipantData();
            // Get.toNamed(Routes.STUDENT_INSTITUTE_UPDATE);
            studentFormKey.currentState?.reset();
            studentListController.getStudents();
            Future.delayed(const Duration(milliseconds: 300)).then((value){
              Get.back();
            });
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