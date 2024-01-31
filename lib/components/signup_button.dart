import 'package:flutter/material.dart';

class SignUpText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Add your sign-up logic here
        Navigator.pushNamed(context, 'SignUpPage');
      },
      child: Text(
        "Don't have an account?",
        style: TextStyle(
          fontSize: 16.0,
          color: const Color.fromARGB(
              255, 237, 233, 233), // Text color when not pressed
        ),
      ),
    );
  }
}
