import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:innovation/app/global_widget/common.dart';
import 'package:innovation/app/modules/home/home_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/utils/urls.dart';

class SignupController extends GetxController {
  var isLoading = false.obs;
  Client client = Client();
  final signupKey = GlobalKey<FormState>();

  final signupFormKey = GlobalKey<FormState>();

  final HomeController homeController = Get.put(HomeController());

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

  var instituteController = TextEditingController();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var mobileController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var lastNameController = TextEditingController();
  String? institute = "";
  String? email;
  String? password;
  String? confirmPassword;
  String? lastName;
  String? mobile;
  String? name;

  bool isCheck = false;
  var canLoading = false.obs;
  final obscureText = true.obs;
  void toggle() {
    obscureText.toggle();
    update();
  }
  void loadingToggle(){
    canLoading.toggle();
    update();
  }

  final _emailRegex = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  final _phoneNORegex = RegExp(
    r'^(?:\+?88)?01[135-9]\d{8}$',
  );

  String? validationInstitute(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter Institute Name!';
    } else {
      return null;
    }
  }
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
  void signup() async {
    print("$name,$lastName,$mobile,$email,$password");
    changeLoading(true);
    Client client = Client();
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    Uri url = Uri.parse(Urls.baseUrl+Urls.register);
    try{
      var response = await client.post(url,body: {
        'institute': "$institute",
        'firstname': name,
        "lastname": lastName,
        'mobile': mobile,
        "email": email,
        "password": password,
        "usertype": homeController.getUserTypeNew()
      }, headers: {
        "Accept":"application/json"
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
            Common.toastMsg("Now Login to continue");
            Get.back();
          } else {
            // Get.snackbar("Login Message", body["msg"]);
            Get.defaultDialog(
                title: "Error!",
                content: Column(
                  children: [
                    Text("${body["msg"]}",textAlign: TextAlign.center,),
                    const Text("Try Again",textAlign: TextAlign.center,),
                  ],
                )
            );
          }
        }
      }else {
        Get.snackbar("Register Message", body["msg"],duration: const Duration(seconds: 3));
        throw Exception('Failed to load post');
      }
      changeLoading(false);
    }on Exception catch(e){
      print(e);
      changeLoading(false);
    }
  }

}