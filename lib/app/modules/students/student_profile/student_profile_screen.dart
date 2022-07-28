import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:innovation/app/modules/students/student_profile/student_profile_controller.dart';
import 'package:innovation/app/routes/routes.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../core/values/colors.dart';
import '../../../global_widget/custom_appbar.dart';

class StudentProfileScreen extends StatelessWidget {
  const StudentProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red,
      appBar: CustomAppBar().simpleAppBar("Profile Details"),
      body: SafeArea(
        child: GetBuilder<StudentProfileController>(
          init: StudentProfileController(),
          builder: (controller) {
            return ModalProgressHUD(
              inAsyncCall: controller.isLoading.value,
              child: CustomScrollView(
                scrollDirection: Axis.vertical,
                slivers: [
                  SliverToBoxAdapter(
                    child: ClipRRect(
                      clipBehavior: Clip.none,
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            // Align(
                            //   alignment: Alignment.topRight,
                            //   child: Material(
                            //     color: AppColors.mainColor.withOpacity(0.03),
                            //     borderRadius: BorderRadius.circular(6),
                            //     child: InkWell(
                            //       borderRadius: BorderRadius.circular(6),
                            //       onTap: (){
                            //         Get.toNamed(Routes.STUDENT_PROFILE_UPDATE);
                            //       },
                            //       child: Padding(
                            //         padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 6),
                            //         child: Text("Edit",style: TextStyle(color: AppColors.mainColor,
                            //           // decoration: TextDecoration.underline
                            //         ),),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            SizedBox(
                              width: double.infinity,
                              child: Text("${controller.homeController.getUserType()} Information",textAlign: TextAlign.start,style: TextStyle(color: Colors.black87,fontSize: 18,fontWeight: FontWeight.w500),),
                            ),
                            const Divider(
                              height: 30,
                            ),
                            // CircleAvatar(
                            //   radius: 50,
                            //   backgroundImage: AssetImage("images/${controller.homeController.getUserTypePic()}.png"),
                            // ),
                            const SizedBox(
                              height: 8,
                            ),
                            // SizedBox(
                            //   width: double.infinity,
                            //   child: Text(controller.participantDataModel.data?.email ?? "",textAlign: TextAlign.center,),
                            // ),
                            // const SizedBox(
                            //   height: 6,
                            // ),
                            // SizedBox(
                            //   width: double.infinity,
                            //   child: Text(controller.participantDataModel.data?.mobile ?? "",textAlign: TextAlign.center,),
                            // ),
                            SizedBox(
                              width: double.infinity,
                              child: Text(controller.participantDataModel.data?.name ?? "",textAlign: TextAlign.start,style: TextStyle(color: Colors.black87,fontSize: 16,fontWeight: FontWeight.w500),),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Text(controller.participantDataModel.data?.email ?? "",textAlign: TextAlign.start,style: TextStyle(color: Colors.black87,fontSize: 15,fontWeight: FontWeight.w400),),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Text(controller.participantDataModel.data?.mobile ?? "",textAlign: TextAlign.start,style: TextStyle(color: Colors.black87,fontSize: 15,fontWeight: FontWeight.w400),),
                            ),
                            LayoutBuilder(
                              builder: (BuildContext context, BoxConstraints constraints){
                                if(controller.homeController.typeOfUser == 1){
                                  return SizedBox(
                                    width: double.infinity,
                                    child: Text("Date of birth : ${controller.participantDataModel.data?.dateOfBirth}",textAlign: TextAlign.start,
                                      style: const TextStyle(color: Colors.black87,fontSize: 14,fontWeight: FontWeight.w400),),
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              },
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Text("Type of user : ${controller.participantDataModel.data?.type}",textAlign: TextAlign.start,
                                style: const TextStyle(color: Colors.black87,fontSize: 14,fontWeight: FontWeight.w400),),
                            ),
                          ],
                        ),
                      )
                    ),
                  ),
                  // SliverToBoxAdapter(
                  //   child: ClipRRect(
                  //       clipBehavior: Clip.none,
                  //       borderRadius: BorderRadius.circular(16),
                  //       child: Container(
                  //         margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 0),
                  //         padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                  //         decoration: BoxDecoration(
                  //           color: Colors.white,
                  //           borderRadius: BorderRadius.circular(16),
                  //         ),
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Row(
                  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 Column(
                  //                   crossAxisAlignment: CrossAxisAlignment.start,
                  //                   mainAxisSize: MainAxisSize.min,
                  //                   mainAxisAlignment: MainAxisAlignment.start,
                  //                   children: [
                  //                     Text("${controller.participantDataModel.data?.parentName}",textAlign: TextAlign.start,
                  //                       style: const TextStyle(color: Colors.black87,fontSize: 15,fontWeight: FontWeight.w400),),
                  //                     const SizedBox(
                  //                       height: 6,
                  //                     ),
                  //                     Text("${controller.participantDataModel.data?.relation}",textAlign: TextAlign.start,
                  //                       style: const TextStyle(color: Colors.black87,fontSize: 15,fontWeight: FontWeight.w400),),
                  //                   ],
                  //                 ),
                  //                 // Material(
                  //                 //   color: AppColors.mainColor.withOpacity(0.03),
                  //                 //   borderRadius: BorderRadius.circular(6),
                  //                 //   child: InkWell(
                  //                 //     borderRadius: BorderRadius.circular(6),
                  //                 //     onTap: (){
                  //                 //       Get.toNamed(Routes.ADD_GUARDIAN,arguments: {"title": "Update Guardian",});
                  //                 //     },
                  //                 //     child: Padding(
                  //                 //       padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 6),
                  //                 //       child: Text("Edit",style: TextStyle(color: AppColors.mainColor,
                  //                 //         // decoration: TextDecoration.underline
                  //                 //       ),),
                  //                 //     ),
                  //                 //   ),
                  //                 // ),
                  //               ],
                  //             ),
                  //             const SizedBox(
                  //               height: 10,
                  //             ),
                  //             SizedBox(
                  //               width: double.infinity,
                  //               child: Text("NID : ${controller.participantDataModel.data?.nidPassport}",textAlign: TextAlign.start,
                  //                 style: const TextStyle(color: Colors.black87,fontSize: 15,fontWeight: FontWeight.w400),),
                  //             ),
                  //             SizedBox(
                  //               width: double.infinity,
                  //               child: Text("${controller.participantDataModel.data?.pMobile}",textAlign: TextAlign.start,
                  //                 style: const TextStyle(color: Colors.black87,fontSize: 16,fontWeight: FontWeight.w500),),
                  //             ),
                  //             SizedBox(
                  //               width: double.infinity,
                  //               child: Text("${controller.participantDataModel.data?.pAddress}",textAlign: TextAlign.start,
                  //                 style: const TextStyle(color: Colors.black87,fontSize: 15,fontWeight: FontWeight.w400),),
                  //             ),
                  //
                  //           ],
                  //         ),
                  //       )
                  //   ),
                  // ),
                  // SliverToBoxAdapter(
                  //   child: ClipRRect(
                  //       clipBehavior: Clip.none,
                  //       borderRadius: BorderRadius.circular(16),
                  //       child: Container(
                  //         margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                  //         padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                  //         decoration: BoxDecoration(
                  //           color: Colors.white,
                  //           borderRadius: BorderRadius.circular(16),
                  //         ),
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Row(
                  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 Expanded(
                  //                   child: Column(
                  //                     crossAxisAlignment: CrossAxisAlignment.start,
                  //                     mainAxisSize: MainAxisSize.min,
                  //                     mainAxisAlignment: MainAxisAlignment.start,
                  //                     children: [
                  //                       SizedBox(
                  //                         width: double.infinity,
                  //                         child: Text("${controller.participantDataModel.data?.schoolName}",textAlign: TextAlign.start,
                  //                           style: const TextStyle(color: Colors.black87,fontSize: 15,fontWeight: FontWeight.w400),),
                  //                       ),
                  //                       const SizedBox(
                  //                         height: 6,
                  //                       ),
                  //                       Text("${controller.participantDataModel.data?.dataClass}",textAlign: TextAlign.start,
                  //                         style: const TextStyle(color: Colors.black87,fontSize: 15,fontWeight: FontWeight.w400),),
                  //                     ],
                  //                   ),
                  //                 ),
                  //                 // Material(
                  //                 //   color: AppColors.mainColor.withOpacity(0.03),
                  //                 //   borderRadius: BorderRadius.circular(6),
                  //                 //   child: InkWell(
                  //                 //     borderRadius: BorderRadius.circular(6),
                  //                 //     onTap: (){
                  //                 //       Get.toNamed(Routes.STUDENT_INSTITUTE_UPDATE);
                  //                 //     },
                  //                 //     child: Padding(
                  //                 //       padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 6),
                  //                 //       child: Text("Edit",style: TextStyle(color: AppColors.mainColor,
                  //                 //         // decoration: TextDecoration.underline
                  //                 //       ),),
                  //                 //     ),
                  //                 //   ),
                  //                 // ),
                  //               ],
                  //             ),
                  //             SizedBox(
                  //               width: double.infinity,
                  //               child: Text("${controller.participantDataModel.data?.group}",textAlign: TextAlign.start,
                  //                 style: const TextStyle(color: Colors.black87,fontSize: 15,fontWeight: FontWeight.w400),),
                  //             ),
                  //             SizedBox(
                  //               width: double.infinity,
                  //               child: Text("${controller.participantDataModel.data?.pGroup}",textAlign: TextAlign.start,
                  //                 style: const TextStyle(color: Colors.black87,fontSize: 16,fontWeight: FontWeight.w500),),
                  //             ),
                  //
                  //           ],
                  //         ),
                  //       )
                  //   ),
                  // ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: (){
                            controller.temporaryLogout(context);
                            // controller.logout();
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Center(
                              child: Text("Logout",style: TextStyle(color: Colors.red,fontSize: 16),),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
