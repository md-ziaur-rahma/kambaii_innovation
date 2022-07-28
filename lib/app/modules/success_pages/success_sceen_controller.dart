import 'package:get/get.dart';
import 'package:innovation/app/routes/routes.dart';

class SuccessScreenController extends GetxController {
  var message = "";
  @override
  void onInit(){
    var arguments = Get.arguments;
    message = arguments["msg"];
    Future.delayed(const Duration(milliseconds: 1000)).then((value) {
      Get.offAllNamed(Routes.HOME);
    });
    super.onInit();
  }
}