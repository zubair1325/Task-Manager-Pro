import 'package:flutter/material.dart';
import 'package:task_manager_pro/ui/controller/auth_controller.dart';
import 'package:task_manager_pro/ui/screens/login_screen.dart';
import 'package:task_manager_pro/ui/screens/update_user_profile_screen.dart';

class ProfileSummaryCard extends StatelessWidget {
  final bool ignoreOnTap;
  const ProfileSummaryCard({super.key, this.ignoreOnTap = false});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (!ignoreOnTap) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (builder) => UpdateUserProfileScreen()),
          );
        }
      },
      tileColor: Colors.green,
      textColor: Colors.white,
      iconColor: Colors.white,
      leading: CircleAvatar(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 6, 117, 9),
        child: Icon(Icons.person),
      ),
      title: Text("Md. Zubair Rahman"),
      subtitle: Text("zubair@gmail.com"),
      trailing: IconButton(
        onPressed: () {
          AuthController.clearAuthData();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (builder) => LoginScreen()),
            (predicate) => false,
          );
        },
        icon: Icon(Icons.logout),
      ),
    );
  }
}
