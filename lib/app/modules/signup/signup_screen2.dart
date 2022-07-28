import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:innovation/app/core/values/colors.dart';
import 'package:innovation/app/global_widget/common.dart';
import 'package:innovation/app/global_widget/usa_logo_layout.dart';
import 'package:innovation/app/modules/home/home_controller.dart';
import 'package:innovation/app/modules/login/login_controller.dart';
import 'package:innovation/app/modules/signup/signup_controller.dart';
import 'package:innovation/app/routes/routes.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignupScreen2 extends StatelessWidget {
  SignupScreen2({Key? key}) : super(key: key);

  final homeController = Get.put(HomeController());
  final signupController = Get.put(SignupController());
  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignupController>(
      builder: (controller){
        return ModalProgressHUD(
          inAsyncCall: controller.isLoading.value,
          child: Scaffold(
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
                        height: 10,
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
                          key: controller.signupKey,
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
                              Text("Sign up to continue",style: TextStyle(color: AppColors.background,
                                  fontSize: 16,fontWeight: FontWeight.w500),),
                              const SizedBox(
                                height: 16,
                              ),
                              // ........ When Teacher's login ............
                              LayoutBuilder(
                                builder: (BuildContext context,BoxConstraints constraints){
                                  if(controller.homeController.typeOfUser == 2){
                                    return Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 0),
                                      // height: 45,
                                      width: double.infinity,
                                      child: TextFormField(
                                        controller: controller.instituteController,
                                        validator: controller.validationInstitute,
                                        cursorColor: Colors.black87,
                                        textInputAction: TextInputAction.next,
                                        onSaved: (String? val) {
                                          controller.institute = val;
                                        },
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          alignLabelWithHint: true,
                                          contentPadding: const EdgeInsets.symmetric(
                                              horizontal: 0, vertical: 16),
                                          hintText: 'Institute Name',
                                          // hintStyle: const TextStyle(
                                          //     color: Colors.black54, fontSize: 18),
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
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              ),


                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 0),
                                // height: 45,
                                width: double.infinity,
                                child: TextFormField(
                                  controller: controller.nameController,
                                  validator: controller.validationUserName,
                                  cursorColor: Colors.black87,
                                  textInputAction: TextInputAction.next,
                                  onSaved: (String? val) {
                                    controller.name = val;
                                  },
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    alignLabelWithHint: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 16),
                                    hintText: 'First Name',
                                    // hintStyle: const TextStyle(
                                    //     color: Colors.black54, fontSize: 18),
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
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 0),
                                // height: 45,
                                width: double.infinity,
                                child: TextFormField(
                                  textAlign: TextAlign.start,
                                  controller: controller.lastNameController,
                                  validator: controller.validationLastName,
                                  textInputAction: TextInputAction.next,
                                  maxLines: 1,
                                  cursorColor: Colors.black87,
                                  onSaved: (String? val) {
                                    controller.lastName = val;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 16),
                                    hintText: 'Last Name',
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
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 0),
                                // height: 45,
                                width: double.infinity,
                                child: TextFormField(
                                  textAlign: TextAlign.start,
                                  controller: controller.mobileController,
                                  validator: controller.validationMobile,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,
                                  maxLines: 1,
                                  cursorColor: Colors.black87,
                                  onSaved: (String? val) {
                                    controller.mobile = val;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 16),
                                    hintText: 'Mobile',
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
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 0),
                                // height: 45,
                                width: double.infinity,
                                child: TextFormField(
                                  textAlign: TextAlign.start,
                                  controller: controller.emailController,
                                  validator: controller.validationEmail,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.emailAddress,
                                  maxLines: 1,
                                  cursorColor: Colors.black87,
                                  onSaved: (String? val) {
                                    controller.email = val;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 16),
                                    hintText: 'Email (if any)',
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
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 0),
                                // height: 45,
                                width: double.infinity,
                                child: TextFormField(
                                  textAlign: TextAlign.start,
                                  controller: controller.passwordController,
                                  validator: controller.validationPassword,
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: controller.obscureText.value,
                                  maxLines: 1,
                                  cursorColor: Colors.black87,
                                  onSaved: (String? val) {
                                    controller.password = val;
                                  },
                                  decoration: InputDecoration(
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        controller.toggle();
                                      },
                                      child: controller.obscureText.value
                                          ? const Icon(
                                        Icons.visibility_off,
                                        color: Colors.black54,
                                      )
                                          : const Icon(
                                        Icons.visibility,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 16),
                                    hintText: 'Password',
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
                                height: 0,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 0),
                                // height: 45,
                                width: double.infinity,
                                child: TextFormField(
                                  textAlign: TextAlign.start,
                                  controller: controller.confirmPasswordController,
                                  validator: controller.validationConfirmPassword,
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: controller.obscureText.value,
                                  maxLines: 1,
                                  cursorColor: Colors.black87,
                                  onSaved: (String? val) {
                                    controller.confirmPassword = val;
                                  },
                                  decoration: InputDecoration(
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        controller.toggle();
                                      },
                                      child: controller.obscureText.value
                                          ? const Icon(
                                        Icons.visibility_off,
                                        color: Colors.black54,
                                      )
                                          : const Icon(
                                        Icons.visibility,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 16),
                                    hintText: 'Confirm Password',
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
                            if (controller.signupKey.currentState!.validate()) {
                              controller.signupKey.currentState!.save();
                              controller.loadingToggle();
                              try {
                                final result = await InternetAddress.lookup(
                                    'example.com');
                                if (result.isNotEmpty &&
                                    result[0].rawAddress.isNotEmpty) {
                                  controller.signup();
                                  // Get.offAllNamed(Routes.HOME);
                                }
                              } on SocketException catch (_) {
                                Common.toastMsg('No Internet Connection');
                                controller.loadingToggle();
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              primary: AppColors.mainColor,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(6.0)))),
                          child: const Text(
                            'SIGN UP',
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
                    //     padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                    //     child: Row(
                    //       mainAxisSize: MainAxisSize.max,
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       children: [
                    //         // Material(
                    //         //   borderRadius: BorderRadius.circular(50),
                    //         //   child: InkWell(
                    //         //     borderRadius: BorderRadius.circular(50),
                    //         //     onTap: (){},
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
                    //               loginController.getGoogleData();
                    //             },
                    //             child: Image(
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
                            // Get.toNamed(Routes.SIGNUP);
                            Get.back();
                          },
                          child: RichText(
                            text: const TextSpan(
                                text: "Already have you an account? ",
                                style: TextStyle(color: Colors.black54),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "Sign in",
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
            ),
          ),
        );
      },
    );
  }
}
