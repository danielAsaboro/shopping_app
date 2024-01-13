import 'package:flutter/material.dart';

class GdscScreen extends StatefulWidget {
  const GdscScreen({super.key});

  @override
  State<GdscScreen> createState() => _GdscScreenState();
}

class _GdscScreenState extends State<GdscScreen> {
  String message = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("Welcome to Study Jams"),
            SizedBox(
              height: 50,
              width: 300,
              child: TextField(
                onChanged: (userInput) {
                  message = "";
                  setState(() {
                    // check for password length
                    if (userInput.length < 8) {
                      message = "at least 8 Characters,";
                    }

                    // check for lowercase characters
                    if (!userInput.contains(RegExp(r'[a-z]'))) {
                      message += " one lower case character,";
                    }

                    // check for uppercase characters
                    if (!userInput.contains(RegExp(r'[A-Z]'))) {
                      message += " one upper case character,";
                    }

                    // check for special characters
                    if (!userInput
                        .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                      message += " one special character,";
                    }

                    // check for digits
                    if (!userInput.contains(RegExp(r'[0-9]'))) {
                      message += " one digit,";
                    }

                    if (message.isEmpty || userInput.isEmpty) {
                      message = "";
                    } else if (message.isEmpty && userInput.isNotEmpty) {
                      message = "Very strong password 🫡";
                    } else {
                      message = "Must contain $message";
                    }
                  });
                },
              ),
            ),
            Text(
              message,
              style: TextStyle(color: Colors.red),
            ),
            ElevatedButton(child: Text("Submit"), onPressed: (){},)
          ],
        ),
      ),
    );
  }
}
