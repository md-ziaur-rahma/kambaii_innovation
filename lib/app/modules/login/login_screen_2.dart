import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:innovation/app/core/values/colors.dart';
import 'package:innovation/app/global_widget/common.dart';
import 'package:innovation/app/global_widget/usa_logo_layout.dart';
import 'package:innovation/app/modules/home/home_controller.dart';
import 'package:innovation/app/modules/login/login_controller.dart';
import 'package:innovation/app/routes/routes.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen2 extends StatelessWidget {
  LoginScreen2({Key? key}) : super(key: key);

  final homeController = Get.put(HomeController());
  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
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
            child: GetBuilder<LoginController>(
              init: LoginController(),
              builder: (controller){
                return ModalProgressHUD(
                  inAsyncCall: controller.isLoading.value,
                  child: SafeArea(
                    child: CustomScrollView(
                      scrollDirection: Axis.vertical,
                      slivers: [
                        SliverToBoxAdapter(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CridUsaLogoLayout().cridLogo(120, Alignment.topLeft),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Image(
                                    image: AssetImage("images/${homeController.getUserTypePic()}.png"),
                                    height: 70,
                                    // width: MediaQuery.of(context).size.width * 0.4,
                                  ),
                                ),
                              ],
                            )
                        ),
                        const SliverToBoxAdapter(
                          child: SizedBox(
                            height: 30,
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 30,),
                            margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 0,),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Form(
                              key: controller.loginKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                      width: double.infinity,
                                      child: Text(homeController.getUserType(),textAlign: TextAlign.center,style: TextStyle(color: AppColors.mainColorBlack,fontSize: 22,fontWeight: FontWeight.bold),)),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text("Log in to continue",style: TextStyle(color: AppColors.background,
                                      fontSize: 16,fontWeight: FontWeight.w500),),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 0),
                                    // height: 45,
                                    child: TextFormField(
                                      validator: controller.validationMobile,
                                      controller: controller.phoneController,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      maxLines: 1,
                                      onSaved: (String? val) {
                                        controller.email = val;
                                      },
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                                        hintText: 'Mobile',
                                        // labelText: 'Email',
                                        // isDense: true,
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: AppColors.textFieldFocus),
                                        ),
                                        errorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.red.withOpacity(0.7)),
                                        ),
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(color: AppColors.textField),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: AppColors.textField),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 0),
                                    // height: 45,
                                    child: TextFormField(
                                      validator: controller.validationPassword,
                                      controller: controller.passwordController,
                                      keyboardType: TextInputType.visiblePassword,
                                      obscureText: controller.obscureText.value,
                                      maxLines: 1,
                                      onSaved: (String? val) {
                                        controller.password = val;
                                      },
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding:
                                        const EdgeInsets.symmetric(horizontal: 0,vertical: 16),
                                        hintText: 'Password*',
                                        // labelText: 'Password*',
                                        isDense: true,
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            controller.toggle();
                                          },
                                          icon: controller.obscureText.value
                                              ? const Icon(
                                            Icons.visibility_off,
                                            color: Colors.black54,
                                          )
                                              : const Icon(
                                            Icons.visibility,
                                            color: Colors.black54,
                                          ),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: AppColors.textFieldFocus),
                                        ),
                                        errorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: Colors.red.withOpacity(0.7)),
                                        ),
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(color: AppColors.textField),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: AppColors.textField),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                            height: 40,
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () async {
                                  if (controller.loginKey.currentState!.validate()) {
                                    controller.loginKey.currentState!.save();
                                    try {
                                      final result = await InternetAddress.lookup(
                                          'example.com');
                                      if (result.isNotEmpty &&
                                          result[0].rawAddress.isNotEmpty) {
                                        controller.login();
                                        // Get.offAllNamed(Routes.HOME);
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
                                  'LOG IN',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                )
                            ),
                          ),
                        ),
                        // SliverToBoxAdapter(
                        //   child: Container(
                        //     padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 0),
                        //     child: Row(
                        //       mainAxisSize: MainAxisSize.max,
                        //       crossAxisAlignment: CrossAxisAlignment.center,
                        //       children: [
                        //         Expanded(
                        //           child: Divider(
                        //             thickness: 1,
                        //             color: AppColors.mainColor.withOpacity(0.5),
                        //           ),
                        //         ),
                        //         Container(
                        //           padding: const EdgeInsets.all(8),
                        //           decoration: BoxDecoration(
                        //               borderRadius: BorderRadius.circular(50),
                        //               border: Border.all(color: AppColors.mainColor.withOpacity(0.5),width: 1)
                        //           ),
                        //           child: Text("OR",style: TextStyle(color: AppColors.mainColor.withOpacity(0.5),),),
                        //         ),
                        //         Expanded(
                        //           child: Divider(
                        //             thickness: 1,
                        //             color: AppColors.mainColor.withOpacity(0.5),
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // SliverToBoxAdapter(
                        //   child: Padding(
                        //     padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 50),
                        //     child: Row(
                        //       mainAxisSize: MainAxisSize.max,
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       crossAxisAlignment: CrossAxisAlignment.center,
                        //       children: [
                        //         // Material(
                        //         //   borderRadius: BorderRadius.circular(50),
                        //         //   child: InkWell(
                        //         //     borderRadius: BorderRadius.circular(50),
                        //         //     onTap: (){
                        //         //       controller.signInWithFacebook();
                        //         //     },
                        //         //     child: Image(
                        //         //       image: AssetImage("icons/facebook.png"),
                        //         //       height: 40,
                        //         //       width: 40,
                        //         //     ),
                        //         //   ),
                        //         // ),
                        //         const SizedBox(
                        //           width: 16,
                        //         ),
                        //         Material(
                        //           borderRadius: BorderRadius.circular(50),
                        //           child: InkWell(
                        //             borderRadius: BorderRadius.circular(50),
                        //             onTap: (){
                        //               controller.getGoogleData();
                        //             },
                        //             child: const Image(
                        //               image: AssetImage("icons/google.png"),
                        //               height: 40,
                        //               width: 40,
                        //             ),
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        SliverToBoxAdapter(
                          child: Align(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: (){
                                Get.toNamed(Routes.SIGNUP);
                              },
                              child: RichText(
                                text: const TextSpan(
                                    text: "Don't you have an account? ",
                                    style: TextStyle(color: Colors.black54),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: "Sign up",
                                        style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w500,decoration: TextDecoration.underline),
                                      )
                                    ]
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
