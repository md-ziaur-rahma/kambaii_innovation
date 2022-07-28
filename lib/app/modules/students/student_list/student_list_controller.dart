import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:innovation/app/core/utils/my_sharedpreferences.dart';
import 'package:innovation/app/data/models/student_list_model.dart';

import '../../../core/utils/urls.dart';
import '../../../global_widget/common.dart';
import '../../home/home_controller.dart';

class StudentListController extends GetxController {
  var isLoading = false.obs;
  Client client = Client();

  final homeController = Get.put(HomeController());

  StudentListModel studentListModel = StudentListModel();
  List<Student> studentList = [];

  @override
  void onInit(){
    getStudents();
    super.onInit();
  }
  @override
  void onClose(){
    client.close();
    super.onClose();
  }

  void saveTypeOfUser(String? type){
    if(homeController.individualText.toUpperCase().contains(type!.toUpperCase())){
      homeController.saveTeamOrIndividual(homeController.individualText);
    } else if(homeController.teamText.toUpperCase().contains(type.toUpperCase())){
      homeController.saveTeamOrIndividual(homeController.teamText);
    }
  }
  bool isReadyForIdeaSubmit(String? step){
    if(step == null){
    } else if(step == "step1" || step == "step2" || step == "step3" || step == ""){
      print("false");
      return false;
    }
    return true;
  }

  void changeLoading(bool value){
    isLoading.value = value;
    update();
  }
  void getStudents()async{
    changeLoading(true);
    Client client = Client();
    Uri url = Uri.parse("${Urls.baseUrl}${Urls.getStudentsList}/${MySharedPreference.userId}");
    try{
      var response = await client.get(url, headers: {
        "Accept":"application/json",
        "Authorization": "Bearer ${MySharedPreference.token}",
      });
      print(response.body);
      final Map<String, dynamic> body = await json.decode(response.body);
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          if(body["error"] == false){
            // Common.toastMsg("${body["msg"]}");
            studentListModel = StudentListModel.fromJson(jsonDecode(response.body));
            studentList = studentListModel.data!;
          } else {
            Common.toastMsg("${body["msg"]}");
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