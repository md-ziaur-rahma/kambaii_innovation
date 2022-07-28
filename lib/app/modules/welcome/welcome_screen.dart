import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:innovation/app/core/values/colors.dart';
import 'package:innovation/app/global_widget/usa_logo_layout.dart';
import 'package:innovation/app/modules/home/home_controller.dart';
import 'package:innovation/app/routes/routes.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({Key? key}) : super(key: key);

  final HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return GetBuilder<HomeController>(
      builder: (controller){
        return Scaffold(
          body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      // AppColors.backgroundColor,
                      // AppColors.backgroundColor.withOpacity(0.5)
                      AppColors.white,
                      AppColors.white.withOpacity(0.5)
                    ]
                )
            ),
            child: SafeArea(
              child: CustomScrollView(
                scrollDirection: Axis.vertical,
                slivers: [
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 50,
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.0),
                      child: Image(
                        alignment: Alignment.topLeft,
                        height: 100,
                        image: AssetImage("images/rainbow.png"),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Align(
                      alignment: Alignment.center,
                        child: Text("WELCOME TO",style: TextStyle(color: AppColors.mainColor,fontSize: 28,fontWeight: FontWeight.w600),)),
                  ),
                  SliverToBoxAdapter(
                    child: CridUsaLogoLayout().cridLogo(120, Alignment.center),
                  ),
                  SliverToBoxAdapter(
                      child: SizedBox(
                        height: width * 0.1,
                      )
                  ),
                  SliverToBoxAdapter(
                    child: Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text("Sign in as a",style: TextStyle(color: Colors.black,fontSize: 18),),
                          SizedBox(height: 8,),
                          Icon(Icons.arrow_forward,)
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                      child: SizedBox(
                        height: width * 0.1,
                      )
                  ),
                  SliverToBoxAdapter(
                    child: Align(
                      alignment: Alignment.center,
                      child: Material(
                        type: MaterialType.card,
                        elevation: 1,
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.white,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(6),
                          onTap: (){
                            controller.changeOfType(1);
                            Get.toNamed(Routes.LOGIN);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            width: MediaQuery.of(context).size.width * 0.33,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Student",style: TextStyle(color: AppColors.mainColor,fontSize: 18,fontWeight: FontWeight.w500),),
                                const SizedBox(
                                  height: 8,
                                ),
                                const Image(
                                  image: AssetImage("images/student.png"),
                                  height: 100,

                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 16,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Material(
                          type: MaterialType.card,
                          elevation: 1,
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.white,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(6),
                            onTap: (){
                              controller.changeOfType(2);
                              Get.toNamed(Routes.LOGIN);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              width: MediaQuery.of(context).size.width * 0.33,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Teacher",style: TextStyle(color: AppColors.mainColor,fontSize: 18,fontWeight: FontWeight.w500),),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  const Image(
                                    image: AssetImage("images/teacher.png"),
                                    height: 100,

                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Material(
                          type: MaterialType.card,
                          elevation: 1,
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.white,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(6),
                            onTap: (){
                              controller.changeOfType(3);
                              Get.toNamed(Routes.LOGIN);
                              },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              width: MediaQuery.of(context).size.width * 0.33,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Guardian",style: TextStyle(color: AppColors.mainColor,fontSize: 18,fontWeight: FontWeight.w500),),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  const Image(
                                    image: AssetImage("images/parents.png"),
                                    height: 100,

                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
