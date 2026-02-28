import 'package:flutter/material.dart';
import 'package:task_manager_pro/ui/screens/login_screen.dart';
import 'package:task_manager_pro/ui/widget/body_background.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({super.key});

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24),
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
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(hintText: "Email"),
                ),
                const SizedBox(height: 16),

                TextFormField(
                  decoration: InputDecoration(hintText: "First Name"),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(hintText: "Last Name"),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(hintText: "Mobile"),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(hintText: "Password"),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {},
                  child: Icon(Icons.arrow_circle_right_outlined),
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
    );
  }
}
