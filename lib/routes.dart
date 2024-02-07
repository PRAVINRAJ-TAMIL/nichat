import 'package:get/get.dart';
import 'package:neechat/BottomNavigation/auth_ser.dart';
import 'package:neechat/BottomNavigation/bottomNavigat.dart';
import 'package:neechat/login/login_Screen.dart';
import 'package:neechat/login/signup.dart';

class Routes {
  static String bottomnavigation = "/bottomnavigation"; // Skip
  static String signup = "/signup"; //signup
  static String loginscreen = "/loginscreen"; //signin
  static String auth = "/auth";
  static String bookappointment = "/bookappointment";

  final getpages = [
    GetPage(name: bottomnavigation, page: (() => const BottomNAvigation())),
    GetPage(name: signup, page: (() => const SignUp())),
    GetPage(name: loginscreen, page: (() => const LoginScreen())),
    GetPage(name: auth, page: (() => const Auth())),
  ];
}
