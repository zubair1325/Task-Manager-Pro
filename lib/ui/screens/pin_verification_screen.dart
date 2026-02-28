import 'package:flutter/material.dart';
import 'package:task_manager_pro/ui/screens/set_password_screen.dart';
import 'package:task_manager_pro/ui/widget/body_background.dart';
import 'package:task_manager_pro/ui/screens/login_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key});

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
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
                Text(
                  "Pin Verification",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  "A 6 digit verification pin will send to your email address",
                  style: TextStyle(
                    color: Colors.grey.shade800,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 24),
                PinInput(
                  length: 4,

                  builder: (context, cells) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: cells.map((cell) {
                        return Container(
                          width: 50,
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: cell.isFocused
                                ? Colors.grey
                                : Colors.grey[200],
                          ),
                          child: Center(
                            child: Text(
                              cell.character ?? '',
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                  onCompleted: (pin) => print('PIN: $pin'),
                ),

                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => SetPasswordScreen(),
                      ),
                      (predicate) => false,
                    );
                  },
                  child: Text(
                    "Verify",
                    style: TextStyle(color: Colors.white70),
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
    );
  }
}
