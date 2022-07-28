import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:innovation/app/core/utils/my_sharedpreferences.dart';
import 'package:innovation/app/core/values/colors.dart';
import 'package:innovation/app/modules/home/home_controller.dart';

import '../../global_widget/floating_back.dart';
import '../../routes/routes.dart';

class ChooseTeamOrIndividual extends StatelessWidget {
  ChooseTeamOrIndividual({Key? key}) : super(key: key);

  final homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 30),
              // color: Colors.white,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const[
                  Image(
                    image: AssetImage("images/crid_usa.png"),
                    height: 100,
                  ),
                  Image(
                    image: AssetImage("images/teacher.png"),
                    height: 100,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
              width: double.infinity,
              child: const Text("Choose Participant Type.",
                style: TextStyle(color: Colors.black87,fontSize: 18,fontWeight: FontWeight.w500),),
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Material(
                      type: MaterialType.card,
                      elevation: 1,
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.white,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(6),
                        onTap: (){
                          // MySharedPreference.participantId = MySharedPreference.userId;
                          homeController.saveTeamOrIndividual(homeController.individualText);
                          Get.toNamed(Routes.STUDENT_PROFILE_UPDATE);
                          // if(homeController.isReadyForIdeaSubmit()){
                          //   Get.toNamed(Routes.IDEA_TYPE_CHOOSE);
                          // } else {
                          //   Get.toNamed(Routes.STUDENT_PROFILE_UPDATE);
                          // }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Individual",style: TextStyle(color: AppColors.mainColor,fontSize: 18,fontWeight: FontWeight.w500),),
                              const SizedBox(
                                height: 8,
                              ),
                              const Image(
                                image: AssetImage("images/graduate.png"),
                                height: 100,

                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Material(
                      type: MaterialType.card,
                      elevation: 1,
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.white,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(6),
                        onTap: (){
                          // MySharedPreference.participantId = MySharedPreference.userId;
                          homeController.saveTeamOrIndividual(homeController.teamText);
                          Get.toNamed(Routes.STUDENT_PROFILE_UPDATE);
                          // if(homeController.isReadyForIdeaSubmit()){
                          //   Get.toNamed(Routes.TEAM_MEMBER);
                          // } else {
                          //   Get.toNamed(Routes.STUDENT_PROFILE_UPDATE);
                          // }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Team",style: TextStyle(color: AppColors.mainColor,fontSize: 18,fontWeight: FontWeight.w500),),
                              const SizedBox(
                                height: 8,
                              ),
                              const Image(
                                image: AssetImage("images/students.png"),
                                height: 100,

                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: const FloatingBack(),
    );
  }
}
