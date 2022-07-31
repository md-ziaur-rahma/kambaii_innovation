import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:innovation/app/core/values/colors.dart';
import 'package:innovation/app/global_widget/floating_back.dart';
import 'package:innovation/app/global_widget/usa_logo_layout.dart';
import 'package:innovation/app/modules/update_info/team_member_update/team_member_update_controller.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../global_widget/common.dart';

class TeamMemberUpdateScreen extends StatelessWidget {
  const TeamMemberUpdateScreen({Key? key}) : super(key: key);

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
          child: GetBuilder<TeamMemberUpdateController>(
            init: TeamMemberUpdateController(),
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
                            Text("Update Team Members",style: TextStyle(color: AppColors.mainColorBlack,fontSize: 18,fontWeight: FontWeight.w500),),
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
                          key: controller.teamMemberUpdateKey,
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
                                  "Team Name",
                                  style: TextStyle(color: Colors.black54),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 30),
                                // height: 45,
                                width: double.infinity,
                                child: TextFormField(
                                  controller: controller.teamNameController,
                                  validator: controller.validationTeamName,
                                  cursorColor: Colors.black87,
                                  textInputAction: TextInputAction.next,
                                  onSaved: (String? val) {
                                    controller.teamName = val;
                                  },
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    alignLabelWithHint: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 16),
                                    hintText: 'Team Name',
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
                                  "1st Member Name",
                                  style: TextStyle(color: Colors.black54),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 30),
                                // height: 45,
                                width: double.infinity,
                                child: TextFormField(
                                  textAlign: TextAlign.start,
                                  controller: controller.fMNameController,
                                  validator: controller.validationFMName,
                                  textInputAction: TextInputAction.next,
                                  maxLines: 1,
                                  cursorColor: Colors.black87,
                                  keyboardType: TextInputType.text,
                                  onSaved: (String? val) {
                                    controller.fMName = val;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 16),
                                    hintText: 'Member Name',
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
                                  "1st Member Contact",
                                  style: TextStyle(color: Colors.black54),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 30),
                                // height: 45,
                                width: double.infinity,
                                child: TextFormField(
                                  textAlign: TextAlign.start,
                                  controller: controller.fMContactController,
                                  validator: controller.validationFMContact,
                                  textInputAction: TextInputAction.next,
                                  maxLines: 1,
                                  cursorColor: Colors.black87,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  onSaved: (String? val) {
                                    controller.fMContact = val;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 16),
                                    hintText: 'Member Contact',
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
                                  "2nd Member Name",
                                  style: TextStyle(color: Colors.black54),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 30),
                                // height: 45,
                                width: double.infinity,
                                child: TextFormField(
                                  textAlign: TextAlign.start,
                                  controller: controller.sMNameController,
                                  validator: controller.validationSMName,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text,
                                  maxLines: 1,
                                  cursorColor: Colors.black87,
                                  onSaved: (String? val) {
                                    controller.sMName = val;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 16),
                                    hintText: 'Member Name',
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
                                  "Member Contact",
                                  style: TextStyle(color: Colors.black54),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 30),
                                // height: 45,
                                width: double.infinity,
                                child: TextFormField(
                                  textAlign: TextAlign.start,
                                  controller: controller.sMContactController,
                                  validator: controller.validationFMContact,
                                  textInputAction: TextInputAction.done,
                                  maxLines: 1,
                                  cursorColor: Colors.black87,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  onSaved: (String? val) {
                                    controller.sMContact = val;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 16),
                                    hintText: '2nd Member Contact',
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
                                      if (controller.teamMemberUpdateKey.currentState!.validate()) {
                                        controller.teamMemberUpdateKey.currentState!.save();
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
