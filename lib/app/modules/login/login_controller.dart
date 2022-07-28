import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:innovation/app/data/models/login_model.dart';
import 'package:innovation/app/modules/home/home_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/utils/my_sharedpreferences.dart';
import '../../core/utils/urls.dart';
import '../../routes/routes.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  final loginKey = GlobalKey<FormState>();

  final homeController = Get.put(HomeController());

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  final _emailRegex = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  final _phoneNORegex = RegExp(
    r'^(?:\+?88)?01[135-9]\d{8}$',
  );
  String? email;
  String? password;
  String? validationEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter an email address!';
    } else if (!_emailRegex.hasMatch(value)) {
      return 'Enter a valid email!';
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
  String? validationPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Empty Password!';
    } else if (value.length < 5) {
      return 'Enter minimum 5 digit';
    } else {
      return null;
    }
  }

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

  void changeLoading(bool value){
    isLoading.value = value;
    update();
  }

  void login() async {
    changeLoading(true);
    Client client = Client();
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    Uri url = Uri.parse(Urls.baseUrl+Urls.login);
    try{
      var response = await client.  post(url,body: {'username': email,"password": password},headers: {
        "Accept":"application/json"
      });
      print(response.body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> body = await json.decode(response.body);
        if (response.body.isNotEmpty) {
          if(body["error"] == false){
            LoginModel loginModel = LoginModel.fromJson(body);

            if(loginModel.data?.type == homeController.studentText){
              homeController.changeOfType(1);
            } else if(loginModel.data?.type == homeController.teacherText){
              homeController.changeOfType(2);
            } else if(loginModel.data?.type == homeController.guardianText){
              homeController.changeOfType(3);
            }

            String loginResponse = jsonEncode(LoginModel.fromJson(body));
            localStorage.setString(MySharedPreference.sLoginResponse, loginResponse);
            localStorage.setString(MySharedPreference.sToken, loginModel.data!.jwtToken!.original!.accessToken!);
            localStorage.setString(MySharedPreference.sUserId, loginModel.data!.id!.toString());

            MySharedPreference.userId = loginModel.data!.id!;
            MySharedPreference.token = loginModel.data!.jwtToken!.original!.accessToken!;
            Get.snackbar("Login Message", loginModel.msg!);
            Get.offAllNamed(Routes.HOME);
          } else {
            Get.snackbar("Login Message", body["msg"],snackPosition: SnackPosition.BOTTOM);
          }
        }
      }else {
        print('xxxxxxxxxxxxxxx');
        Get.snackbar("Login Message", "Login Failed! Try Again.",snackPosition: SnackPosition.BOTTOM);
        throw Exception('Failed to load post');
      }
      changeLoading(false);
    }on Exception catch(e){
      print('yyyyyyyyyyyyyyyy');
      print(e);
      changeLoading(false);
      Get.snackbar("Login Message", "Login Failed! Try Again.",snackPosition: SnackPosition.BOTTOM);
    }
  }

  //........... login with google ................
  void getGoogleData() async {
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        // 'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );

    googleSignIn.signIn().then((GoogleSignInAccount? acc) async {
      GoogleSignInAuthentication auth = await acc!.authentication;
      print(acc.id);
      print(acc.email);
      print(acc.displayName);
      print(acc.photoUrl);

      List<String> names = acc.displayName!.split(" ");
      print(names.length);
      print("${names[0]},${names[1]}");

      acc.authentication.then((GoogleSignInAuthentication auth) async {
        print('Auth id token${auth.idToken!}');
        print('Auth access token${auth.accessToken!}');
      });

      googleLogin(names[0],names[1], acc.email,"");

    });
  }
  void googleLogin(String fName,String lName,String iEmail,String mobile) async {
    print("xxxxxxxxxxxxxxxxxxxxxxxxxx");
    print(fName+", "+lName+iEmail);
    changeLoading(true);
    Client client = Client();
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    Uri url = Uri.parse(Urls.baseUrl+Urls.thirdPartyLogin);
    try{
      var response = await client.post(url,body: {
        'firstname': fName,
        'lastname': lName,
        'email': iEmail,
        // "usertype": "Teacher",
        "usertype": homeController.getUserTypeNew(),
        "registered_by": "Google"},
          headers: {
        "Accept":"application/json"
      });
      print("vvvvvvvvvvvvvvvvvvvvv${response.body}vvvvvvvvvvvvvvvvv");
      if (response.statusCode == 200) {
        final Map<String, dynamic> body = await json.decode(response.body);
        if (response.body.isNotEmpty) {
          if(body["error"] == false){
            LoginModel loginModel = LoginModel.fromJson(body);

            if(loginModel.data?.type == homeController.studentText){
              homeController.changeOfType(1);
            } else if(loginModel.data?.type == homeController.teacherText){
              homeController.changeOfType(2);
            } else if(loginModel.data?.type == homeController.guardianText){
              homeController.changeOfType(3);
            }

            String loginResponse = jsonEncode(LoginModel.fromJson(body));
            localStorage.setString(MySharedPreference.sLoginResponse, loginResponse);
            localStorage.setString(MySharedPreference.sToken, loginModel.data!.jwtToken!.original!.accessToken!);
            localStorage.setString(MySharedPreference.sUserId, loginModel.data!.id!.toString());

            MySharedPreference.userId = loginModel.data!.id!;
            MySharedPreference.token = loginModel.data!.jwtToken!.original!.accessToken!;
            Get.snackbar("Login Message", loginModel.msg!);
            Get.offAllNamed(Routes.HOME);
          } else {
            changeLoading(false);
            Get.snackbar("Login Message", "Login Failed!",snackPosition: SnackPosition.BOTTOM);
            Get.snackbar("Login Message", "${body["message"]}",snackPosition: SnackPosition.BOTTOM);
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

  // .............. login with facebook ....................
  // Future<UserCredential> signInWithFacebook() async {
  //   print("xxxxxxxxxxxxxxxxxxxx");
  //   // Trigger the sign-in flow
  //   final LoginResult loginResult = await FacebookAuth.instance.login();
  //   print("yyyyyyyyyyyyyyyyyyyyy");
  //
  //   // Create a credential from the access token
  //   final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
  //
  //   print("zzzzzzzzzzzzzzzzzzzzz");
  //   // Once signed in, return the UserCredential
  //   UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  //   print(userCredential.additionalUserInfo?.username!);
  //   print(userCredential.user?.phoneNumber!);
  //   print(userCredential.user?.displayName);
  //   print(userCredential.user?.email);
  //   return userCredential;
  // }
}

//School_Participant,School_Teacher,School_guardian