import 'package:flutter/material.dart';

class PasswordStrengthScreen extends StatefulWidget {
  const PasswordStrengthScreen({Key? key}) : super(key: key);

  @override
  State<PasswordStrengthScreen> createState() => _PasswordStrengthScreenState();
}

class _PasswordStrengthScreenState extends State<PasswordStrengthScreen> {
  final passwordEditingController = TextEditingController();
  String message = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Testing Password Strength"),
      ),
      body: Center(
        child: SizedBox(
          height: 100,
          width: 340,
          child: Column(
            children: [
              Expanded(
                child: TextField(
                  controller: passwordEditingController,
                  onChanged: (value) {
                    setState(() {
                      // Reset the message on each change
                      message = "";

                      // Check if it has at least 8 characters
                      if (value.length < 8) {
                        message += "at least 8 characters,";
                      }

                      // Check if it contains at least one uppercase character
                      if (!value.contains(RegExp(r'[A-Z]'))) {
                        message += "at least one uppercase character, ";
                      }

                      // Check if it contains at least one lowercase character
                      if (!value.contains(RegExp(r'[a-z]'))) {
                        message += "at least one lowercase character, ";
                      }

                      // Check if it contains at least one special character
                      if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                        message += "at least one special character, ";
                      }

                      // Check if it contains at least one digit
                      if (!value.contains(RegExp(r'[0-9]'))) {
                        message += "at least one digit, ";
                      }

                      // If none of the conditions are met, it's a strong password
                      if (message.isEmpty) {
                        message = "Strong password!";
                      } else {
                        message = "Password must be contain $message";
                      }
                    });
                    print(message);
                  },
                ),
              ),
              Text(message),
            ],
          ),
        ),
      ),
    );
  }
}
