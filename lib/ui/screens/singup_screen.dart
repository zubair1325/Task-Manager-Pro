import 'package:flutter/material.dart';
import 'package:task_manager_pro/data/network_caller/network_caller.dart';
import 'package:task_manager_pro/data/network_caller/network_response.dart';
import 'package:task_manager_pro/data/utility/urls.dart';
import 'package:task_manager_pro/ui/screens/login_screen.dart';
import 'package:task_manager_pro/ui/widget/body_background.dart';
import 'package:task_manager_pro/ui/widget/sanck_message.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({super.key});

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _singUpInProgress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 80),
                    Center(
                      child: Text(
                        "Join With Us",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      // todo validate email address with regex
                      controller: _emailTEController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(hintText: "Email"),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return "Email Address is required";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
            
                    TextFormField(
                      controller: _firstNameTEController,
                      decoration: InputDecoration(hintText: "First Name"),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return "Enter your first name";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _lastNameTEController,
                      decoration: InputDecoration(hintText: "Last Name"),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return "Enter your last name";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      //11 digit validation
                      controller: _mobileTEController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(hintText: "Mobile"),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return "Enter your  mobile number";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordTEController,
                      obscureText: true,
                      decoration: InputDecoration(hintText: "Password"),
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return "Enter your password";
                        } else if (value!.length < 6) {
                          return "password must be at least 6 character";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    Visibility(
                      visible: _singUpInProgress == false,
                      replacement: Center(
                        child: CircularProgressIndicator(color: Colors.green),
                      ),
                      child: ElevatedButton(
                        onPressed: _singUp,
                        child: Icon(Icons.arrow_circle_right_outlined),
                      ),
                    ),
                    SizedBox(height: 48),
            
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Have an account?",
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
                                builder: (builder) => LoginScreen(),
                              ),
                              (predicate) => false,
                            );
                          },
                          child: Text(
                            "Sing in",
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

  Future<void> _singUp() async {
    {
      if (_formKey.currentState!.validate()) {
        _singUpInProgress = true;
        if (mounted) {
          setState(() {});
        }

        print("sinup finle ${_firstNameTEController.text.trim()}");
        final NetworkResponse response = await NetworkCaller().postRequest(
          Urls.registration,
          body: {
            "firstname": _firstNameTEController.text.trim(),
            "lastname": _lastNameTEController.text.trim(),
            "email": _emailTEController.text.trim(),
            "mobile": _mobileTEController.text.trim(),
            "password": _passwordTEController.text,
          },
        );
        _singUpInProgress = false;
        if (mounted) {
          setState(() {});
        }
        if (response.isSuccess) {
          _clearTextFields();
          if (mounted) {
            showSnackMessage(
              context,
              "Account created successfully\nPlease login",
            );
          }
        } else {
          if (mounted) {
            showSnackMessage(context, "Operation failed", true);
          }
        }
      }
    }
  }

  void _clearTextFields() {
    _emailTEController.clear();
    _firstNameTEController.clear();
    _lastNameTEController.clear();
    _mobileTEController.clear();
    _passwordTEController.clear();
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
