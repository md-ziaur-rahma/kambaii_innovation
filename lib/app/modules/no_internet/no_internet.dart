import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'no_internet_controller.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NoInternetController>(
      init: NoInternetController(),
      builder: (controller) {
        return Scaffold(
          body: Center(
            child: GestureDetector(
              onTap: () {
                controller.checkInternet();
              },
              child: controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.wifi_off_sharp,
                          size: 100,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text("No Internet Connection"),
                        SizedBox(
                          height: 8,
                        ),
                        Center(
                            child: Text(
                          "Check Your Internet Connection,\nTry Again",
                          textAlign: TextAlign.center,
                        ))
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}
