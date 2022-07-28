import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:innovation/app/data/models/location_model.dart';
import 'package:innovation/app/global_widget/floating_back.dart';
import 'package:innovation/app/global_widget/usa_logo_layout.dart';
import 'package:innovation/app/modules/update_info/profile_update/profile_update_controller.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../core/values/colors.dart';
import '../../../global_widget/common.dart';
import '../../../global_widget/custom_appbar.dart';

class StudentProfileUpdateScreen extends StatelessWidget {
  const StudentProfileUpdateScreen({Key? key}) : super(key: key);

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
          child: GetBuilder<StudentProfileUpdateController>(
            init: StudentProfileUpdateController(),
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
                            Text("Update Student Profile",style: TextStyle(color: AppColors.mainColorBlack,fontSize: 20,fontWeight: FontWeight.w500),),
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
                          key: controller.profileUpdateKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// .............. Profile Picture ...............
                              // Align(
                              //   alignment: Alignment.center,
                              //   child: SizedBox(
                              //     height: 100,
                              //     width: 100,
                              //     child: Stack(
                              //       children: [
                              //         const CircleAvatar(
                              //           radius: 60,
                              //           child: Image(image: AssetImage("images/graduate.png"),height: 64,width: 64,),
                              //         ),
                              //         Align(
                              //           alignment: Alignment.bottomRight,
                              //           child: Material(
                              //             borderRadius: BorderRadius.circular(16),
                              //             color: Colors.grey.withOpacity(0.4),
                              //             child: InkWell(
                              //               borderRadius: BorderRadius.circular(16),
                              //               onTap: (){
                              //
                              //               },
                              //               child: const Padding(
                              //                 padding: EdgeInsets.all(8.0),
                              //                 child: Icon(Icons.camera_alt,size: 16,),
                              //               ),
                              //             ),
                              //           ),
                              //         )
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                                width: double.infinity,
                                child: const Text(
                                  "Date Of Birth",
                                  style: TextStyle(color: Colors.black54),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 30),
                                // height: 45,
                                width: double.infinity,
                                child: TextFormField(
                                  controller: controller.dobController,
                                  validator: controller.validationDob,
                                  cursorColor: Colors.black87,
                                  textInputAction: TextInputAction.next,
                                  onSaved: (String? val) {
                                    controller.dob = val;
                                  },
                                  readOnly: true,
                                  onTap: (){
                                    controller.selectDobDate(context);
                                  },
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    // fillColor: Colors.white,
                                    // filled: true,
                                    alignLabelWithHint: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 16),
                                    hintText: 'Date of birth',
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
                                  "Division",
                                  style: TextStyle(color: Colors.black54),
                                ),
                              ),
                              // ...... division ............
                              Container(
                                decoration: const BoxDecoration(
                                    color: Colors.transparent
                                ),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 0),
                                width: double.infinity,
                                child: DropdownButtonFormField<Data>(
                                  hint: const Text('Select Division'),
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
                                  value: controller.divisionData,
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                  ),
                                  iconSize: 24,
                                  elevation: 3,
                                  validator: (value) {
                                    if (value!.id == 0) {
                                      return 'Select Division';
                                    } else {
                                      return null;
                                    }
                                  },
                                  //underline: SizedBox(),
                                  onChanged: (newValue) {
                                    controller.selectDivision(newValue!);
                                  },
                                  items: controller.divisionList.map<DropdownMenuItem<Data>>(
                                          (Data value) {
                                        return DropdownMenuItem<Data>(
                                          value: value,
                                          child: Text(value.name!),
                                        );
                                      }).toList(),
                                ),
                              ),
                              // ...... District ............
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                                width: double.infinity,
                                child: const Text(
                                  "District",
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
                                child: DropdownButtonFormField<Data>(
                                  hint: const Text('Select District'),
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
                                  value: controller.districtData,
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                  ),
                                  iconSize: 24,
                                  elevation: 3,
                                  validator: (value) {
                                    if (value!.id == 0) {
                                      return 'Select District';
                                    } else {
                                      return null;
                                    }
                                  },
                                  //underline: SizedBox(),
                                  onChanged: (newValue) {
                                    controller.selectDistrict(newValue!);
                                  },
                                  items: controller.districtList.map<DropdownMenuItem<Data>>(
                                          (Data value) {
                                        return DropdownMenuItem<Data>(
                                          value: value,
                                          child: Text(value.name!),
                                        );
                                      }).toList(),
                                ),
                              ),
                              // ...... Upazila ............
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                                width: double.infinity,
                                child: const Text(
                                  "Upazila",
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
                                child: DropdownButtonFormField<Data>(
                                  hint: const Text('Select Upazila'),
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
                                  value: controller.upazilaData,
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                  ),
                                  iconSize: 24,
                                  elevation: 3,
                                  validator: (value) {
                                    if (value!.id == 0) {
                                      return 'Select Upazila';
                                    } else {
                                      return null;
                                    }
                                  },
                                  //underline: SizedBox(),
                                  onChanged: (newValue) {
                                    controller.selectUpazila(newValue!);
                                  },
                                  items: controller.upazilaList.map<DropdownMenuItem<Data>>(
                                          (Data value) {
                                        return DropdownMenuItem<Data>(
                                          value: value,
                                          child: Text(value.name!),
                                        );
                                      }).toList(),
                                ),
                              ),
                              // ...... Union ............
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                                width: double.infinity,
                                child: const Text(
                                  "Union",
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
                                child: DropdownButtonFormField<Data>(
                                  hint: const Text('Select Union'),
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
                                  value: controller.unionData,
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                  ),
                                  iconSize: 24,
                                  elevation: 3,
                                  validator: (value) {
                                    if (value!.id == 0) {
                                      return 'Select Union';
                                    } else {
                                      return null;
                                    }
                                  },
                                  //underline: SizedBox(),
                                  onChanged: (newValue) {
                                    controller.selectUnion(newValue!);
                                  },
                                  items: controller.unionList.map<DropdownMenuItem<Data>>(
                                          (Data value) {
                                        return DropdownMenuItem<Data>(
                                          value: value,
                                          child: Text(value.name!),
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
                                    if (controller.profileUpdateKey.currentState!.validate()) {
                                      controller.profileUpdateKey.currentState!.save();
                                      try {
                                        final result = await InternetAddress.lookup(
                                            'example.com');
                                        if (result.isNotEmpty &&
                                            result[0].rawAddress.isNotEmpty) {
                                          controller.saveFirstStepData();
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
                                    'Update & Next',
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
                    ),
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
