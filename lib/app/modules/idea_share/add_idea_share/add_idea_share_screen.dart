import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:innovation/app/core/values/colors.dart';
import 'package:innovation/app/global_widget/custom_appbar.dart';
import 'package:innovation/app/global_widget/usa_logo_layout.dart';
import 'package:innovation/app/modules/home/home_screen.dart';
import 'package:innovation/app/modules/idea_share/add_idea_share/add_idea_share_controller.dart';
import 'package:innovation/app/routes/routes.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../global_widget/common.dart';

class AddIdeaShareScreen extends StatelessWidget {
  const AddIdeaShareScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: GetBuilder<AddIdeaShareController>(
        init: AddIdeaShareController(),
        builder: (controller){
          return ModalProgressHUD(
            inAsyncCall: controller.isLoading.value,
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.backgroundColor,
                        AppColors.backgroundColor.withOpacity(0.5)
                      ]
                  )
              ),
              child: SafeArea(
                child: CustomScrollView(
                  scrollDirection: Axis.vertical,
                  slivers: [
                    SliverToBoxAdapter(
                      child: CridUsaLogoLayout().cridLogo(150, Alignment.topCenter),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        width: double.infinity,
                        child: const Text("Let's write down your idea*",style: TextStyle(color: Colors.black87,fontSize: 16,fontWeight: FontWeight.w500),),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      sliver: SliverToBoxAdapter(
                        child: TextFormField(
                          controller: controller.ideaTextController,
                          validator: controller.validationIdeaText,
                          cursorColor: Colors.black87,
                          autofocus: false,
                          textInputAction: TextInputAction.next,
                          onSaved: (String? val) {
                            controller.ideaText = val;
                          },
                          maxLines: 5,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                            hintText: '',
                            // hintStyle: const TextStyle(
                            //     color: Colors.black54, fontSize: 18),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(2),
                                borderSide: BorderSide(color: AppColors.mainColor)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide(color: AppColors.mainColor)),
                          ),
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 16,
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 16,
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              textAlign: TextAlign.start,
                              "Your can share your idea by",
                              style: TextStyle(fontSize: 18,
                                  color: Colors.black, fontWeight: FontWeight.w500),
                            )
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 16,
                          runSpacing: 16,
                          children: [
                            IdeaChooseButton(title: "Image",
                              color: Colors.deepOrange,
                              image: "images/photo.png",
                              onPressed: ()async {
                                try {
                                  final result =
                                  await InternetAddress.lookup('example.com');
                                  if (result.isNotEmpty &&
                                      result[0].rawAddress.isNotEmpty) {
                                    controller.pickImages();
                                  } else {
                                    // not connected
                                    Common.toastMsg("No Internet Connection");
                                  }
                                } on SocketException catch (_) {
                                  Common.toastMsg("No Internet Connection");
                                }
                              },),
                            IdeaChooseButton(title: "Pdf/Doc",
                              color: Colors.lightBlue,
                              image: "images/pdf-document.png",
                              onPressed: ()async {
                                try {
                                  final result =
                                  await InternetAddress.lookup('example.com');
                                  if (result.isNotEmpty &&
                                      result[0].rawAddress.isNotEmpty) {
                                    // connected
                                    // controller.openFileExplorer(controller.pdfExtension);
                                    controller.pickPdfFile();
                                    print("${controller.imageFile == null}");
                                  } else {
                                    // not connected
                                    Common.toastMsg("No Internet Connection");
                                  }
                                } on SocketException catch (_) {
                                  Common.toastMsg("No Internet Connection");
                                }
                              },),
                            IdeaChooseButton(title: "Audio",
                              color: Colors.purple,
                              image: "images/podcast.png",
                              onPressed: ()async {
                                try {
                                  final result =
                                  await InternetAddress.lookup('example.com');
                                  if (result.isNotEmpty &&
                                      result[0].rawAddress.isNotEmpty) {
                                    controller.pickAudioFile();
                                  } else {
                                    // not connected
                                    Common.toastMsg("No Internet Connection");
                                  }
                                } on SocketException catch (_) {
                                  Common.toastMsg("No Internet Connection");
                                }
                              },),
                            IdeaChooseButton(title: "Video",
                              color: Colors.deepOrange,
                              image: "images/video-button.png",
                              onPressed: ()async {
                                try {
                                  final result =
                                  await InternetAddress.lookup('example.com');
                                  if (result.isNotEmpty &&
                                      result[0].rawAddress.isNotEmpty) {
                                    controller.pickVideoFile();
                                  } else {
                                    // not connected
                                    Common.toastMsg("No Internet Connection");
                                  }
                                } on SocketException catch (_) {
                                  Common.toastMsg("No Internet Connection");
                                }
                              },),
                          ],
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 16,
                      ),
                    ),
                    // .................. image showing .................
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // .......... Picture ...............
                          LayoutBuilder(
                            builder: (BuildContext context,BoxConstraints constraints){
                              if(controller.imageFile != null){
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
                                  child: Image(image: FileImage(File(controller.imageFile!.path)),height: 300,width: MediaQuery.of(context).size.width - 32,),
                                );
                              }else {
                                return const SizedBox();
                              }
                            },
                          ),
                          // .......... PDF file name...............
                          LayoutBuilder(
                            builder: (BuildContext context,BoxConstraints constraints){
                              if(controller.pdfPlatFormFile != null){
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.picture_as_pdf),
                                      const SizedBox(width: 8,),
                                      Expanded(child: Text("${controller.pdfPlatFormFile?.name}",style: const TextStyle(fontSize: 18),)),
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: (){
                                          controller.pdfPlatFormFile = null;
                                          controller.update();
                                        },
                                        child: const Icon(Icons.close),
                                      ),
                                    ],
                                  ),
                                );
                              }else {
                                return const SizedBox();
                              }
                            },
                          ),
                          // .......... Audio file name...............
                          LayoutBuilder(
                            builder: (BuildContext context,BoxConstraints constraints){
                              if(controller.audioPlatFormFile != null){
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.audio_file),
                                      const SizedBox(width: 8,),
                                      Expanded(child: Text("${controller.audioPlatFormFile?.name}",style: const TextStyle(fontSize: 18),)),
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: (){
                                          controller.audioPlatFormFile = null;
                                          controller.update();
                                        },
                                        child: const Icon(Icons.close),
                                      ),
                                    ],
                                  ),
                                );
                              }else {
                                return const SizedBox();
                              }
                            },
                          ),
                          // .......... Video file name...............
                          LayoutBuilder(
                            builder: (BuildContext context,BoxConstraints constraints){
                              if(controller.videoPlatFormFile != null){
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.videocam),
                                      const SizedBox(width: 8,),
                                      Expanded(
                                        child: Text("${controller.videoPlatFormFile?.name}"
                                          ,style: const TextStyle(fontSize: 18),),
                                      ),
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: (){
                                          controller.videoPlatFormFile = null;
                                          controller.update();
                                        },
                                        child: const Icon(Icons.close),
                                      ),
                                    ],
                                  ),
                                );
                              }else {
                                return const SizedBox();
                              }
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: GetBuilder<AddIdeaShareController>(
        builder: (controller){
          return Container(
            height: 65,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(color: const Color(0xFFFFFFFF), boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  offset: const Offset(0, 5),
                  blurRadius: 6),
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  offset: const Offset(10, 0),
                  blurRadius: 6),
            ]),
            child: Container(
              width: double.infinity,
              height: 45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                      end: Alignment.centerRight,
                      begin: Alignment.centerLeft,
                      colors: [
                        // Colors.orange,
                        // Colors.deepOrange,
                        AppColors.mainColor.withOpacity(0.8),
                        AppColors.mainColor,
                      ])),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: AppColors.mainColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6))),
                  onPressed: () {
                    if(controller.ideaTextController.text.isEmpty){
                      Common.toastMsg("Please write your idea in text");
                    } else {
                      // controller.submitIdea();
                      controller.submitIdeaMultipart();
                    }

                  },
                  child: const Text(
                    "Submit",
                    style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                  )),
            ),
          );
        },
      ),
    );
  }
}

class IdeaChooseButton extends StatelessWidget {
  const IdeaChooseButton({Key? key, required this.title, required this.color, required this.image, required this.onPressed}) : super(key: key);

  final String title;
  final Color color;
  final String image;
  final Function onPressed;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Material(
          color: color.withOpacity(0.1),
          shape: const CircleBorder(),
          child: InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: (){
              onPressed();
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Image(
                image: AssetImage(image),
                height: 35,
                width: 35,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        Text(title)
      ],
    );
  }
}

