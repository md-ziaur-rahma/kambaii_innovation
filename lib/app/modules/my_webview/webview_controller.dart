import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebViewController extends GetxController {
  double progressValue = 0;

  void changeProgressValue(double value){
    progressValue = value;
    update();
  }

  String url = "";
  late WebViewController webViewController;
  final Completer<WebViewController> controllerCompleter = Completer<WebViewController>();

  @override
  void onInit() {
    var argumentData = Get.arguments;
    url = argumentData["url"];
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    super.onInit();
  }

  JavascriptChannel toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          // ignore: deprecated_member_use
          // print('${message.message}');
        });
  }

  Future<bool> onWillPop(BuildContext context) async {
    if (await webViewController.canGoBack()) {
      webViewController.goBack();
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}