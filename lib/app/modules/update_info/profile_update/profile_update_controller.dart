import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:innovation/app/data/models/location_model.dart';
import 'package:innovation/app/modules/home/home_controller.dart';
import 'package:innovation/app/routes/routes.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/utils/my_sharedpreferences.dart';
import '../../../core/utils/urls.dart';
import '../../../global_widget/common.dart';

class StudentProfileUpdateController extends GetxController {
  var isLoading = false.obs;
  final profileUpdateKey = GlobalKey<FormState>();

  Client client = Client();

  final HomeController homeController = Get.put(HomeController());

  // ............ Location Variable ............
  LocationModel locationModel = LocationModel();
  int divisionId = 0;
  int districtId = 0;
  int upazilaId = 0;
  int unionId = 0;

  Data divisionData = Data();
  Data districtData = Data();
  Data upazilaData = Data();
  Data unionData = Data();

  List<Data> divisionList = [];
  List<Data> districtList = [];
  List<Data> upazilaList = [];
  List<Data> unionList = [];

  @override
  void onInit(){
    dob = dobController.text = "YYYY-MM-DD";
    // dob = dobController.text = formatter.format(DateTime.now());
    initialData();
    super.onInit();
  }

  @override
  void onClose(){
    client.close();
    super.onClose();
  }

  var divisionController = TextEditingController();
  var districtController = TextEditingController();
  var upazilaController = TextEditingController();
  var unionController = TextEditingController();
  String? dob;
  String? division;
  String? district;
  String? upazila;
  String? union;

  bool isCheck = false;
  var canLoading = false.obs;
  final obscureText = true.obs;

  void toggle() {
    obscureText.toggle();
  }

  void loadingToggle() {
    canLoading.toggle();
  }


  String? validationDob(String? value) {
    if (value == null || value.isEmpty) {
      return "Choose Date of birth";
    } else if(value == "yyyy-MM-dd") {
      return "Choose Date of birth";
    }else {
      return null;
    }
  }

  String? validationDivision(String? value) {
    if (value == null || value.isEmpty) {
      return 'Empty Mobile!';
    } else {
      return null;
    }
  }

  String? validationDistrict(String? value) {
    if (value!.isEmpty) {
      return 'Enter District';
    } else {
      return null;
    }
  }

  String? validationUpazila(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter Upazila!';
    } else {
      return null;
    }
  }

  String? validationUnion(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter Union!';
    } else {
      return null;
    }
  }

  void changeLoading(bool value){
    isLoading.value = value;
    update();
  }

  // ........... location select method ................
  void initialData() async {
    divisionData = addDropdownValue("Select Division");
    districtData = addDropdownValue("Select District");
    upazilaData = addDropdownValue("Select Upazila");
    unionData = addDropdownValue("Select Union");

    divisionList = addTempData("Select Division");
    districtList = addTempData("Select District");
    upazilaList = addTempData("Select Upazila");
    unionList = addTempData("Select Union");

    divisionData = divisionList[0];
    districtData = districtList[0];
    upazilaData = upazilaList[0];
    unionData = unionList[0];

    update();
    locationModel = (await getData("${Urls.baseUrl}${Urls.getDivision}"))!;
    for(Data data in locationModel.data!){
      divisionList.add(data);
    }

    update();
  }
  void selectDivision(Data value) async {
    divisionData = value;
    divisionId = value.id!;
    updateData(1);
    if (value.id != 0) {
      locationModel = (await getData("${Urls.baseUrl}${Urls.getDistrict}/${value.id}"))!;
      for(Data data in locationModel.data!){
        districtList.add(data);
      }
    }
  }
  void selectDistrict(Data value) async {
    districtData = value;
    districtId = value.id!;
    updateData(2);
    if (value.id != 0) {
      locationModel = (await getData("${Urls.baseUrl}${Urls.getUpazila}/${value.id}"))!;
      for(Data data in locationModel.data!){
        upazilaList.add(data);
      }
    }
  }
  void selectUpazila(Data value) async {
    upazilaData = value;
    upazilaId = value.id!;
    updateData(3);
    if (value.id != 0) {
      locationModel = (await getData("${Urls.baseUrl}${Urls.getUnion}/${value.id}"))!;
      for(Data data in locationModel.data!){
        unionList.add(data);
      }
    }
    update();
  }
  void selectUnion(Data value){
    unionData = value;
    unionId = value.id!;
    update();
  }
  void updateData(int type){
    if (type == 1) {
      districtList = addTempData("Select District");
      upazilaList = addTempData("Select Upazila");
      unionList = addTempData("Select Union");

      districtData = districtList[0];
      upazilaData = upazilaList[0];
      unionData = unionList[0];

      update();
    } else if (type == 2) {
      upazilaList = addTempData("Select Upazila");
      unionList = addTempData("Select Union");

      upazilaData = upazilaList[0];
      unionData = unionList[0];
      update();
    }  else if (type == 3) {
      unionList = addTempData("Select Union");

      unionData = unionList[0];
      update();
    }
  }
  Data addDropdownValue(String text){
    Data data = Data();
    data.id = 0;
    data.name = text;
    return data;
  }
  List<Data> addTempData(String text){
    List<Data> dataList = [];
    Data data = Data();
    data.id = 0;
    data.name = text;

    dataList.add(data);
    return dataList;
  }

  Future<LocationModel?> getData(String strUrl) async {
    changeLoading(true);
    Uri url = Uri.parse(strUrl);
    try{
      var response = await client.get(url,headers: {
        "Accept":"application/json",
        "Authorization": "Bearer ${MySharedPreference.token}",
      });
      isLoading.value = false;
      update();
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          return LocationModel.fromJson(jsonDecode(response.body));
        } else {
          LocationModel model = LocationModel();
          model.error = true;
          model.msg = "Data Not Found!";
          model.data = addTempData("Data Not Found");
          changeLoading(false);
          return model;
        }
      }else {
        throw Exception('Failed to load post');
      }
    }on Exception catch(e){
      changeLoading(false);
      print(e);
    }
  }

  //........... select Date of birth ...............
  var formatter = DateFormat("yyyy-MM-dd");
  DateTime fromSelectedDate = DateTime.now();
  var dobController = TextEditingController();
  selectDobDate(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
        context: context,
        initialDate: fromSelectedDate,
        firstDate: DateTime(1950),
        lastDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.year,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: const ColorScheme.light(
                primary: Color(0xFF31A3DD),
                onPrimary: Color(0xFFFFFFFF),
                surface: Color(0xFF31A3DD),
                onSurface: Color(0xFF000000),
                onSecondary: Colors.black87,
              ),
              textTheme: const TextTheme(
                subtitle1: TextStyle(color: Colors.black),
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child!,
          );
        });

    if (newSelectedDate != null) {
      fromSelectedDate = newSelectedDate;
      dobController
        ..text = formatter.format(fromSelectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: dobController.text.length,
            affinity: TextAffinity.upstream));
      dob = dobController.text;
      update();
    }
  }


  // ............ Final Submit Data ...............
  void saveFirstStepData()async{
    print("$divisionId,$districtId,$upazilaId,$unionId");
    changeLoading(true);
    Client client = Client();
    Uri url = Uri.parse(Urls.baseUrl+Urls.participantInfoUpdate);
    try{
      var response = await client.post(url,body: {
        'user_id': "${MySharedPreference.participantId}",
        'step': "step1",
        "date_of_birth": "$dob",
        'division': "$divisionId",
        "district": "$districtId",
        "upozila": "$upazilaId",
        "unions": "$unionId",
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
            Get.toNamed(Routes.ADD_GUARDIAN);
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