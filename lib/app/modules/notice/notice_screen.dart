import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:innovation/app/core/utils/urls.dart';
import 'package:innovation/app/core/values/colors.dart';
import 'package:innovation/app/data/models/notice_model.dart';
import 'package:innovation/app/global_widget/common.dart';
import 'package:innovation/app/global_widget/custom_appbar.dart';
import 'package:innovation/app/global_widget/no_image.dart';
import 'package:innovation/app/modules/notice/notice_controller.dart';
import 'package:innovation/app/routes/routes.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';

class NoticeScreen extends StatelessWidget {
  const NoticeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NoticeController>(
      init: NoticeController(),
      builder: (controller){
        return ModalProgressHUD(
          inAsyncCall: controller.isLoading.value,
          child: Scaffold(
            appBar: CustomAppBar().simpleAppBar("Noticeboard"),
            body: SafeArea(
              child: CustomScrollView(
                scrollDirection: Axis.vertical,
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                      child: SizedBox(
                        width: double.infinity,
                        child: Text("Important Notice for All Students and Teachers",style: TextStyle(
                          color: AppColors.mainColorBlack,fontSize: 18,fontWeight: FontWeight.w500
                        ),),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 0),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                          (BuildContext context,int index){
                            return BlogMaterialCard(index: index,);
                            // return Container(
                            //   padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            //   margin: const EdgeInsets.symmetric(horizontal: 0,vertical: 8),
                            //   decoration: BoxDecoration(
                            //     color: Colors.white,
                            //     borderRadius: BorderRadius.circular(4),
                            //     // image: const DecorationImage(
                            //     //   alignment: Alignment.center,
                            //     //   opacity: 0.2,
                            //     //   image: AssetImage("images/blue_back.jpg"),
                            //     //   fit: BoxFit.cover
                            //     // )
                            //   ),
                            //   child: Column(
                            //     mainAxisAlignment: MainAxisAlignment.start,
                            //     mainAxisSize: MainAxisSize.min,
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       const SizedBox(
                            //         width: double.infinity,
                            //         child: Text("CRID USA Next Robotics Competition held on 26th July.",
                            //         style: TextStyle(color: Colors.black87,fontSize: 15,fontWeight: FontWeight.w500),),
                            //       ),
                            //       Row(
                            //         mainAxisSize: MainAxisSize.max,
                            //         children: [
                            //           const Text("2022-06-05",
                            //             style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w400),),
                            //           const Spacer(),
                            //           GestureDetector(
                            //             onTap: (){
                            //               Common.toastMsg("Downling link");
                            //             },
                            //             child: Column(
                            //               mainAxisSize: MainAxisSize.min,
                            //               crossAxisAlignment: CrossAxisAlignment.center,
                            //               children: const[
                            //                 Image(
                            //                   image: AssetImage("images/pdf_file.png"),
                            //                   height: 35,
                            //                   width: 35,
                            //                 ),
                            //                 Text("Download it",style: TextStyle(color: Colors.blue),)
                            //               ],
                            //             ),
                            //           )
                            //         ],
                            //       )
                            //     ],
                            //   ),
                            // );
                          },childCount: controller.noticeList.length
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class BlogMaterialCard extends StatelessWidget {
  BlogMaterialCard({Key? key,required this.index}) : super(key: key);
  final int index;

  final Shader linearGradient = const LinearGradient(
    // colors: <Color>[Color(0xffDA44bb), Color(0xff8921aa)],
    colors: <Color>[Color(0xffff0080), Color(0xff8928ca)],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NoticeController>(
      builder: (controller){
        return Card(
          color: Colors.white,
          elevation: 4,
          shadowColor: Colors.black12,
          margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(16.0),
                height: MediaQuery.of(context).orientation == Orientation.portrait ? MediaQuery.of(context).size.width * 0.65 : MediaQuery.of(context).size.height * 1,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: controller.noticeList[index].image == null
                      ? const NoImageWidget(text: 'No Image')
                      : OptimizedCacheImage(
                    // imageUrl: "${Urls.picBaseUrl}public/${controller.noticeList[index].image!}",
                    imageUrl: "${controller.noticeList[index].image!}",
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
                margin: const EdgeInsets.symmetric(horizontal: 16),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Notice',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,foreground: Paint()..shader = linearGradient),),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: (){
                          // controller.openFile("${Urls.picBaseUrl}public/${controller.noticeList[index].pdf}",null);
                          controller.openFile("${controller.noticeList[index].pdf}",null);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8),
                          child: Icon(Icons.download,color: Colors.lightBlue,),
                        ),
                      ),
                    )
                  ],
                ),
              ),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                width: double.infinity,
                child: Text('${controller.noticeList[index].title}',textAlign: TextAlign.start,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black),),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                width: double.infinity,
                child: Text('${controller.noticeList[index].updatedAt}',textAlign: TextAlign.start,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: Colors.black54),),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                height: 16,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: OutlinedButton(
                    onPressed: (){
                      Get.toNamed(Routes.NOTICE_DETAILS,arguments: {"notice": controller.noticeList[index]});
                    },
                    style: OutlinedButton.styleFrom(side: const BorderSide(width: 1.0, color: Color(0xff8928ca)),),
                    child: Text('READ MORE',style: TextStyle(foreground: Paint()..shader = linearGradient,fontSize: 14),),
                  ),
                ),
              ),
              const SizedBox(height: 12,)
            ],
          ),
        );
      },
    );
  }
}

