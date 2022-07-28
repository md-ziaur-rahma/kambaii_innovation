import 'package:get/get.dart';
import 'package:innovation/app/modules/about/about_screen.dart';
import 'package:innovation/app/modules/add_guardian/add_guardian_screen.dart';
import 'package:innovation/app/modules/add_student/add_student_screen.dart';
import 'package:innovation/app/modules/home/home_screen.dart';
import 'package:innovation/app/modules/idea_share/add_idea_share/add_idea_share_screen.dart';
import 'package:innovation/app/modules/login/login_screen_2.dart';
import 'package:innovation/app/modules/my_idea/image_show.dart';
import 'package:innovation/app/modules/my_idea/my_ideas_screen.dart';
import 'package:innovation/app/modules/my_idea/pdf_view_screen.dart';
import 'package:innovation/app/modules/my_webview/webview_screen.dart';
import 'package:innovation/app/modules/no_internet/no_internet.dart';
import 'package:innovation/app/modules/notice/notice_screen.dart';
import 'package:innovation/app/modules/notice_details/notice_details_screen.dart';
import 'package:innovation/app/modules/signup/signup_screen2.dart';
import 'package:innovation/app/modules/splash/splash_screen.dart';
import 'package:innovation/app/modules/students/student_list/student_list_screen.dart';
import 'package:innovation/app/modules/students/student_profile/student_profile_screen.dart';
import 'package:innovation/app/modules/success_pages/success_screen.dart';
import 'package:innovation/app/modules/update_info/choose__team_individual.dart';
import 'package:innovation/app/modules/update_info/institution_info_update/institution_update_screen.dart';
import 'package:innovation/app/modules/update_info/profile_update/profile_update_screen.dart';
import 'package:innovation/app/modules/update_info/team_member_update/team_member_update_screen.dart';
import 'package:innovation/app/modules/welcome/welcome_screen.dart';
import 'package:innovation/app/routes/routes.dart';

class Pages{
  static final pages = [
    GetPage(
      name: Routes.INITIAL,
      page: () => const SplashScreen()
    ),
    GetPage(
      name: Routes.NO_INTERNET,
      page: () => const NoInternetScreen()
    ),
    GetPage(
      name: Routes.WELCOME,
      page: () => WelcomeScreen()
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginScreen2()
    ),
    GetPage(
      name: Routes.SIGNUP,
      page: () => SignupScreen2()
    ),
    GetPage(
      name: Routes.HOME,
      page: () => HomeScreen()
    ),
    GetPage(
      name: Routes.ADD_GUARDIAN,
      page: () => AddGuardianScreen()
    ),
    GetPage(
      name: Routes.ADD_STUDENT,
      page: () => const AddStudentScreen()
    ),
    GetPage(
      name: Routes.STUDENT_LIST,
      page: () => const StudentListScreen()
    ),
    GetPage(
      name: Routes.STUDENT_PROFILE,
      page: () => const StudentProfileScreen()
    ),
    GetPage(
      name: Routes.CHOOSE_TEAM_INDIVIDUAL,
      page: () => ChooseTeamOrIndividual()
    ),
    GetPage(
      name: Routes.STUDENT_GUARDIAN_UPDATE,
      page: () => const StudentListScreen()
    ),
    GetPage(
      name: Routes.STUDENT_PROFILE_UPDATE,
      page: () => const StudentProfileUpdateScreen()
    ),
    GetPage(
      name: Routes.STUDENT_INSTITUTE_UPDATE,
      page: () => const StudentInstituteUpdateScreen()
    ),
    GetPage(
      name: Routes.IDEA_TYPE_CHOOSE,
      page: () => const AddIdeaShareScreen()
    ),
    GetPage(
      name: Routes.SUCCESS_SCREEN,
      page: () => const SuccessScreen()
    ),
    GetPage(
      name: Routes.MY_IDEAS,
      page: () => MyIdeasScreen()
    ),
    GetPage(
      name: Routes.NOTICE,
      page: () => const NoticeScreen()
    ),
    GetPage(
      name: Routes.NOTICE_DETAILS,
      page: () => const NoticeDetailsScreen()
    ),
    GetPage(
      name: Routes.TEAM_MEMBER,
      page: () => const TeamMemberUpdateScreen()
    ),
    GetPage(
      name: Routes.PDF_DOCUMENT,
      page: () => const PdfViewScreen()
    ),
    GetPage(
      name: Routes.IMAGE_SHOW,
      page: () => const ShowImage()
    ),
    GetPage(
      name: Routes.ABOUT_US,
      page: () => const AboutScreen()
    ),
    GetPage(
      name: Routes.WEBVIEW,
      page: () => const MyWebViewScreen()
    ),
  ];
}