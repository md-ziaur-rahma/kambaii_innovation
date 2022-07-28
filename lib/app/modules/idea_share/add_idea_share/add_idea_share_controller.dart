
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:innovation/app/global_widget/common.dart';
import 'package:innovation/app/routes/routes.dart';

import '../../../core/utils/my_sharedpreferences.dart';
import '../../../core/utils/urls.dart';

class AddIdeaShareController extends GetxController {
  var isLoading = false.obs;
  Client client = Client();

  var ideaTextController =TextEditingController();

  String? ideaText = "";
  String image = "";
  String pdf = "";
  String audio = "";
  String video = "";

  String? validationIdeaText(value){
    if(value == null || value == ""){
      return "Enter Idea In Text!";
    } else {
      return null;
    }
  }

  // .................... Photo Picker ...................
  final ImagePicker picker = ImagePicker();
  XFile? imageFile;
  String base64Image = "";

  void pickImages() async {
    XFile? tempImages = await picker.pickImage(source: ImageSource.gallery);
    if (tempImages == null) {
      print("Null Image");
    } else {
      imageFile = tempImages;
      List<int> imageBytes = await imageFile!.readAsBytes();
      base64Image = base64Encode(imageBytes);
      update();
    }
  }

  // ..................... PDF file picker ........................

  List<PlatformFile>? pdfFileList;
  PlatformFile? pdfPlatFormFile;
  File? pdfFile;
  final String? pdfExtension = "pdf";
  final FileType pickingType = FileType.custom;
  void openFileExplorer(String? extension) async {
    try {
      pdfFileList = (await FilePicker.platform.pickFiles(
        type: pickingType,
        allowMultiple: true,
        allowedExtensions: (extension?.isNotEmpty ?? false)
            ? extension?.replaceAll(' ', '').split(',')
            : null,
      ))
          ?.files;

    } on PlatformException catch (e) {
      print("Unsupported operation$e");
    } catch (ex) {
      print(ex);
    }
    // if (!mounted) return;
    // setState(() {
    //   if (radioGroup == 1) {
    //     openCsvFile(_paths![0].path);
    //   }  else if (radioGroup == 2) {
    //     openExelFile(_paths![0].path);
    //   } else if (radioGroup == 3) {
    //     openTxtFile(_paths![0].path);
    //   }
    //   print("......................$_paths......................");
    //   print("File path ${_paths![0]}");
    //   print("Extension : ${_paths!.first.extension}");
    // });
  }
  // .......... Pick PDF file .............
  void pickPdfFile()async{
    print("eeeeeeeeeeeeeeeee");
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    print("mmmmmmmmmmmmmmmmmmmm");
    if(result != null){
      pdfFile = File(result.files.single.path!);
      pdfPlatFormFile = result.files.first;
      print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa ${pdfPlatFormFile?.name} aaaaaaaaaaaaaaaaaaaaaaaaaaa");
      update();
    }else {
      print("xxxxxxxxxxxxxxxxxxxxxxxxxxxx");

    }

  }
  // .......... Pick Audio file .............
  PlatformFile? audioPlatFormFile;
  File? audioFile;
  void pickAudioFile()async{
    print("eeeeeeeeeeeeeeeee");
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3'],
    );
    print("mmmmmmmmmmmmmmmmmmmm");
    if(result != null){
      audioFile = File(result.files.single.path!);
      audioPlatFormFile = result.files.first;
      print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa ${audioPlatFormFile?.name} aaaaaaaaaaaaaaaaaaaaaaaaaaa");
      update();
    }else {
      print("xxxxxxxxxxxxxxxxxxxxxxxxxxxx");

    }

  }
  // .......... Pick Video file .............
  PlatformFile? videoPlatFormFile;
  File? videoFile;
  void pickVideoFile()async{
    print("eeeeeeeeeeeeeeeee");
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp4'],
    );
    print("mmmmmmmmmmmmmmmmmmmm");
    if(result != null){
      videoFile = File(result.files.single.path!);
      videoPlatFormFile = result.files.first;
      print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa ${videoPlatFormFile?.name} aaaaaaaaaaaaaaaaaaaaaaaaaaa");
      update();
    }else {
      print("xxxxxxxxxxxxxxxxxxxxxxxxxxxx");

    }

  }

  // @override
  // void onInit(){
  //
  //   super.onInit();
  // }
  @override
  void onClose(){

    super.onClose();
  }

  void changeLoading(bool value){
    isLoading.value = value;
    update();
  }
  void submitIdea()async{
    print("${MySharedPreference.userId}");
    print("${MySharedPreference.token}");
    changeLoading(true);
    Client client = Client();
    Uri url = Uri.parse(Urls.baseUrl+Urls.participantInfoUpdate);
    try{
      var response = await client.post(url,body: {
        'user_id': "${MySharedPreference.participantId}",
        "step": "step4",
        "idea_details": ideaTextController.text,
        'image_file': base64Image,
        // "pdf_file": pdfFile?? "",
        "audio_file": audio,
        "video_file": video,
      }, headers: {
        "Accept":"application/json",
        "Authorization": "Bearer ${MySharedPreference.token}",
      });
      print(response.body);
      final Map<String, dynamic> body = await json.decode(response.body);
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          Common.toastMsg("${body["msg"]}");
          if(body["error"] == false){
            Get.toNamed(Routes.SUCCESS_SCREEN,arguments: {"msg":body["msg"]});
            ideaTextController.text = "";
            base64Image = "";
            imageFile = null;
          } else {
            throw Exception('Failed to load post');
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

  void submitIdeaMultipart()async{
    print("${MySharedPreference.userId}");
    print("${MySharedPreference.token}");
    changeLoading(true);
    Client client = Client();
    Uri url = Uri.parse(Urls.baseUrl+Urls.participantInfoUpdate);
    Map<String,String> data = {
      'user_id': "${MySharedPreference.participantId}",
      "step": "step4",
      "idea_details": ideaTextController.text,
      // 'image_file': base64Image,
    };

    Map<String,String> headers = {
      // "Accept":"application/json",
      "Authorization": "Bearer ${MySharedPreference.token}",
      'Content-Type': 'multipart/form-data',
    };

    try {
      var request = http.MultipartRequest('POST', url)
        ..headers.addAll(headers)
        ..fields.addAll(data);
      if(imageFile != null){
        request.files.add(await http.MultipartFile.fromPath('image_file', imageFile!.path));
      }
      if(pdfFile != null){
        request.files.add(await http.MultipartFile.fromPath('pdf_file', pdfFile!.path));
      }
      if(audioFile != null){
        print(audioFile!.path);
        request.files.add(await http.MultipartFile.fromPath('audio_file', audioFile!.path));
      }
      if(videoFile != null){
        request.files.add(await http.MultipartFile.fromPath('video_file', videoFile!.path));
      }

      var response = await request.send();
      response.stream.transform(utf8.decoder).listen((value) async {
        print('///////////////$value //////////////');
        final Map<String, dynamic>? body = await json.decode(value);
        if (body!["error"] == false) {
            Get.toNamed(Routes.SUCCESS_SCREEN,arguments: {"msg":body["msg"]});
            ideaTextController.text = "";
            base64Image = "";
            imageFile = null;
        } else {
          Get.defaultDialog(
            title: "Error Message",
            content: Text("${body["msg"]}"),
          );
        }
      });
      changeLoading(false);
    }on Exception catch(e){
      print(e);
      changeLoading(false);
    }
  }
}