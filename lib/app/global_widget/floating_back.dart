import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:innovation/app/core/values/colors.dart';
import '../core/utils/my_sharedpreferences.dart';

class FloatingBack extends StatelessWidget {
  const FloatingBack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.transparent,
      onPressed: (){},
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.mainColor,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: (){
            // print("${MySharedPreference.userId}");
            // print("${MySharedPreference.token}");
            Get.back();
          },
          child: const Padding(
            padding: EdgeInsets.all(12.0),
            child: Icon(Icons.arrow_back_outlined,color: Colors.white,),
          ),
        ),
      ),
    );
  }
}
