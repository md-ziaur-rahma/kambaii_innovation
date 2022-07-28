import 'dart:io';

import 'package:innovation/app/core/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:innovation/app/global_widget/common.dart';
import 'package:innovation/app/global_widget/floating_back.dart';
import 'package:innovation/app/global_widget/usa_logo_layout.dart';
import 'package:innovation/app/modules/add_student/add_student_controller.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../global_widget/custom_appbar.dart';

class AddStudentScreen extends StatelessWidget {
  const AddStudentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<AddStudentController>(
          init: AddStudentController(),
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
                              Text("Add ${controller.homeController.getButtonText()}",style: TextStyle(color: AppColors.mainColorBlack,fontSize: 20,fontWeight: FontWeight.w500),),
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
                              color: Colors.transparent,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30))),
                          child: Form(
                            key: controller.studentFormKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 10),
                                  width: double.infinity,
                                  child: Text(
                                    "${controller.homeController.getButtonText()} First Name",
                                    style: const TextStyle(color: Colors.black54),
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
                                      hintText: '${controller.homeController.getButtonText()} First Name',
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
                                  child: Text(
                                    "${controller.homeController.getButtonText()} Last Name",
                                    style: const TextStyle(color: Colors.black54),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 30),
                                  // height: 45,
                                  width: double.infinity,
                                  child: TextFormField(
                                    textAlign: TextAlign.start,
                                    controller: controller.lastNameController,
                                    validator: controller.validationLastName,
                                    textInputAction: TextInputAction.next,
                                    maxLines: 1,
                                    cursorColor: Colors.black87,
                                    onSaved: (String? val) {
                                      controller.lastName = val;
                                    },
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 16),
                                      hintText: '${controller.homeController.getButtonText()} Last Name',
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
                                    "Parents Mobile",
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
                                      hintText: 'Parents Mobile',
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
                                    "Email",
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 30),
                                  // height: 45,
                                  width: double.infinity,
                                  child: TextFormField(
                                    textAlign: TextAlign.start,
                                    controller: controller.emailController,
                                    validator: controller.validationEmail,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.emailAddress,
                                    maxLines: 1,
                                    cursorColor: Colors.black87,
                                    onSaved: (String? val) {
                                      controller.email = val;
                                    },
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 16),
                                      hintText: 'Email (if any)',
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
                                    "Password",
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 30),
                                  // height: 45,
                                  width: double.infinity,
                                  child: TextFormField(
                                    textAlign: TextAlign.start,
                                    controller: controller.passwordController,
                                    validator: controller.validationPassword,
                                    textInputAction: TextInputAction.done,
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: controller.obscureText.value,
                                    maxLines: 1,
                                    cursorColor: Colors.black87,
                                    onSaved: (String? val) {
                                      controller.password = val;
                                    },
                                    decoration: InputDecoration(
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          controller.toggle();
                                        },
                                        child: controller.obscureText.value
                                            ? const Icon(
                                          Icons.visibility_off,
                                          color: Colors.black54,
                                        )
                                            : const Icon(
                                          Icons.visibility,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 16),
                                      hintText: 'Password',
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
                                    "Confirm Password",
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 30),
                                  // height: 45,
                                  width: double.infinity,
                                  child: TextFormField(
                                    textAlign: TextAlign.start,
                                    controller: controller.confirmPasswordController,
                                    validator: controller.validationConfirmPassword,
                                    textInputAction: TextInputAction.done,
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: controller.obscureText.value,
                                    maxLines: 1,
                                    cursorColor: Colors.black87,
                                    onSaved: (String? val) {
                                      controller.confirmPassword = val;
                                    },
                                    decoration: InputDecoration(
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          controller.toggle();
                                        },
                                        child: controller.obscureText.value
                                            ? const Icon(
                                          Icons.visibility_off,
                                          color: Colors.black54,
                                        )
                                            : const Icon(
                                          Icons.visibility,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 16),
                                      hintText: 'Confirm Password',
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
                                      if (controller.studentFormKey.currentState!.validate()) {
                                        controller.studentFormKey.currentState!.save();
                                        try {
                                          final result = await InternetAddress.lookup(
                                              'example.com');
                                          if (result.isNotEmpty &&
                                              result[0].rawAddress.isNotEmpty) {
                                            // print(controller.homeController.studentText);
                                             controller.addStudentByTeacher();
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
                                    child: Text(
                                      'Add ${controller.homeController.getButtonText()}',
                                      style: const TextStyle(
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

