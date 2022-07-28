import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:innovation/app/core/values/colors.dart';
import 'package:innovation/app/global_widget/usa_logo_layout.dart';
import 'package:innovation/app/modules/success_pages/success_sceen_controller.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SuccessScreenController>(
      init: SuccessScreenController(),
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
                      AppColors.backgroundColor,
                      AppColors.backgroundColor.withOpacity(0.5)
                    ]
                )
            ),
            child: SafeArea(
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: CridUsaLogoLayout().cridLogo(150, Alignment.topCenter),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle_outline,size: 50,color: AppColors.emeraldGreen,),
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                          decoration: BoxDecoration(
                            color: AppColors.emeraldGreen,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 30,vertical: 16),
                          child: Text(controller.message,textAlign: TextAlign.center,style: const TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500),),
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                      child: Material(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.mainColor,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: (){
                            Get.back();
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Icon(Icons.arrow_back_outlined,color: Colors.white,),
                          ),
                        ),
                      ),
                    )
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
