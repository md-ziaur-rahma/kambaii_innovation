import 'package:fluttertoast/fluttertoast.dart';
import 'package:innovation/app/core/values/colors.dart';

class Utils {
  static void createToast(String msg){
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.mainColor,
        textColor: AppColors.white,
        fontSize: 16.0
    );
  }
}