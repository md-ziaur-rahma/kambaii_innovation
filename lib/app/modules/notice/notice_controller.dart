import 'dart:convert';
import 'dart:io';
import 'package:android_path_provider/android_path_provider.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:innovation/app/core/utils/my_sharedpreferences.dart';
import 'package:innovation/app/core/utils/urls.dart';
import 'package:innovation/app/data/models/notice_model.dart';
import 'package:innovation/app/global_widget/common.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class NoticeController extends GetxController {
  var isLoading = false.obs;
  Client client = Client();

  List<Notice> noticeList = [];
  NoticeModel noticeModel = NoticeModel();
  @override
  void onInit(){
    getNotice();
    super.onInit();
  }
  @override
  void onClose(){
    client.close();
    super.onClose();
  }
  void changeLoading(bool value){
    isLoading.value = value;
    update();
  }
  void getNotice()async{
    changeLoading(true);
    Uri url = Uri.parse(Urls.baseUrl+Urls.getNotice);
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
            noticeModel = NoticeModel.fromJson(body);
            noticeList = noticeModel.data!;
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

  //................. download pdf .............
  Future<String?> findLocalPath() async {
    String? externalStorageDirPath;
    if (Platform.isAndroid) {
      try {
        externalStorageDirPath = await AndroidPathProvider.downloadsPath;
      } catch (e) {
        final directory = await getExternalStorageDirectory();
        externalStorageDirPath = directory?.path;
      }
    } else if (Platform.isIOS) {
      externalStorageDirPath =
          (await getApplicationDocumentsDirectory()).absolute.path;
    }
    return externalStorageDirPath;
  }

  void openFile(String url,String? fileName)async{
    final name = fileName ?? url.split("/").last;
    final file = await downloadFile(url,name);
    if (file == null) return;
    print("file ${file.path}");
    OpenFile.open(file.path);
  }

  Future<File?> downloadFile(String url,String fileName)async{
    Dio dio = Dio();
    try{
      final appStorage = await findLocalPath();
      final file = File("$appStorage/$fileName");

      final response = await dio.get(url,
          options: Options(
              responseType: ResponseType.bytes,
              followRedirects: false,
              receiveTimeout: 1000
          ));
      print("response : ${response.data}");
      final raf = file.openSync(mode: FileMode.write);

      raf.writeFromSync(response.data);
      await raf.close();
      return file;
    }catch (e){
      Common.toastMsg("Notice File Not Found!");
      return null;
    }
  }

}