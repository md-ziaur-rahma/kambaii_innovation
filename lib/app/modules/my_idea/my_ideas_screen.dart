import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:innovation/app/global_widget/common.dart';
import 'package:innovation/app/global_widget/custom_appbar.dart';
import 'package:innovation/app/global_widget/floating_back.dart';
import 'package:innovation/app/modules/my_idea/my_ideas_controller.dart';
import 'package:innovation/app/routes/routes.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:video_player/video_player.dart';

import '../../core/utils/urls.dart';
import '../../data/models/idea_info_model.dart';
import '../../global_widget/no_image.dart';

class MyIdeasScreen extends StatelessWidget {
  MyIdeasScreen({Key? key}) : super(key: key);

  // final ideasController = Get.put(MyIdeasController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyIdeasController>(
      init: MyIdeasController(),
      builder: (controller) {
        return ModalProgressHUD(
          inAsyncCall: controller.isLoading.value,
          child: Scaffold(
            appBar: CustomAppBar().simpleAppBar("My Ideas"),
            body: SafeArea(
              child: CustomScrollView(
                scrollDirection: Axis.vertical,
                slivers: [
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 16,
                    ),
                  ),

                  SliverLayoutBuilder(
                    builder: (BuildContext context,SliverConstraints constraints){
                      if(!controller.isLoading.value){
                        return SliverToBoxAdapter(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //.......... Text idea and image............
                              ClipRRect(
                                  clipBehavior: Clip.none,
                                  borderRadius: BorderRadius.circular(16),
                                  child: Container(
                                    width: double.infinity,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 0),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 16),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                            color: Colors.transparent)),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: double.infinity,
                                          child: Text(
                                            "${controller.ideaInfoModel.data?.participantInfo?.ideaInfo?.ideaDetails}",
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                                color: Colors.black87,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: (){
                                            // Get.toNamed(Routes.IMAGE_SHOW,arguments: {"image": "${Urls.picBaseUrl}public/${controller.ideaInfoModel.data?.participantInfo!.ideaInfo!.imageFile!}"});
                                            Get.toNamed(Routes.IMAGE_SHOW,arguments: {"image": "${controller.ideaInfoModel.data?.participantInfo!.ideaInfo!.imageFile!}"});
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.all(16.0),
                                            height: MediaQuery.of(context)
                                                .orientation ==
                                                Orientation.portrait
                                                ? MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.85
                                                : MediaQuery.of(context)
                                                .size
                                                .height *
                                                1,
                                            width: double.infinity,
                                            child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(8.0),
                                              child: controller.ideaInfoModel.data?.participantInfo
                                                  ?.ideaInfo
                                                  ?.imageFile ==
                                                  null
                                                  ? const NoImageWidget(
                                                  text: 'No Image')
                                                  : OptimizedCacheImage(
                                                  // imageUrl: "${Urls.picBaseUrl}public/${controller.ideaInfoModel.data?.participantInfo!.ideaInfo!.imageFile!}",
                                                  imageUrl: "${controller.ideaInfoModel.data?.participantInfo!.ideaInfo!.imageFile!}",
                                                  imageBuilder: (context,
                                                      imageProvider) =>
                                                      Container(
                                                        decoration:
                                                        BoxDecoration(
                                                          image:
                                                          DecorationImage(
                                                            image:
                                                            imageProvider,
                                                            fit: BoxFit
                                                                .contain,
                                                            // colorFilter: ColorFilter.mode(Colors.transparent, BlendMode.clear)
                                                          ),
                                                        ),
                                                      ),
                                                  placeholder: (context,
                                                      url) =>
                                                  const Center(
                                                    child: SizedBox(
                                                      height: 16,
                                                      width: 16,
                                                      child:
                                                      CircularProgressIndicator(
                                                        strokeWidth: 2.0,
                                                        valueColor:
                                                        AlwaysStoppedAnimation(
                                                            Color(
                                                                0xFFF68721)),
                                                      ),
                                                    ),
                                                  ),
                                                  errorWidget: (context, url,
                                                      error) =>
                                                  const NoImageWidget(
                                                      text: 'No Image')),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                              //.......... video ............
                              ClipRRect(
                                  clipBehavior: Clip.none,
                                  borderRadius: BorderRadius.circular(16),
                                  child: Container(
                                    width: double.infinity,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 16),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                            color: Colors.transparent)),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          width: double.infinity,
                                          child: Text(
                                            "Video",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        LayoutBuilder(
                                          builder: (BuildContext context, BoxConstraints constraints){
                                            if(controller.ideaInfoModel.data?.participantInfo?.ideaInfo?.videoFile == null
                                                || controller.ideaInfoModel.data?.participantInfo?.ideaInfo?.videoFile == ""){
                                              return const Center(
                                                child: NoImageWidget(
                                                    text: 'No Video'),
                                              );
                                            } else {
                                              return Container(
                                                margin: const EdgeInsets.all(16.0),
                                                height: MediaQuery.of(context)
                                                    .orientation ==
                                                    Orientation.portrait
                                                    ? MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.6
                                                    : MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    1,
                                                width: double.infinity,
                                                child: Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                      BorderRadius.circular(4.0),
                                                      child: controller
                                                          .videoPlayerController
                                                          .value
                                                          .isInitialized
                                                          ? AspectRatio(
                                                        aspectRatio: controller
                                                            .videoPlayerController
                                                            .value
                                                            .aspectRatio,
                                                        child: VideoPlayer(controller
                                                            .videoPlayerController),
                                                      )
                                                          : const Center(
                                                        child: SizedBox(
                                                            height: 24,
                                                            width: 24,
                                                            child: CircularProgressIndicator()),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment: Alignment.topRight,
                                                      child: Material(
                                                        color: Colors.orange,
                                                        shape: const CircleBorder(),
                                                        child: InkWell(
                                                          borderRadius: BorderRadius.circular(50),
                                                          onTap: (){
                                                            if(controller.videoPlayerController.value.isPlaying){
                                                              controller.videoPlayerController.pause();
                                                            }else {
                                                              controller.videoPlayerController.play();
                                                            }
                                                            controller.update();
                                                          },
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(10),
                                                            child: Icon(controller.videoPlayerController.value.isPlaying? Icons.pause : Icons.play_arrow,color: Colors.white,),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            }
                                          },
                                        )

                                      ],
                                    ),
                                  )),
                              //.......... pdf ............
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8),
                                child: Material(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(16),
                                    onTap: () {
                                      // Get.toNamed(Routes.WEBVIEW,arguments: {"url": "${Urls.picBaseUrl}public/${controller.ideaInfoModel.data?.participantInfo?.ideaInfo?.pdfFile}"});
                                      if (controller.ideaInfoModel.data?.participantInfo?.ideaInfo?.pdfFile == null || controller
                                              .ideaInfoModel
                                              .data
                                              ?.participantInfo
                                              ?.ideaInfo
                                              ?.pdfFile ==
                                              "") {
                                        Common.toastMsg(
                                            "You do not submitted any pdf file");
                                      } else {
                                        // controller.createFileOfPdfUrl("${Urls.picBaseUrl}public/${controller.ideaInfoModel.data?.participantInfo?.ideaInfo?.pdfFile}").then((value) {
                                        controller.createFileOfPdfUrl("${controller.ideaInfoModel.data?.participantInfo?.ideaInfo?.pdfFile}").then((value) {
                                          Get.toNamed(Routes.PDF_DOCUMENT,
                                              arguments: {"path": value.path});
                                        });
                                      }
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 16),
                                      child: Row(
                                        children: const [
                                          Image(
                                            image: AssetImage(
                                                "images/pdf-document.png"),
                                            height: 24,
                                            width: 24,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text("Show PDF Document",style: TextStyle(color: Colors.black87,fontSize: 16,fontWeight: FontWeight.w500),),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              //.......... Audio ............
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8),
                                child: Material(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(16),
                                    onTap: () {

                                    },
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 16),
                                      child: Row(
                                        children: [
                                          const Image(
                                            image: AssetImage(
                                                "images/podcast.png"),
                                            height: 24,
                                            width: 24,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text("Play Audio",style: TextStyle(color: Colors.black87,fontSize: 16,
                                              fontWeight: FontWeight.w500),),
                                          const Spacer(),
                                          Material(
                                            color: Colors.orange,
                                            shape: const CircleBorder(),
                                            child: InkWell(
                                              borderRadius: BorderRadius.circular(50),
                                              onTap: (){
                                                if (controller.ideaInfoModel.data?.participantInfo?.ideaInfo?.audioFile == null || controller
                                                    .ideaInfoModel
                                                    .data
                                                    ?.participantInfo
                                                    ?.ideaInfo
                                                    ?.audioFile ==
                                                    "") {
                                                  Common.toastMsg(
                                                      "You have not any audio file");
                                                } else {
                                                  if(controller.isPlaying.value == 1){
                                                    // controller.playMusic("${Urls.picBaseUrl}public/${controller.ideaInfoModel.data?.participantInfo?.ideaInfo?.audioFile}");
                                                    controller.playMusic("${controller.ideaInfoModel.data?.participantInfo?.ideaInfo?.audioFile}");
                                                  }else {
                                                    controller.pauseAudio();
                                                  }
                                                }
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.all(10),
                                                child: Icon(controller.isPlaying.value == 2 ? Icons.pause : Icons.play_arrow,color: Colors.white,),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              //.......... personal info .............
                              ClipRRect(
                                  clipBehavior: Clip.none,
                                  borderRadius: BorderRadius.circular(16),
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 16),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: double.infinity,
                                          child: Text(
                                            "${controller.ideaInfoModel.data?.profileInfo?.name}",
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                                color: Colors.black87,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Expanded(
                                              flex: 1,
                                              child: Text(
                                                "Mobile",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w400),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                ":  ${controller.ideaInfoModel.data?.profileInfo?.mobile}",
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w400),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Expanded(
                                              flex: 1,
                                              child: Text(
                                                "Email",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w400),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                ":  ${controller.ideaInfoModel.data?.profileInfo?.email}",
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w400),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Expanded(
                                              flex: 1,
                                              child: Text(
                                                "Date of Birth",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w400),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                ":  ${controller.ideaInfoModel.data?.profileInfo?.dateOfBirth}",
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w400),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                              //.......... team info .............
                              LayoutBuilder(
                                builder: (BuildContext context,
                                    BoxConstraints constraints) {
                                  if (controller.ideaInfoModel.data?.participantInfo
                                      ?.teamInfo?.regType ==
                                      "individual") {
                                    return const SizedBox();
                                  } else {
                                    return ClipRRect(
                                        clipBehavior: Clip.none,
                                        borderRadius: BorderRadius.circular(16),
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 8),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 16),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                            BorderRadius.circular(16),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                width: double.infinity,
                                                child: Text(
                                                  "Team Information",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 16,
                                                      fontWeight:
                                                      FontWeight.w500),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 6,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  const Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      "Team Name",
                                                      textAlign:
                                                      TextAlign.start,
                                                      style: TextStyle(
                                                          color: Colors.black87,
                                                          fontSize: 15,
                                                          fontWeight:
                                                          FontWeight.w400),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                      ": ${controller.ideaInfoModel.data?.participantInfo?.teamInfo?.teamName}",
                                                      textAlign:
                                                      TextAlign.start,
                                                      style: const TextStyle(
                                                          color: Colors.black87,
                                                          fontSize: 15,
                                                          fontWeight:
                                                          FontWeight.w400),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  const Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      "Member 2",
                                                      textAlign:
                                                      TextAlign.start,
                                                      style: TextStyle(
                                                          color: Colors.black87,
                                                          fontSize: 15,
                                                          fontWeight:
                                                          FontWeight.w400),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                      ": ${controller.ideaInfoModel.data?.participantInfo?.teamInfo?.member2}",
                                                      textAlign:
                                                      TextAlign.start,
                                                      style: const TextStyle(
                                                          color: Colors.black87,
                                                          fontSize: 15,
                                                          fontWeight:
                                                          FontWeight.w400),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  const Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      "Contact 2",
                                                      textAlign:
                                                      TextAlign.start,
                                                      style: TextStyle(
                                                          color: Colors.black87,
                                                          fontSize: 15,
                                                          fontWeight:
                                                          FontWeight.w400),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                      ": ${controller.ideaInfoModel.data?.participantInfo?.teamInfo?.contact2}",
                                                      textAlign:
                                                      TextAlign.start,
                                                      style: const TextStyle(
                                                          color: Colors.black87,
                                                          fontSize: 15,
                                                          fontWeight:
                                                          FontWeight.w400),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  const Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      "Member 3",
                                                      textAlign:
                                                      TextAlign.start,
                                                      style: TextStyle(
                                                          color: Colors.black87,
                                                          fontSize: 15,
                                                          fontWeight:
                                                          FontWeight.w400),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                      ": ${controller.ideaInfoModel.data?.participantInfo?.teamInfo?.member3}",
                                                      textAlign:
                                                      TextAlign.start,
                                                      style: const TextStyle(
                                                          color: Colors.black87,
                                                          fontSize: 15,
                                                          fontWeight:
                                                          FontWeight.w400),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  const Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      "Contact 3",
                                                      textAlign:
                                                      TextAlign.start,
                                                      style: TextStyle(
                                                          color: Colors.black87,
                                                          fontSize: 15,
                                                          fontWeight:
                                                          FontWeight.w400),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                      ": ${controller.ideaInfoModel.data?.participantInfo?.teamInfo?.contact3}",
                                                      textAlign:
                                                      TextAlign.start,
                                                      style: const TextStyle(
                                                          color: Colors.black87,
                                                          fontSize: 15,
                                                          fontWeight:
                                                          FontWeight.w400),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ));
                                  }
                                },
                              ),
                              //.......... Address info .............
                              ClipRRect(
                                  clipBehavior: Clip.none,
                                  borderRadius: BorderRadius.circular(16),
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 16),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: double.infinity,
                                          child: Text(
                                            "Address Information",
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                                color: Colors.black87,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                "Division",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w400),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                ": ${controller.ideaInfoModel.data?.participantInfo?.addressInfo?.division}",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w400),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Expanded(
                                              flex: 1,
                                              child: Text(
                                                "District",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w400),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                ": ${controller.ideaInfoModel.data?.participantInfo?.addressInfo?.district}",
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w400),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Expanded(
                                              flex: 1,
                                              child: Text(
                                                "Upazila",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w400),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                ": ${controller.ideaInfoModel.data?.participantInfo?.addressInfo?.upozila}",
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w400),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Expanded(
                                              flex: 1,
                                              child: Text(
                                                "Union",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w400),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                ": ${controller.ideaInfoModel.data?.participantInfo?.addressInfo?.unions}",
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w400),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                              //.......... Guardian.............
                              ClipRRect(
                                  clipBehavior: Clip.none,
                                  borderRadius: BorderRadius.circular(16),
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 16),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          width: double.infinity,
                                          child: Text(
                                            "Guardian Information",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Expanded(
                                              flex: 1,
                                              child: Text(
                                                "Guardian",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w400),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                ": ${controller.ideaInfoModel.data?.participantInfo?.guardianInfo?.parentName}",
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w400),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Expanded(
                                              flex: 1,
                                              child: Text(
                                                "Relation",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w400),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                ": ${controller.ideaInfoModel.data?.participantInfo?.guardianInfo?.relation}",
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w400),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Expanded(
                                              flex: 1,
                                              child: Text(
                                                "NID/Passport",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w400),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                ": ${controller.ideaInfoModel.data?.participantInfo?.guardianInfo?.nidPassport}",
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w400),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Expanded(
                                              flex: 1,
                                              child: Text(
                                                "Mobile",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w400),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                ": ${controller.ideaInfoModel.data?.participantInfo?.guardianInfo?.pMobile}",
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w400),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Expanded(
                                              flex: 1,
                                              child: Text(
                                                "Address",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w400),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                ": ${controller.ideaInfoModel.data?.participantInfo?.guardianInfo?.pAddress}",
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w400),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                              // ..........institution info .............
                              ClipRRect(
                                  clipBehavior: Clip.none,
                                  borderRadius: BorderRadius.circular(16),
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 16),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          width: double.infinity,
                                          child: Text(
                                            "Institution Information",
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                                color: Colors.black87,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Expanded(
                                              flex: 1,
                                              child: Text(
                                                "School",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w400),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                ": ${controller.ideaInfoModel.data?.participantInfo?.institutonInfo?.schoolName}",
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w400),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Expanded(
                                              flex: 1,
                                              child: Text(
                                                "Roll No",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w400),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                ": ${controller.ideaInfoModel.data?.participantInfo?.institutonInfo?.institutionInfoClass}",
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w400),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Expanded(
                                              flex: 1,
                                              child: Text(
                                                "Group",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w400),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                ": ${controller.ideaInfoModel.data?.participantInfo?.institutonInfo?.group}",
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w400),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Expanded(
                                              flex: 1,
                                              child: Text(
                                                "P Group",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w400),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                ": ${controller.ideaInfoModel.data?.participantInfo?.institutonInfo?.pGroup}",
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w400),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                              const SizedBox(
                                height: 70,
                              )
                            ],
                          ),
                        );
                      }else {
                        return const SliverToBoxAdapter(
                          child: SizedBox(
                            height: 16,
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.startFloat,
            floatingActionButton: const FloatingBack(),
          ),
        );
      },
    );
  }
}
