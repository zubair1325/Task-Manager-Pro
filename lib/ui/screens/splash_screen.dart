import 'package:flutter/material.dart';
import 'package:task_manager_pro/ui/screens/login_screen.dart';
import 'package:task_manager_pro/ui/widget/body_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    goToLoginScreen();
  }

  void goToLoginScreen() {
    Future.delayed(const Duration(seconds: 2)).then((onValue) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (builder) => const LoginScreen()),
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "TASK",
                style: TextStyle(
                  color: const Color(0xFF21BF73),
                  fontSize: 60,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.7,
                ),
              ),
              Text(
                "MANAGER PRO+",
                style: TextStyle(
                  color: const Color(0xFF21BF73),
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.9,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
