// import 'package:kambaiihealth/app/data/models/login_model.dart';

import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreference{
  static const sLoginResponse = "login_responseIN";
  static const sUserId = "userIdIN";
  static const sToken = "tokenIN";
  static const sUserType = "userTypeIN";
  static const sTeamOrIndividual = "teamOrIndividualIN";

  static int userId = 0;
  static int participantId = 0;
  static String? token = "";

  // static LoginModel loginData = LoginModel();
  static const studentData = "studentDataIN";

  static void saveData(String key,String value) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString(key, value);
  }

  static Future<String?> getData(String key,String value) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    return localStorage.getString(key);
  }
}