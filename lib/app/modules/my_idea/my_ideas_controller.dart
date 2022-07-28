import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:innovation/app/global_widget/common.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:innovation/app/data/models/idea_info_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

import '../../core/utils/my_sharedpreferences.dart';
import '../../core/utils/urls.dart';

class MyIdeasController extends GetxController {
  var isLoading = false.obs;
  Client client = Client();

  IdeaInfoModel ideaInfoModel = IdeaInfoModel();

  late VideoPlayerController videoPlayerController;
  var demoVideo =
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';

  final player = AudioPlayer();
  var isPlaying = 1.obs;

  void playMusic(url) async {
    print("yyyyyyyyyyyyyyyy");
    await player.setUrl(url);
    await player.setLoopMode(LoopMode.one);
    await player.play();
    isPlaying.value = 2;
    update();
  }

  void pauseAudio() async {
    print("xxxxxxxxxxx");
    if (isPlaying.value == 2) {
      player.pause();
      isPlaying.value = 3;
      update();
    } else if(isPlaying.value == 3){
      player.play();
      isPlaying.value = 2;
      update();
    }
  }

  @override
  void onInit() {
    loadVideo(demoVideo);
    var arguments = Get.arguments;
    var userId = arguments["userId"];
    getIdeaData2(userId);
    // videoPlayerController = VideoPlayerController.network(demoVideo)
    //   ..initialize().then((value) {
    //     // update();
    //   });
    super.onInit();
  }

  @override
  void onClose() {
    client.close();
    videoPlayerController.dispose();
    player.dispose();
    super.onClose();
  }

  void loadVideo(url) {
    print(url);
    videoPlayerController = VideoPlayerController.network(url)
      ..initialize().then((value) {
        update();
      });
  }

  void changeLoading(bool value) {
    isLoading.value = value;
    update();
  }

  Future<File> createFileOfPdfUrl(url) async {
    Common.toastMsg("Loading pdf...");
    Completer<File> completer = Completer();
    try {
      // const url = "http://www.africau.edu/images/default/sample.pdf";
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      print("Download files");
      print("${dir.path}/$filename");
      File file = File("${dir.path}/$filename");
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  Future<IdeaInfoModel?> getIdeaData() async {
    // changeLoading(true);
    Uri url = Uri.parse(
        "${Urls.baseUrl}${Urls.getIdeaInfo}/${MySharedPreference.userId}");
    try {
      var response = await client.get(url, headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${MySharedPreference.token}",
      });
      print(response.body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> body = await json.decode(response.body);
        if (response.body.isNotEmpty) {
          if (body["error"] == false) {
            ideaInfoModel = IdeaInfoModel.fromJson(body);
            if (ideaInfoModel.data?.participantInfo?.ideaInfo?.videoFile ==
                    null ||
                ideaInfoModel.data?.participantInfo?.ideaInfo?.videoFile ==
                    "") {
            } else {
              print("xxxxxxxxxxxxxxxxxxx");
              // loadVideo("${Urls.picBaseUrl}public/${ideaInfoModel.data?.participantInfo?.ideaInfo?.videoFile}");
              // demoVideo = "${Urls.picBaseUrl}public/${ideaInfoModel.data?.participantInfo?.ideaInfo?.videoFile}";
              loadVideo("${ideaInfoModel.data?.participantInfo?.ideaInfo?.videoFile}");
              demoVideo = "${ideaInfoModel.data?.participantInfo?.ideaInfo?.videoFile}";
              update();
            }
            return ideaInfoModel;
          } else {
            // Get.snackbar("Login Message", body["msg"],snackPosition: SnackPosition.BOTTOM);
          }
        }
      } else {
        throw Exception('Failed to load post');
      }
      return ideaInfoModel;
      // changeLoading(false);
    } on Exception catch (e) {
      return ideaInfoModel;
      // changeLoading(false);
    }
  }

  Future<IdeaInfoModel?> getIdeaData2(userId) async {
    changeLoading(true);
    Uri url = Uri.parse(
        "${Urls.baseUrl}${Urls.getIdeaInfo}/$userId");
    try {
      var response = await client.get(url, headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${MySharedPreference.token}",
      });
      print(response.body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> body = await json.decode(response.body);
        if (response.body.isNotEmpty) {
          if (body["error"] == false) {
            ideaInfoModel = IdeaInfoModel.fromJson(body);
            if (ideaInfoModel.data?.participantInfo?.ideaInfo?.videoFile ==
                    null ||
                ideaInfoModel.data?.participantInfo?.ideaInfo?.videoFile ==
                    "") {
            } else {
              print("xxxxxxxxxxxxxxxxxxx");
              // loadVideo("${Urls.picBaseUrl}public/${ideaInfoModel.data?.participantInfo?.ideaInfo?.videoFile}");
              // demoVideo = "${Urls.picBaseUrl}public/${ideaInfoModel.data?.participantInfo?.ideaInfo?.videoFile}";
              loadVideo("${ideaInfoModel.data?.participantInfo?.ideaInfo?.videoFile}");
              demoVideo = "${ideaInfoModel.data?.participantInfo?.ideaInfo?.videoFile}";
              update();
            }
            // return ideaInfoModel;
          } else {
            // Get.snackbar("Login Message", body["msg"],snackPosition: SnackPosition.BOTTOM);
          }
        }
      } else {
        throw Exception('Failed to load post');
      }
      // return ideaInfoModel;
      changeLoading(false);
    } on Exception catch (e) {
      // return ideaInfoModel;
      changeLoading(false);
    }
  }
}
