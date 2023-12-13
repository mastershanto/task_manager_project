// Code of mine.
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task_manager_project/app_tm.dart';
import 'package:task_manager_project/ui/controllers/auth_controller.dart';
import '../../ui/ui_screens/profile_screens/login_screen.dart';
import 'network_response.dart';

class NetworkCaller {
  Future<NetworkResponse> postRequest(String url,
      {Map<String, dynamic>? body,bool isLogin=false}) async {
    try {
      log(url);
      log(body.toString());
      final Response response =
      await post(Uri.parse(url), body: jsonEncode(body), headers: {
        "content-type": "application/json",
        "token":AuthController.token.toString()
      });

      log(response.headers.toString());
      log(response.statusCode.toString());
      log(response.body.toString());

      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          jsonResponse: jsonDecode(response.body),
          statusCode: 200,
        );
      } else if(response.statusCode==401){
        if(isLogin==false){
          backToLogin();
        }

        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          jsonResponse: jsonDecode(response.body),
        );
      } else {
        log("Succeed Failed");
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          jsonResponse: jsonDecode(response.body),
        );
      }
    } catch (e) {
      return NetworkResponse(isSuccess: false, errorMessage: e.toString());
    }
  }

  Future<NetworkResponse> getRequest(String url,
      {bool isLogin=false}) async {
    try {
      log(url);
      // log(body.toString());
      final Response response =
      await get(Uri.parse(url), headers: {
        "content-type": "application/json",
        "token":AuthController.token.toString()
      });

      log(response.headers.toString());
      log(response.statusCode.toString());
      log(response.body.toString());

      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          jsonResponse: jsonDecode(response.body),
          statusCode: 200,
        );
      } else if(response.statusCode==401){

        backToLogin();
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          jsonResponse: jsonDecode(response.body),
        );
      } else {
        log("Succeed Failed");
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          jsonResponse: jsonDecode(response.body),
        );
      }
    } catch (e) {
      return NetworkResponse(isSuccess: false, errorMessage: e.toString());
    }
  }
}

void backToLogin(){
  AuthController.clearAuthData();
  Navigator.pushAndRemoveUntil(
      TaskManagerApp.navigatorKey.currentContext!, MaterialPageRoute(builder: (context){
    return   const LoginScreen();
  }),(rout)=> false
  );
}





/*
// Code of Rafat Vai
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';

import 'network_response.dart';

class NetworkCaller {
  Future<NetworkResponse> postRequest(String url,
      {Map<String, dynamic>? body}) async {
    try {
      log(url);
      log(body.toString());
      final Response response =
      await post(Uri.parse(url), body: jsonEncode(body), headers: {
        'Content-type': 'Application/json',
      });
      log(response.statusCode.toString());
      log(response.body.toString());
      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          jsonResponse: jsonDecode(response.body),
          statusCode: 200,
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          jsonResponse: jsonDecode(response.body),
        );
      }
    } catch (e) {
      return NetworkResponse(isSuccess: false, errorMessage: e.toString());
    }
  }
}
*/
