import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:innovation/app/core/values/colors.dart';
import 'package:innovation/app/global_widget/common.dart';
import 'package:innovation/app/global_widget/custom_appbar.dart';
import 'package:innovation/app/global_widget/data_not_found_layout.dart';
import 'package:innovation/app/modules/students/student_list/student_list_controller.dart';
import 'package:innovation/app/routes/routes.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../core/utils/my_sharedpreferences.dart';

class StudentListScreen extends StatelessWidget {
  const StudentListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentListController>(
      init: StudentListController(),
      builder: (controller) {
        return ModalProgressHUD(
          inAsyncCall: controller.isLoading.value,
          child: Scaffold(
            appBar: CustomAppBar()
                .colorAppBar(controller.homeController.getButtonText(), AppColors.mainColor, false),
            body: CustomScrollView(
              scrollDirection: Axis.vertical,
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 16),
                  sliver: SliverGrid(
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                          return Material(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            child: InkWell(
                              onTap: () {
                                MySharedPreference.participantId =
                                controller.studentList[index].userId!;
                                // controller.saveTypeOfUser(controller.studentList[index].regType);
                                if (controller.studentList[index].step ==
                                    "step4") {
                                  Get.toNamed(Routes.MY_IDEAS,arguments: {"userId":"${controller.studentList[index].userId!}"});
                                  return;
                                }
                                if (controller.isReadyForIdeaSubmit(
                                    controller.studentList[index].step)) {
                                  Get.toNamed(Routes.IDEA_TYPE_CHOOSE);
                                } else {
                                  Get.toNamed(
                                      Routes.CHOOSE_TEAM_INDIVIDUAL);
                                }
                              },
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Image(
                                        image: AssetImage(controller
                                            .studentList[index]
                                            .regType ==
                                            "individual"
                                            ? "images/graduate.png"
                                            : "images/students.png"),
                                        height: 80,
                                        width: 80,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    SizedBox(
                                        width: double.infinity,
                                        child: Text(
                                          "${controller.studentList[index].firstName} ${controller.studentList[index].lastName}",
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                        )),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    SizedBox(
                                        width: double.infinity,
                                        child: Text(
                                          "${controller.studentList[index].regType}",
                                          style: const TextStyle(
                                              color: Colors.black87,
                                              fontSize: 14),
                                        )),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    SizedBox(
                                        width: double.infinity,
                                        child: Text(
                                          "ID : #STU${controller.studentList[index].userId}",
                                          style: const TextStyle(
                                              color: Colors.black87,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }, childCount: controller.studentList.length),
                  ),
                ),
                SliverLayoutBuilder(
                  builder: (BuildContext context,
                      SliverConstraints constraints) {
                    if (controller.studentList.isEmpty &&
                        !controller.isLoading.value) {
                      return SliverToBoxAdapter(
                        child: DataNotFoundLayout(
                          displayText: "Yet to add ${controller.homeController.getButtonText()}!",
                          isButton: true,
                          buttonText: "Add ${controller.homeController.getButtonText()}",
                          onPresses: () {
                            Get.toNamed(Routes.ADD_STUDENT);
                          },
                        ),
                      );
                    } else {
                      return const SliverToBoxAdapter(
                          child: SizedBox());
                    }
                  },
                )
              ],
            ),
            // floatingActionButton: FloatingActionButton(
            //   backgroundColor: AppColors.mainColor,
            //   child: const Icon(Icons.add,color: Colors.white,),
            //   onPressed: () async {
            //     try {
            //       final result = await InternetAddress.lookup('example.com');
            //       if (result.isNotEmpty &&
            //           result[0].rawAddress.isNotEmpty) {
            //         // connected
            //         Get.toNamed(Routes.ADD_STUDENT);
            //       }else {
            //         // not connected
            //         Common.toastMsg("No Internet Connection");
            //       }
            //     } on SocketException catch (_) {
            //       Common.toastMsg("No Internet Connection");
            //     }
            //   },
            // ),
          ),
        );
      },
    );
  }
}
