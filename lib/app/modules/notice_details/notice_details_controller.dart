import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:innovation/app/data/models/notice_model.dart';
import 'package:innovation/app/modules/notice/notice_controller.dart';

class NoticeDetailsController extends GetxController {
  var isLoading = false.obs;
  Client client = Client();
  Notice notice = Notice();

  final noticeController = Get.put(NoticeController());

  @override
  void onInit() {
    var arguments = Get.arguments;
    notice = arguments["notice"];
    super.onInit();
  }

  @override
  void onClose() {
    client.close();
    super.onClose();
  }
}