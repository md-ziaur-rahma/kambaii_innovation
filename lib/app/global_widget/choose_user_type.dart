import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:innovation/app/modules/home/home_controller.dart';

class ChooseUserTypeLayout extends StatelessWidget {
  ChooseUserTypeLayout({Key? key}) : super(key: key);

  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller){
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 16),
          child: Row(
            children: [
              Expanded(
                child: Material(
                  color: controller.typeOfUser == 1 ? const Color(0xFFF4F4F4) : Colors.white,
                  child: InkWell(
                    onTap: (){
                      controller.changeOfType(1);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Student",style: TextStyle(color: controller.typeOfUser == 1 ? Colors.black87 : Colors.black54,fontSize: 16,fontWeight: FontWeight.w500),),
                          const SizedBox(
                            width: 8,
                          ),
                          Icon( controller.typeOfUser == 1 ? Icons.check_box_outlined : Icons.check_box_outline_blank,color: controller.typeOfUser == 1 ? Colors.black87 : Colors.black54,)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Material(
                  color: controller.typeOfUser == 2 ? const Color(0xFFF4F4F4) : Colors.white,
                  child: InkWell(
                    onTap: (){
                      controller.changeOfType(2);
                      },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Teacher",style: TextStyle(color: controller.typeOfUser == 2 ? Colors.black87 : Colors.black54,fontSize: 16,fontWeight: FontWeight.w500),),
                          const SizedBox(
                            width: 8,
                          ),
                          Icon( controller.typeOfUser == 2 ? Icons.check_box_outlined : Icons.check_box_outline_blank,color: controller.typeOfUser == 2 ? Colors.black87 : Colors.black54,)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Material(
                  color: controller.typeOfUser == 3 ? const Color(0xFFF4F4F4) : Colors.white,
                  child: InkWell(
                    onTap: (){
                      controller.changeOfType(3);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Guardian",style: TextStyle(color: controller.typeOfUser == 3 ? Colors.black87 : Colors.black54,fontSize: 16,fontWeight: FontWeight.w500),),
                          const SizedBox(
                            width: 8,
                          ),
                          Icon( controller.typeOfUser == 3 ? Icons.check_box_outlined : Icons.check_box_outline_blank,color: controller.typeOfUser == 3 ? Colors.black87 : Colors.black54,)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
