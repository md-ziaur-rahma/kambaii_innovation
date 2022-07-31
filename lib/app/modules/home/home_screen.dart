import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:innovation/app/core/utils/my_sharedpreferences.dart';
import 'package:innovation/app/core/values/colors.dart';
import 'package:innovation/app/modules/home/home_controller.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upgrader/upgrader.dart';

import '../../core/utils/urls.dart';
import '../../global_widget/common.dart';
import '../../routes/routes.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  Future<void> logout(BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    Client client = Client();
    Uri url = Uri.parse(
        '${Urls.baseUrl}getlogout?token=${MySharedPreference.token}');
    print('logout ($url)');
    try {
      var response = await client.get(url);
      if (response.statusCode == 200) {
        localStorage.clear();
        Get.offAllNamed(Routes.WELCOME);
        if (response.body.isNotEmpty) {

        }
      } else {
        throw Exception('Failed to load post');
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    homeController.getParticipantData();
    // final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return Scaffold(
            body: ModalProgressHUD(
              inAsyncCall: controller.isLoading.value,
              child: UpgradeAlert(
                upgrader: Upgrader(
                  dialogStyle: Platform.isIOS ? UpgradeDialogStyle.cupertino : UpgradeDialogStyle.material,
                ),
                child: Container(
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
                        // SliverAppBar(
                        //   expandedHeight: 200,
                        //   floating: false,
                        //   pinned: true,
                        //   iconTheme: const IconThemeData(color: Colors.white),
                        //   systemOverlayStyle: SystemUiOverlayStyle(
                        //       statusBarColor: AppColors.mainColor,
                        //       statusBarIconBrightness: Brightness.light),
                        //   flexibleSpace: const FlexibleSpaceBar(
                        //     stretchModes: [
                        //       StretchMode.blurBackground,
                        //       StretchMode.fadeTitle,
                        //       StretchMode.zoomBackground
                        //     ],
                        //     collapseMode: CollapseMode.pin,
                        //     title: Text(
                        //       'Innovative Idea Share',
                        //       // 'Snowtex \nMachine Management',
                        //       textAlign: TextAlign.start,
                        //       style: TextStyle(color: Color(0xFF000000)),
                        //       // style: TextStyle(color: Color(0xFFFFFFFF)),
                        //     ),
                        //     centerTitle: false,
                        //     background: Image(
                        //       image: AssetImage('images/crid_logo_w.png'),
                        //       fit: BoxFit.fill,
                        //     ),
                        //   ),
                        //   actions: [
                        //     IconButton(
                        //         onPressed: () {
                        //           Get.defaultDialog(
                        //               title: "Logout Alert",
                        //               content: const Text(
                        //                 "Are you sure?\nYou want to logout?",
                        //                 textAlign: TextAlign.center,
                        //               ),
                        //               actions: [
                        //                 OutlinedButton(
                        //                     onPressed: () {
                        //                       Navigator.pop(context);
                        //                     },
                        //                     child: const Text("Cancel")),
                        //                 OutlinedButton(
                        //                     onPressed: () {
                        //                       logout(context);
                        //                     },
                        //                     child: const Text("Logout")),
                        //               ]);
                        //         },
                        //         icon: const Icon(Icons.logout))
                        //   ],
                        // ),
                        SliverToBoxAdapter(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 30),
                            // color: Colors.white,
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:[
                                Image(
                                  image: const AssetImage("images/innovation_hori_logo.png"),
                                  height: 120,
                                  width: MediaQuery.of(context).size.width * 0.5,
                                ),
                                Image(
                                  image: AssetImage("images/${controller.getUserTypePic()}.png"),
                                  height: 120,
                                  width: 80,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: SizedBox(
                            width: double.infinity,
                            child: Text("Choose Your Option",textAlign: TextAlign.center,style: TextStyle(color: AppColors.mainColor,fontSize: 22,fontWeight: FontWeight.w500),),
                          ),
                        ),
                        SliverLayoutBuilder(
                          builder: (BuildContext context, SliverConstraints constraints){
                            if(controller.typeOfUser == 1){
                              return SliverPadding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                                sliver: SliverGrid.count(
                                  crossAxisSpacing: 30,
                                  mainAxisSpacing: 30,
                                  crossAxisCount: 2,
                                  children: [
                                    Material(
                                        color: Colors.white,
                                        elevation: 3,
                                        borderRadius: BorderRadius.circular(10.0),
                                        child: InkWell(
                                          onTap: () async {
                                            try {
                                              final result =
                                              await InternetAddress.lookup('example.com');
                                              if (result.isNotEmpty &&
                                                  result[0].rawAddress.isNotEmpty) {
                                                if(controller.participantDataModel.data?.registrationStep == "step4"){
                                                  Common.toastMsg("Already submitted idea!");
                                                  return;
                                                }
                                                MySharedPreference.participantId = MySharedPreference.userId;
                                                // ..... Check update full data fill or not........
                                                if(controller.isReadyForIdeaSubmit()){
                                                  Get.toNamed(Routes.IDEA_TYPE_CHOOSE);
                                                } else {
                                                  // Get.toNamed(Routes.TEAM_MEMBER);
                                                  // Get.toNamed(Routes.STUDENT_PROFILE_UPDATE);
                                                  Get.toNamed(Routes.CHOOSE_TEAM_INDIVIDUAL);
                                                }
                                              } else {
                                                // not connected
                                                Common.toastMsg("No Internet Connection");
                                              }
                                            } on SocketException catch (_) {
                                              Common.toastMsg("No Internet Connection");
                                            }
                                          },
                                          borderRadius: BorderRadius.circular(10.0),
                                          child: const ButtonCard2(
                                              name: 'Add Idea',
                                              image: "images/plus.png"),
                                        )),
                                    Material(
                                        color: Colors.white,
                                        elevation: 3,
                                        borderRadius: BorderRadius.circular(10.0),
                                        child: InkWell(
                                          onTap: () async {
                                            try {
                                              final result =
                                              await InternetAddress.lookup('example.com');
                                              if (result.isNotEmpty &&
                                                  result[0].rawAddress.isNotEmpty) {
                                                // connected
                                                if(controller.participantDataModel.data?.registrationStep == "step4"){
                                                  Get.toNamed(Routes.MY_IDEAS,arguments: {"userId":"${MySharedPreference.userId}"});
                                                } else {
                                                  Common.toastMsg("You haven't submit any Idea");
                                                  controller.getParticipantData();
                                                }

                                              } else {
                                                // not connected
                                                Common.toastMsg("No Internet Connection");
                                              }
                                            } on SocketException catch (_) {
                                              Common.toastMsg("No Internet Connection");
                                            }
                                          },
                                          borderRadius: BorderRadius.circular(10.0),
                                          child: const ButtonCard2(
                                              name: 'My Ideas',
                                              image: "images/worry.png"),
                                        )),
                                    Material(
                                        color: Colors.white,
                                        elevation: 3,
                                        borderRadius: BorderRadius.circular(10.0),
                                        child: InkWell(
                                          onTap: () async {
                                            try {
                                              final result =
                                              await InternetAddress.lookup('example.com');
                                              if (result.isNotEmpty &&
                                                  result[0].rawAddress.isNotEmpty) {
                                                // connected
                                                print("${MySharedPreference.userId}");
                                                print("${MySharedPreference.token}");
                                                Get.toNamed(Routes.NOTICE);
                                              } else {
                                                // not connected
                                                Common.toastMsg("No Internet Connection");
                                              }
                                            } on SocketException catch (_) {
                                              Common.toastMsg("No Internet Connection");
                                            }
                                          },
                                          borderRadius: BorderRadius.circular(10.0),
                                          child: const ButtonCard2(
                                              name: 'Notice', image: "images/noticeboard2.png"),
                                        )),
                                    Material(
                                      color: Colors.white,
                                      elevation: 3,
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: InkWell(
                                        onTap: () async {
                                          try {
                                            final result =
                                            await InternetAddress.lookup('example.com');
                                            if (result.isNotEmpty &&
                                                result[0].rawAddress.isNotEmpty) {
                                              // connected
                                              Get.toNamed(Routes.STUDENT_PROFILE);
                                            } else {
                                              // not connected
                                              Common.toastMsg("No Internet Connection");
                                            }
                                          } on SocketException catch (_) {
                                            Common.toastMsg("No Internet Connection");
                                          }
                                        },
                                        borderRadius: BorderRadius.circular(10.0),
                                        child: const ButtonCard2(
                                            name: 'Profile', image: "images/user.png"),
                                      ),
                                    ),
                                    Material(
                                        color: Colors.white,
                                        elevation: 3,
                                        borderRadius: BorderRadius.circular(10.0),
                                        child: InkWell(
                                          onTap: () async {
                                            try {
                                              final result =
                                              await InternetAddress.lookup('example.com');
                                              if (result.isNotEmpty &&
                                                  result[0].rawAddress.isNotEmpty) {
                                                // connected
                                                print("${MySharedPreference.userId}");
                                                print("${MySharedPreference.token}");
                                                Get.toNamed(Routes.ABOUT_US);
                                              } else {
                                                // not connected
                                                Common.toastMsg("No Internet Connection");
                                              }
                                            } on SocketException catch (_) {
                                              Common.toastMsg("No Internet Connection");
                                            }
                                          },
                                          borderRadius: BorderRadius.circular(10.0),
                                          child: const ButtonCard2(
                                              name: 'About Us',
                                              image: "images/info.png"),
                                        )),
                                  ],
                                ),
                              );
                            } else {
                              return SliverPadding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                                sliver: SliverGrid.count(
                                  crossAxisSpacing: 30,
                                  mainAxisSpacing: 30,
                                  crossAxisCount: 2,
                                  children: [
                                    // Material(
                                    //     color: Colors.white,
                                    //     elevation: 3,
                                    //     borderRadius: BorderRadius.circular(10.0),
                                    //     child: InkWell(
                                    //       onTap: () async {
                                    //         try {
                                    //           final result =
                                    //           await InternetAddress.lookup('example.com');
                                    //           if (result.isNotEmpty &&
                                    //               result[0].rawAddress.isNotEmpty) {
                                    //             // connected
                                    //             Get.toNamed(Routes.MY_IDEAS);
                                    //           } else {
                                    //             // not connected
                                    //             Common.toastMsg("No Internet Connection");
                                    //           }
                                    //         } on SocketException catch (_) {
                                    //           Common.toastMsg("No Internet Connection");
                                    //         }
                                    //       },
                                    //       borderRadius: BorderRadius.circular(10.0),
                                    //       child: const ButtonCard2(
                                    //           name: 'My Ideas',
                                    //           image: "images/worry.png"),
                                    //     )),
                                    Material(
                                        color: Colors.white,
                                        elevation: 3,
                                        borderRadius: BorderRadius.circular(10.0),
                                        child: InkWell(
                                          onTap: () async {
                                            try {
                                              final result =
                                              await InternetAddress.lookup('example.com');
                                              if (result.isNotEmpty &&
                                                  result[0].rawAddress.isNotEmpty) {
                                                // connected
                                                // print("${MySharedPreference.userId}");
                                                Get.toNamed(Routes.ADD_STUDENT);
                                              }else {
                                                // not connected
                                                Common.toastMsg("No Internet Connection");
                                              }
                                            } on SocketException catch (_) {
                                              Common.toastMsg("No Internet Connection");
                                            }
                                          },
                                          borderRadius: BorderRadius.circular(10.0),
                                          child: ButtonCard2(
                                              name: 'Add ${controller.getButtonText()}',
                                              image: "images/graduate.png"),
                                        )),
                                    Material(
                                        color: Colors.white,
                                        elevation: 3,
                                        borderRadius: BorderRadius.circular(10.0),
                                        child: InkWell(
                                          onTap: () async {
                                            try {
                                              final result =
                                              await InternetAddress.lookup('example.com');
                                              if (result.isNotEmpty &&
                                                  result[0].rawAddress.isNotEmpty) {
                                                // connected
                                                Get.toNamed(Routes.STUDENT_LIST);
                                              }else {
                                                // not connected
                                                Common.toastMsg("No Internet Connection");
                                              }
                                            } on SocketException catch (_) {
                                              Common.toastMsg("No Internet Connection");
                                            }
                                          },
                                          borderRadius: BorderRadius.circular(10.0),
                                          child: ButtonCard2(
                                              name: 'My ${controller.getButtonText()}',
                                              image: "images/students.png"),
                                        )),
                                    Material(
                                        color: Colors.white,
                                        elevation: 3,
                                        borderRadius: BorderRadius.circular(10.0),
                                        child: InkWell(
                                          onTap: () async {
                                            try {
                                              final result =
                                              await InternetAddress.lookup('example.com');
                                              if (result.isNotEmpty &&
                                                  result[0].rawAddress.isNotEmpty) {
                                                // ..... Check update full data fill or not........
                                                if(controller.isReadyForIdeaSubmit()){
                                                  Get.toNamed(Routes.IDEA_TYPE_CHOOSE);
                                                } else {
                                                  Get.toNamed(Routes.STUDENT_LIST);
                                                  // Get.toNamed(Routes.STUDENT_PROFILE_UPDATE);
                                                }
                                              } else {
                                                // not connected
                                                Common.toastMsg("No Internet Connection");
                                              }
                                            } on SocketException catch (_) {
                                              Common.toastMsg("No Internet Connection");
                                            }
                                          },
                                          borderRadius: BorderRadius.circular(10.0),
                                          child: const ButtonCard2(
                                              name: 'Add Idea',
                                              image: "images/plus.png"),
                                        )),
                                    Material(
                                      color: Colors.white,
                                      elevation: 3,
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: InkWell(
                                        onTap: () async {
                                          try {
                                            final result =
                                            await InternetAddress.lookup('example.com');
                                            if (result.isNotEmpty &&
                                                result[0].rawAddress.isNotEmpty) {
                                              // connected
                                              Get.toNamed(Routes.STUDENT_PROFILE);
                                            } else {
                                              // not connected
                                              Common.toastMsg("No Internet Connection");
                                            }
                                          } on SocketException catch (_) {
                                            Common.toastMsg("No Internet Connection");
                                          }
                                        },
                                        borderRadius: BorderRadius.circular(10.0),
                                        child: const ButtonCard2(
                                            name: 'Profile', image: "images/user.png"),
                                      ),
                                    ),
                                    Material(
                                        color: Colors.white,
                                        elevation: 3,
                                        borderRadius: BorderRadius.circular(10.0),
                                        child: InkWell(
                                          onTap: () async {
                                            try {
                                              final result =
                                              await InternetAddress.lookup('example.com');
                                              if (result.isNotEmpty &&
                                                  result[0].rawAddress.isNotEmpty) {
                                                // connected
                                                print("${MySharedPreference.userId}");
                                                print("${MySharedPreference.token}");
                                                Get.toNamed(Routes.NOTICE);
                                              } else {
                                                // not connected
                                                Common.toastMsg("No Internet Connection");
                                              }
                                            } on SocketException catch (_) {
                                              Common.toastMsg("No Internet Connection");
                                            }
                                          },
                                          borderRadius: BorderRadius.circular(10.0),
                                          child: const ButtonCard2(
                                              name: 'Notice', image: "images/noticeboard2.png"),
                                        )),
                                    // Material(
                                    //     color: Colors.white,
                                    //     elevation: 3,
                                    //     borderRadius: BorderRadius.circular(10.0),
                                    //     child: InkWell(
                                    //       onTap: () async {
                                    //         try {
                                    //           final result =
                                    //           await InternetAddress.lookup('example.com');
                                    //           if (result.isNotEmpty &&
                                    //               result[0].rawAddress.isNotEmpty) {
                                    //             // connected
                                    //             Get.toNamed(Routes.ADD_GUARDIAN,arguments: {"title": "Add Guardian",});
                                    //           } else {
                                    //             // not connected
                                    //             Common.toastMsg("No Internet Connection");
                                    //           }
                                    //         } on SocketException catch (_) {
                                    //           Common.toastMsg("No Internet Connection");
                                    //         }
                                    //       },
                                    //       borderRadius: BorderRadius.circular(10.0),
                                    //       child: const ButtonCard2(
                                    //           name: 'Add Guardian', image: "images/guardian.png"),
                                    //     )),
                                    // Material(
                                    //     color: Colors.white,
                                    //     elevation: 3,
                                    //     borderRadius: BorderRadius.circular(10.0),
                                    //     child: InkWell(
                                    //       onTap: () async {
                                    //         try {
                                    //           final result =
                                    //           await InternetAddress.lookup('example.com');
                                    //           if (result.isNotEmpty &&
                                    //               result[0].rawAddress.isNotEmpty) {
                                    //             // connected
                                    //             // Get.toNamed(Routes.BOOSTUP_TEAM);
                                    //           } else {
                                    //             // not connected
                                    //             Common.toastMsg("No Internet Connection");
                                    //           }
                                    //         } on SocketException catch (_) {
                                    //           Common.toastMsg("No Internet Connection");
                                    //         }
                                    //       },
                                    //       borderRadius: BorderRadius.circular(10.0),
                                    //       child: const ButtonCard2(
                                    //           name: 'Institute',
                                    //           image: "images/icon_institute.png"),
                                    //     )),
                                    Material(
                                        color: Colors.white,
                                        elevation: 3,
                                        borderRadius: BorderRadius.circular(10.0),
                                        child: InkWell(
                                          onTap: () async {
                                            try {
                                              final result =
                                              await InternetAddress.lookup('example.com');
                                              if (result.isNotEmpty &&
                                                  result[0].rawAddress.isNotEmpty) {
                                                // connected
                                                print("${MySharedPreference.userId}");
                                                print("${MySharedPreference.token}");
                                                Get.toNamed(Routes.ABOUT_US);
                                              } else {
                                                // not connected
                                                Common.toastMsg("No Internet Connection");
                                              }
                                            } on SocketException catch (_) {
                                              Common.toastMsg("No Internet Connection");
                                            }
                                          },
                                          borderRadius: BorderRadius.circular(10.0),
                                          child: const ButtonCard2(
                                              name: 'About Us',
                                              image: "images/info.png"),
                                        )),
                                  ],
                                ),
                              );
                            }
                          },
                        ),
                        const SliverToBoxAdapter(
                          child: SizedBox(
                            height: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
      },
    );
  }
}

class ButtonCard extends StatelessWidget {
  const ButtonCard({Key? key, this.name, this.image}) : super(key: key);
  // final IconData? icon;
  final String? image;
  final String? name;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).orientation == Orientation.portrait
          ? MediaQuery.of(context).size.width * 0.34
          : MediaQuery.of(context).size.height * 0.34,
      width: MediaQuery.of(context).orientation == Orientation.portrait
          ? MediaQuery.of(context).size.width * 0.34
          : MediaQuery.of(context).size.height * 0.34,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        // color: Colors.white,
        // boxShadow: [
        //   BoxShadow(
        //       blurRadius: 20.0,
        //       offset: const Offset(1,0),
        //       color: Colors.grey.withOpacity(0.5),
        //       spreadRadius: 1.0
        //   ),
        //   BoxShadow(
        //       blurRadius: 20.0,
        //       offset: const Offset(0,1),
        //       color: Colors.grey.withOpacity(0.5),
        //       spreadRadius: 1.0
        //   ),
        // ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: [
          Image(
            image: AssetImage(image!),
            height: 40,
            width: 40,
          ),
          // Icon(
          //   icon,
          //   color: const Color(0xFF31A3DD),
          //   size: 40,
          // ),
          Text(
            name!,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black87, fontSize: 14),
          )
        ],
      ),
    );
  }
}


class ButtonCard2 extends StatelessWidget {
  const ButtonCard2({Key? key, this.name, this.image}) : super(key: key);
  // final IconData? icon;
  final String? image;
  final String? name;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).orientation == Orientation.portrait
          ? MediaQuery.of(context).size.width * 0.34
          : MediaQuery.of(context).size.height * 0.34,
      width: MediaQuery.of(context).orientation == Orientation.portrait
          ? MediaQuery.of(context).size.width * 0.34
          : MediaQuery.of(context).size.height * 0.34,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        // color: Colors.white,
        // boxShadow: [
        //   BoxShadow(
        //       blurRadius: 20.0,
        //       offset: const Offset(1,0),
        //       color: Colors.grey.withOpacity(0.5),
        //       spreadRadius: 1.0
        //   ),
        //   BoxShadow(
        //       blurRadius: 20.0,
        //       offset: const Offset(0,1),
        //       color: Colors.grey.withOpacity(0.5),
        //       spreadRadius: 1.0
        //   ),
        // ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            name!,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black87, fontSize: 14),
          ),
          SizedBox(
            height: 16,
          ),
          Expanded(
            child: Image(
              image: AssetImage(image!),
            ),
          ),
        ],
      ),
    );
  }
}
