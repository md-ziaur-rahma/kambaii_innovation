import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CridUsaLogoLayout{
  cridLogo(double size,Alignment alignment){
    return Align(
      alignment: alignment,
      child: Image(
        image: const AssetImage("images/innovation_hori_logo.png"),
        height: size,
        width: size * 1.3,
        // width: MediaQuery.of(Get.context!).size.width * 0.5,
      ),
    );
  }
}