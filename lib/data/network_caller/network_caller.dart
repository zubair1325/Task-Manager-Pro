import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task_manager_pro/app.dart';
import 'package:task_manager_pro/data/network_caller/network_response.dart';
import 'package:task_manager_pro/ui/controller/auth_controller.dart';
import 'package:task_manager_pro/ui/screens/login_screen.dart';

class NetworkCaller {
  Future<NetworkResponse> postRequest(
    String url, {
    Map<String, dynamic>? body,
    bool isLogin = false,
  }) async {
    try {
      final Response response = await post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: {
          'Content-type': "Application/json",
          "token": AuthController.token.toString(),
        },
      );
      print("****************");
      print(AuthController.token.toString());
      // print(jsonDecode(response.body));
      // log(response.body.toString());
      // log(response.statusCode.toString());
      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          jsonResponse: jsonDecode(response.body),
        );
      } else if (response.statusCode == 401 && !isLogin) {
        backToLLogin();
      }
      return NetworkResponse(
        isSuccess: false,
        statusCode: response.statusCode,
        jsonResponse: jsonDecode(response.body),
      );
    } catch (e) {
      return NetworkResponse(isSuccess: false, errorMessage: e.toString());
    }
  }

  Future<NetworkResponse> getRequest(String url) async {
    try {
       await AuthController.checkAuthState();
      final Response response = await get(
        Uri.parse(url),
        headers: {
          'Content-type': "Application/json",
          "token": AuthController.token.toString(),
        },
      );
      print(jsonDecode(response.statusCode.toString()));
      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          jsonResponse: jsonDecode(response.body),
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          jsonResponse: jsonDecode(response.body),
        );
      }
    } catch (e) {
      print(e.toString());
      return NetworkResponse(isSuccess: false, errorMessage: e.toString());
    }
  }

  void backToLLogin() async {
    await AuthController.clearAuthData();
    Navigator.pushAndRemoveUntil(
      TaskManagerApp.navigationKey.currentContext!,
      MaterialPageRoute(builder: (builder) => LoginScreen()),
      (predicate) => false,
    );
  }
}
