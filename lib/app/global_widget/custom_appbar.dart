import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar{
  simpleAppBar(String title){
    return AppBar(
      title: Text(title,style: const TextStyle(color: Colors.black87,fontWeight: FontWeight.w400),),
      systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.white,statusBarIconBrightness: Brightness.dark),
      elevation: 0,
      titleSpacing: 0,
      iconTheme: const IconThemeData(color: Colors.black87),
      backgroundColor: Colors.white,
    );
  }

  colorAppBar(String title,Color color,bool isCenter){
    return AppBar(
      title: Text(title,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w400),),
      systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: color,statusBarIconBrightness: Brightness.light),
      elevation: 0,
      titleSpacing: 0,
      centerTitle: isCenter,
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: color,
    );
  }
  colorAppBar2(String title,Color color,bool isCenter){
    return AppBar(
      title: Text(title,style: const TextStyle(color: Colors.black87,fontWeight: FontWeight.w400),),
      systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: color,statusBarIconBrightness: Brightness.dark),
      elevation: 0,
      titleSpacing: 0,
      centerTitle: isCenter,
      iconTheme: const IconThemeData(color: Colors.black87),
      backgroundColor: color,
    );
  }

  leadingIconAppBar(String title,Function onPressed,IconData icon){
    return AppBar(
      title: Text(title,style: const TextStyle(color: Colors.black87,fontWeight: FontWeight.w400),),
      systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.white,statusBarIconBrightness: Brightness.dark),
      elevation: 0,
      titleSpacing: 0,
      leading: IconButton(
        icon: Icon(icon),
        onPressed: ()=> onPressed(),
      ),
      iconTheme: const IconThemeData(color: Colors.black87),
      backgroundColor: Colors.white,
    );
  }

// AppBar(
// title: const Text("Bakery, Cakes & Dairy",style: TextStyle(color: Colors.white),),
// centerTitle: true,
// // backgroundColor: Colors.lightGreen,
// iconTheme: const IconThemeData(color: Colors.white),
// systemOverlayStyle: Platform.isIOS
// ? SystemUiOverlayStyle.light
//     : SystemUiOverlayStyle(
// statusBarIconBrightness: Brightness.light,
// statusBarColor: AppColors.mainColor),
// ),
}