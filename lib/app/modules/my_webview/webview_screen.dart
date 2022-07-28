import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:innovation/app/modules/my_webview/webview_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebViewScreen extends StatelessWidget {
  const MyWebViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyWebViewController>(
      init: MyWebViewController(),
      builder: (controller){
        return Scaffold(
          body: SafeArea(
            child: WillPopScope(
              onWillPop: () => controller.onWillPop(context),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  LayoutBuilder(
                      builder: (context,constraints){
                        if (controller.progressValue == 100) {
                          return const SizedBox(
                            height: 0,
                          );
                        }  else {
                          return SizedBox(
                            width: double.infinity,
                            height: 3,
                            child: LinearProgressIndicator(
                              value: controller.progressValue/100,
                              minHeight: 3,
                              backgroundColor : Colors.grey,
                              valueColor: const AlwaysStoppedAnimation<Color>(Colors.deepOrange,),
                            ),
                            // return const SizedBox(
                            //   width: 16,
                            //   height: 16,
                            //   child: Center(
                            //     child: CircularProgressIndicator(
                            //       strokeWidth: 2,
                            //       color: Colors.deepOrange,
                            //     ),
                            //   )
                          );
                        }
                      }
                  ),
                  Expanded(
                    child: WebView(
                      javascriptMode: JavascriptMode.unrestricted,
                      initialUrl: controller.url,
                      onWebViewCreated: (WebViewController webViewController) {
                        controller.controllerCompleter.future.then((value) => controller.webViewController = value);
                        controller.controllerCompleter.complete(webViewController);
                      },
                      onProgress: (int progress) {
                        controller.changeProgressValue(progress.toDouble());
                      },

                      javascriptChannels: <JavascriptChannel>{
                        controller.toasterJavascriptChannel(context),
                      },

                      navigationDelegate: (NavigationRequest request) {
                        // ................
                        // var uri = Uri.dataFromString(request.url);
                        // Map<String, String> params = uri.queryParameters;
                        // var transaction = params['billplz%5Btransaction_status%5D'];
                        // var paid = params["billplz%5Bpaid%5D"];
                        // print('transaction : $transaction');
                        // print('paid : $paid');
                        // if (transaction == 'completed' || paid == 'true') {
                        //   Navigator.push(context, OrderListPage.route());
                        //   // Navigator.pop(context);
                        //   return NavigationDecision.navigate;
                        // } else if (transaction == 'failed' || paid == 'false') {
                        //   Common.toastMsg('Payment unsuccessful!');
                        //   Navigator.push(context, HomePage.route());
                        //   // Navigator.pop(context);
                        //   return NavigationDecision.navigate;
                        // }
                        // ................
                        // print('allowing navigation to $request');
                        return NavigationDecision.navigate;
                      },
                      onPageStarted: (String url) {
                        // print('Page started loading: $url');
                      },
                      onPageFinished: (String url) {
                        // print('Page finished loading: $url');
                      },
                      gestureNavigationEnabled: true,
                    ),
                  )
                ],
              ),
            )
          ),
        );
      },
    );
  }
}
