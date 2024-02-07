import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static String userId = "USERID";
  static String userName = "USERNAME";
  static String disName = "USERDISNAME";
  static String userMail = "USERMAIL";
  static String userImg = "USERIMG";

  Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userId);
  }

  Future<bool> saveUserId(String getUserId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userId, getUserId);
  }

  Future<String?> getUserMail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userMail);
  }

  Future<bool> saveUserMail(String getUserMail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userMail, getUserMail);
  }

  Future<String?> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userName);
  }

  Future<bool> saveUserName(String getUserName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userName, getUserName);
  }

  Future<String?> getUserImg() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userImg);
  }

  Future<bool> saveUserImg(String getUserImg) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userImg, getUserImg);
  }

  Future<String?> getdisName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(disName);
  }

  Future<bool> saveUserdisName(String getUserdisName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(disName, getUserdisName);
  }

  Future<bool> saveUserDisplayName(String getUserDisplayName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(disName, getUserDisplayName);
  }
}
