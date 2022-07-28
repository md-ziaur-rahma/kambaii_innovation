import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:innovation/app/global_widget/no_image.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';

class ShowImage extends StatefulWidget {
  const ShowImage({Key? key}) : super(key: key);

  @override
  ShowImageState createState() => ShowImageState();
}

class ShowImageState extends State<ShowImage> {
  String image = "";
  @override
  void initState() {
    var arguments = Get.arguments;
    image = arguments["image"];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF28282B),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
        systemOverlayStyle: Platform.isIOS
            ? SystemUiOverlayStyle.dark
            : const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark),
      ),
      // backgroundColor: Colors.white.withOpacity(0.3),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 1,
              child: InteractiveViewer(
                constrained: true,
                scaleEnabled: true,
                maxScale: 3,
                minScale: 1,
                boundaryMargin: const EdgeInsets.all(8),
                child: Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          color: Colors.transparent),
                      height: double.infinity,
                      width: double.infinity,
                      child: Center(
                        child: OptimizedCacheImage(
                            imageUrl: image,
                            imageBuilder:
                                (context, imageProvider) =>
                                Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      // fit: BoxFit.cover,
                                      // colorFilter: ColorFilter.mode(Colors.transparent, BlendMode.clear)
                                    ),
                                  ),
                                ),
                            placeholder: (context, url) =>
                            const Center(
                              child: SizedBox(
                                height: 16,
                                width: 16,
                                child:
                                CircularProgressIndicator(
                                  strokeWidth: 2.0,
                                  valueColor:
                                  AlwaysStoppedAnimation(
                                      Color(0xFFF68721)),
                                ),
                              ),
                            ),
                            errorWidget:
                                (context, url, error) =>
                            const NoImageWidget(text: 'No Image')
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}