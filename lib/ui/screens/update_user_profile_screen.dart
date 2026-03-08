import 'package:flutter/material.dart';
import 'package:task_manager_pro/ui/screens/main_bottom_nav_screen.dart';
import 'package:task_manager_pro/ui/widget/body_background.dart';
import 'package:task_manager_pro/ui/widget/profile_summary_card.dart';

class UpdateUserProfileScreen extends StatefulWidget {
  const UpdateUserProfileScreen({super.key});

  @override
  State<UpdateUserProfileScreen> createState() =>
      _UpdateUserProfileScreenState();
}

class _UpdateUserProfileScreenState extends State<UpdateUserProfileScreen> {
  final bool ignoreOnTap = false;
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              ProfileSummaryCard(ignoreOnTap: true),
              Expanded(
                child: BodyBackground(
                  child: Padding(
                    padding: EdgeInsetsGeometry.all(16),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Center(
                            child: Text(
                              "Update Profile",
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
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (builder) => MainBottomNavScreen(),
                                  ),
                                  (predicate) => false,
                                );
                                _clearTextFields();
                              }
                            },
                            child: Icon(Icons.arrow_circle_right_outlined),
                          ),
                          SizedBox(height: 48),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
