
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:innovation/app/core/values/colors.dart';

import 'app/modules/splash/splash_screen.dart';
import 'app/routes/pages.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
  }

  MaterialColor appColor = const MaterialColor(
    0xff2D8CFF,
    <int, Color>{
      50: Color(0xff2D8CFF),
      100: Color(0xff2D8CFF),
      200: Color(0xff2D8CFF),
      300: Color(0xff2D8CFF),
      400: Color(0xff2D8CFF),
      500: Color(0xff2D8CFF),
      600: Color(0xff2D8CFF),
      700: Color(0xff2D8CFF),
      800: Color(0xff2D8CFF),
      900: Color(0xff2D8CFF),
    },
  );

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Kambaii Innovation',
      debugShowCheckedModeBanner: false,
      transitionDuration: const Duration(milliseconds: 300),
      defaultTransition: Transition.cupertino,
      theme: ThemeData(
        useMaterial3: true,
          primarySwatch: appColor,
          hoverColor: appColor,
          primaryColor: appColor,
        appBarTheme: AppBarTheme(
          iconTheme: const IconThemeData(color: Colors.white,),
          backgroundColor: AppColors.mainColor,
          systemOverlayStyle: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light,statusBarColor: AppColors.mainColor)
        )
      ),
      home: const SplashScreen(),
      getPages: Pages.pages,
    );
  }
}

// flutter build apk --release --target-platform=android-arm64

/**
 * Student List.
 * Notice.
 * Student Profile Data.
 * About Us.
 * My Ideas.
 * Login and signup e User wise design.
 * keytool -list -v -keystore "C:\Users\yourusernamehere\.android\debug.keystore" -alias androiddebugkey -storepass android -keypass android
 */