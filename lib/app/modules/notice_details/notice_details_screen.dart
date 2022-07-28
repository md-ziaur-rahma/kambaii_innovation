import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:innovation/app/core/values/colors.dart';
import 'package:innovation/app/global_widget/custom_appbar.dart';
import 'package:innovation/app/modules/notice_details/notice_details_controller.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';

import '../../core/utils/urls.dart';
import '../../global_widget/no_image.dart';

class NoticeDetailsScreen extends StatelessWidget {
  const NoticeDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NoticeDetailsController>(
      init: NoticeDetailsController(),
      builder: (controller){
        return Scaffold(
          // appBar: CustomAppBar().simpleAppBar("Notice Details"),
          appBar: AppBar(
            title: const Text("Notice Details",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w400),),
            systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.white,statusBarIconBrightness: Brightness.dark),
            elevation: 0,
            titleSpacing: 0,
            iconTheme: const IconThemeData(color: Colors.black87),
            backgroundColor: Colors.white,
            actions: [

            ],
          ),
          body: CustomScrollView(
            scrollDirection: Axis.vertical,
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(16.0),
                      height: MediaQuery.of(context).orientation == Orientation.portrait ? MediaQuery.of(context).size.width * 0.65 : MediaQuery.of(context).size.height * 1,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: controller.notice.image == null
                            ? const NoImageWidget(text: 'No Image')
                            : OptimizedCacheImage(
                            // imageUrl: "${Urls.picBaseUrl}public/${controller.notice.image!}",
                            imageUrl: "${controller.notice.image!}",
                            imageBuilder:
                                (context, imageProvider) =>
                                Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
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
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                      width: double.infinity,
                      child: Text('${controller.notice.updatedAt}',textAlign: TextAlign.start,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: Colors.black54),),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      width: double.infinity,
                      child: Text('${controller.notice.title}',textAlign: TextAlign.start,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black),),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      height: 16,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      width: double.infinity,
                      child: Text('${controller.notice.description}',
                        textAlign: TextAlign.start,
                        style: const TextStyle(fontSize: 16,fontWeight: FontWeight.normal,color: Colors.black87),),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: IconButton(
                          onPressed: (){
                            controller.noticeController.openFile("${controller.notice.pdf}", null);
                          },
                          icon: Icon(Icons.file_download,color: AppColors.mainColor,),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
