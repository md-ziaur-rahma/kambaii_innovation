import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:innovation/app/core/values/strings.dart';

import '../../core/values/colors.dart';
import 'splash_controller.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SplashController>(
        init: SplashController(),
        builder: (controller){
          return Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 1,
                child: Image(
                  image: const AssetImage("images/innovation_hori_logo.png"),
                  height: 120,
                  width: MediaQuery.of(context).size.width * 0.6,
                ),
              ),
              Expanded(
                flex: 1,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: AppColors.mainColor,
                    ),
                    // const Positioned(
                    //   top: -50,
                    //   left: 0,
                    //   right: 0,
                    //   child: CircleAvatar(
                    //     radius: 70,
                    //     // child: Image(image: AssetImage("images/splashpic.jpg"))
                    //     backgroundImage: AssetImage("images/robotic_concept.jpg"),
                    //   ),
                    // ),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(AppStrings.kambaiiTitle,
                            style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
                          SizedBox(
                            height: 10,
                          ),
                          Text(AppStrings.dialog
                            ,style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.normal),)
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(AppStrings.copyWrite,textAlign: TextAlign.center,),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}