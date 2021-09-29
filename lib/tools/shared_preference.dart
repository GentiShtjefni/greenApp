import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference{

  static String userLoggedIn = "loggedin";
  static String userNameKey = "usernamekey";
  static String userEmailKey = "useremailkey";

  Future <bool> saveUserName (String? getUserName) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userNameKey, getUserName!);
  }
  Future <bool> saveUserLoggedIn (bool isUserLoggedIn) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(userLoggedIn, isUserLoggedIn);
  }
  Future <bool> saveEmail (String? getUserName) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userEmailKey, getUserName!);
  }


  Future<String?> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userNameKey);
  }
  Future<bool?> getUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(userLoggedIn);
  }
  Future<String?> getEmailId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userEmailKey);
  }

}