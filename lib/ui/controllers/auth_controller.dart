import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_project/data/models/user_model.dart';

class AuthController{
  static  String? token;
  static UserModel? user;


  static Future <void> saveUserInformation(String t, UserModel model)async {
    SharedPreferences prefs= await SharedPreferences.getInstance();
    await prefs.setString("token", t);
    await prefs.setString("user", jsonEncode(model.toJson())); //jsonEncode used as against use of .toString()
    token=t;
    user=model;
  }

  static Future <void> initializeUserCache() async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    token=prefs.getString("token");
    user= UserModel.fromJson(jsonDecode(prefs.getString("user")??"{}"));
  }

  static Future<bool> checkAuthState() async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    if(token!=null){
      await initializeUserCache();
      return true;
    }
    return false;
  }

  static Future<void> clearAuthData() async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    await prefs.clear();
  }

}