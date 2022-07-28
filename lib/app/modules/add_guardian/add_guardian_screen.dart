import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:innovation/app/global_widget/custom_appbar.dart';
import 'package:innovation/app/global_widget/floating_back.dart';
import 'package:innovation/app/global_widget/usa_logo_layout.dart';
import 'package:innovation/app/modules/add_guardian/add_guardian_controller.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../core/values/colors.dart';
import '../../global_widget/common.dart';

class AddGuardianScreen extends StatelessWidget {
  AddGuardianScreen({Key? key}) : super(key: key);

  final AddGuardianController addGuardianController = Get.put(AddGuardianController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: CustomAppBar().colorAppBar(addGuardianController.title, AppColors.mainColor, false),
        body: GetBuilder<AddGuardianController>(
          init: AddGuardianController(),
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
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    slivers: [
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 0),
                        sliver: SliverToBoxAdapter(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.add,color: AppColors.mainColorBlack,),
                              const SizedBox(
                                width: 8,
                              ),
                              Text("Add Guardian",style: TextStyle(color: AppColors.mainColorBlack,fontSize: 20,fontWeight: FontWeight.w500),),
                              const Spacer(),
                              CridUsaLogoLayout().cridLogo(80, Alignment.topRight)
                              // Image(image: AssetImage("images/student.png"))
                            ],
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          // margin: const EdgeInsets.symmetric(horizontal: 30,),
                          padding:
                          const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30))),
                          child: Form(
                            key: controller.guardianFormKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 10),
                                  width: double.infinity,
                                  child: const Text(
                                    "Guardian Name",
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 30),
                                  // height: 45,
                                  width: double.infinity,
                                  child: TextFormField(
                                    controller: controller.nameController,
                                    validator: controller.validationUserName,
                                    cursorColor: Colors.black87,
                                    textInputAction: TextInputAction.next,
                                    onSaved: (String? val) {
                                      controller.name = val;
                                    },
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      alignLabelWithHint: true,
                                      contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 16),
                                      hintText: 'Guardian Name',
                                      // hintStyle: const TextStyle(
                                      //     color: Colors.black54, fontSize: 18),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(0),
                                          borderSide:BorderSide(
                                              color: AppColors.mainColor)),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(0),
                                          borderSide: BorderSide(
                                              color: AppColors.mainColor)),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 10),
                                  width: double.infinity,
                                  child: const Text(
                                    "Relationship with guardian",
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 30),
                                  // height: 45,
                                  width: double.infinity,
                                  child: TextFormField(
                                    textAlign: TextAlign.start,
                                    controller: controller.relationController,
                                    validator: controller.validationRelation,
                                    textInputAction: TextInputAction.next,
                                    maxLines: 1,
                                    cursorColor: Colors.black87,
                                    onSaved: (String? val) {
                                      controller.relation = val;
                                    },
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 16),
                                      hintText: 'Relationship with guardian',
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(0),
                                          borderSide: BorderSide(
                                              color: AppColors.mainColor)),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(0),
                                          borderSide: BorderSide(
                                              color: AppColors.mainColor)),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 10),
                                  width: double.infinity,
                                  child: const Text(
                                    "Guardian NID/Passport",
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 30),
                                  // height: 45,
                                  width: double.infinity,
                                  child: TextFormField(
                                    textAlign: TextAlign.start,
                                    controller: controller.nidController,
                                    validator: controller.validationNID,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.number,
                                    maxLines: 1,
                                    cursorColor: Colors.black87,
                                    onSaved: (String? val) {
                                      controller.nid = val;
                                    },
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 16),
                                      hintText: 'Guardian NID/Passport',
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(0),
                                          borderSide: BorderSide(
                                              color: AppColors.mainColor)),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(0),
                                          borderSide: BorderSide(
                                              color: AppColors.mainColor)),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 10),
                                  width: double.infinity,
                                  child: const Text(
                                    "Mobile",
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 30),
                                  // height: 45,
                                  width: double.infinity,
                                  child: TextFormField(
                                    textAlign: TextAlign.start,
                                    controller: controller.mobileController,
                                    validator: controller.validationMobile,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.number,
                                    maxLines: 1,
                                    cursorColor: Colors.black87,
                                    onSaved: (String? val) {
                                      controller.mobile = val;
                                    },
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 16),
                                      hintText: 'Mobile',
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(0),
                                          borderSide: BorderSide(
                                              color: AppColors.mainColor)),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(0),
                                          borderSide: BorderSide(
                                              color: AppColors.mainColor)),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 10),
                                  width: double.infinity,
                                  child: const Text(
                                    "Address",
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 30),
                                  // height: 45,
                                  width: double.infinity,
                                  child: TextFormField(
                                    textAlign: TextAlign.start,
                                    controller: controller.addressController,
                                    validator: controller.validationAddress,
                                    textInputAction: TextInputAction.done,
                                    keyboardType: TextInputType.text,
                                    maxLines: 1,
                                    cursorColor: Colors.black87,
                                    onSaved: (String? val) {
                                      controller.address = val;
                                    },
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 16),
                                      hintText: 'Address',
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(0),
                                          borderSide: BorderSide(
                                              color: AppColors.mainColor)),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(0),
                                          borderSide: BorderSide(
                                              color: AppColors.mainColor)),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 30),
                                  height: 40,
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if (controller.guardianFormKey.currentState!.validate()) {
                                        controller.guardianFormKey.currentState!.save();
                                        try {
                                          final result = await InternetAddress.lookup(
                                              'example.com');
                                          if (result.isNotEmpty &&
                                              result[0].rawAddress.isNotEmpty) {
                                              controller.saveSecondStepData();
                                          }
                                        } on SocketException catch (_) {
                                          Common.toastMsg('No Internet Connection');
                                        }
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: AppColors.mainColor,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(6.0)))),
                                    child: const Text(
                                      'Save & Continue',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ),
                                ),
                                const SizedBox(
                                  height: 400,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: const FloatingBack(),
    );
  }
}
