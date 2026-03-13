import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:task_manager_pro/data/models/user_model.dart';
import 'package:task_manager_pro/data/network_caller/network_caller.dart';
import 'package:task_manager_pro/data/network_caller/network_response.dart';
import 'package:task_manager_pro/data/utility/urls.dart';
import 'package:task_manager_pro/ui/controller/auth_controller.dart';
import 'package:task_manager_pro/ui/screens/forget_password_screen.dart';
import 'package:task_manager_pro/ui/screens/main_bottom_nav_screen.dart';
import 'package:task_manager_pro/ui/screens/singup_screen.dart';
import 'package:task_manager_pro/ui/widget/body_background.dart';
import 'package:task_manager_pro/ui/widget/sanck_message.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool _loginInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Form(
                key: _globalKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 80),
                    Center(
                      child: Text(
                        "Get Started With",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _emailTEController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(hintText: "Email"),
                      validator: (value) {
                        if (value?.trim().isEmpty ?? true) {
                          return "Provide a valid Email";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordTEController,
                      obscureText: true,
                      decoration: InputDecoration(hintText: "Password"),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return "Password must be at least 6 letters";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    Visibility(
                      visible: _loginInProgress == false,
                      replacement: Center(
                        child: CircularProgressIndicator(color: Colors.green),
                      ),
                      child: ElevatedButton(
                        onPressed: _login,
                        child: Icon(Icons.arrow_circle_right_outlined),
                      ),
                    ),
                    SizedBox(height: 48),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (builder) => ForgetPasswordScreen(),
                            ),
                            (predicate) => false,
                          );
                        },
                        child: Text(
                          "Forgot Password",
                          style: TextStyle(
                            color: Colors.grey.shade800,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Do'nt have an account?",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.black54,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (builder) => SingUpScreen(),
                              ),
                              (predicate) => false,
                            );
                          },
                          child: Text(
                            "Sing up",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future _login() async {
    if (_globalKey.currentState!.validate()) {
      _loginInProgress = true;
      if (mounted) {
        setState(() {});
      }

      NetworkResponse response = await NetworkCaller().postRequest(
        Urls.login,
        body: {
          'email': _emailTEController.text.trim(),
          'password': _passwordTEController.text,
        },
        isLogin: true,
      );
      _loginInProgress = false;
      if (mounted) {
        setState(() {});
      }
      if (response.isSuccess) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (builder) => MainBottomNavScreen()),
          (predicate) => false,
        );
        showSnackMessage(context, "Login success");
        await AuthController.saveUserInformation(
          response.jsonResponse!['token'],
          UserModel.fromJson(response.jsonResponse!['data']),
        );
      } else {
        if (response.statusCode == 401) {
          showSnackMessage(context, "Please check email or password", true);
        } else {
          showSnackMessage(context, "Login Failed, Try again", true);
        }
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailTEController.dispose();
    _passwordTEController.dispose();
  }
}
