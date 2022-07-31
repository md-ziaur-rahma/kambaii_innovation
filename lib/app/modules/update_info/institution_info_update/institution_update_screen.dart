import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:innovation/app/global_widget/floating_back.dart';
import 'package:innovation/app/global_widget/usa_logo_layout.dart';
import 'package:innovation/app/modules/update_info/institution_info_update/institution_info_update_controller.dart';
import 'package:innovation/app/modules/update_info/profile_update/profile_update_controller.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../core/values/colors.dart';
import '../../../global_widget/common.dart';
import '../../../global_widget/custom_appbar.dart';

class StudentInstituteUpdateScreen extends StatelessWidget {
  const StudentInstituteUpdateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
          child: GetBuilder<StudentInstituteUpdateController>(
            init: StudentInstituteUpdateController(),
            builder: (controller) {
              return ModalProgressHUD(
                inAsyncCall: controller.isLoading.value,
                child: CustomScrollView(
                  scrollDirection: Axis.vertical,
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 0),
                      sliver: SliverToBoxAdapter(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Update Student Institute",style: TextStyle(color: AppColors.mainColorBlack,fontSize: 18,fontWeight: FontWeight.w500),),
                            CridUsaLogoLayout().cridLogo(80, Alignment.topRight)
                            // Image(image: AssetImage("images/student.png"))
                          ],
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 16),
                      sliver: SliverToBoxAdapter(
                        child: Form(
                          key: controller.instituteUpdateKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                                width: double.infinity,
                                child: const Text(
                                  "Name of school",
                                  style: TextStyle(color: Colors.black54),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 30),
                                // height: 45,
                                width: double.infinity,
                                child: TextFormField(
                                  controller: controller.schoolNameController,
                                  validator: controller.validationSchoolName,
                                  cursorColor: Colors.black87,
                                  textInputAction: TextInputAction.next,
                                  onSaved: (String? val) {
                                    controller.schoolName = val;
                                  },
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    alignLabelWithHint: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 16),
                                    hintText: 'Name Of School',
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
                                  "Class",
                                  style: TextStyle(color: Colors.black54),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 30),
                                // height: 45,
                                width: double.infinity,
                                child: TextFormField(
                                  textAlign: TextAlign.start,
                                  controller: controller.classController,
                                  validator: controller.validationClass,
                                  textInputAction: TextInputAction.next,
                                  maxLines: 1,
                                  cursorColor: Colors.black87,
                                  onSaved: (String? val) {
                                    controller.className = val;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 16),
                                    hintText: 'Class',
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
                                  "Roll No",
                                  style: TextStyle(color: Colors.black54),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 30),
                                // height: 45,
                                width: double.infinity,
                                child: TextFormField(
                                  textAlign: TextAlign.start,
                                  controller: controller.rollNotController,
                                  validator: controller.validationRollNo,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text,
                                  maxLines: 1,
                                  cursorColor: Colors.black87,
                                  onSaved: (String? val) {
                                    controller.rollNo = val;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 16),
                                    hintText: 'Roll No',
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
                                  "Group",
                                  style: TextStyle(color: Colors.black54),
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                    color: Colors.transparent
                                ),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 0),
                                width: double.infinity,
                                child: DropdownButtonFormField<String>(
                                  hint: const Text('Select Group'),
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        borderSide: BorderSide(
                                            color: AppColors.mainColor)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        borderSide: BorderSide(
                                            color: AppColors.mainColor)),
                                  ),
                                  focusColor: Colors.cyanAccent,
                                  value: controller.group,
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                  ),
                                  iconSize: 24,
                                  elevation: 3,
                                  validator: (value) {
                                    if (value == "Select Group") {
                                      return 'Select Group';
                                    } else {
                                      return null;
                                    }
                                  },
                                  //underline: SizedBox(),
                                  onChanged: (newValue) {
                                    controller.selectGroup(newValue!);
                                  },
                                  items: controller.groupList.map<DropdownMenuItem<String>>(
                                          (value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                ),
                              ),

                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                                width: double.infinity,
                                child: const Text(
                                  "Participating group",
                                  style: TextStyle(color: Colors.black54),
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                    color: Colors.transparent
                                ),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 0),
                                width: double.infinity,
                                child: DropdownButtonFormField<String>(
                                  hint: const Text('Select Group'),
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        borderSide: BorderSide(
                                            color: AppColors.mainColor)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(0),
                                        borderSide: BorderSide(
                                            color: AppColors.mainColor)),
                                  ),
                                  focusColor: Colors.cyanAccent,
                                  value: controller.participatingGroup,
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                  ),
                                  iconSize: 24,
                                  elevation: 3,
                                  validator: (value) {
                                    if (value == "Select Group") {
                                      return 'Select Group';
                                    } else {
                                      return null;
                                    }
                                  },
                                  //underline: SizedBox(),
                                  onChanged: (newValue) {
                                    controller.selectParticipatingGroup(newValue!);
                                  },
                                  items: controller.participatingGroupList.map<DropdownMenuItem<String>>(
                                          (value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
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
                                    if (controller.instituteUpdateKey.currentState!.validate()) {
                                      controller.instituteUpdateKey.currentState!.save();
                                      try {
                                        final result = await InternetAddress.lookup(
                                            'example.com');
                                        if (result.isNotEmpty &&
                                            result[0].rawAddress.isNotEmpty) {
                                            controller.saveThirdStepData();
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
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: const FloatingBack(),
    );
  }
}
