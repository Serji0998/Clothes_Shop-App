import 'package:flutter/material.dart';

class SignupSubmit extends StatelessWidget {
  final TextEditingController username;
  final TextEditingController password;
  final TextEditingController phonenumber;
  final Function function;

  const SignupSubmit({
    Key? key,
    required this.username,
    required this.password,
    required this.phonenumber,
    required this.function,
  }) : super(key: key);

  void navigateBack(BuildContext context) {
    Navigator.pop(context);
  }

  void showRegisteredDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Registered Complete'),
          content: Text('You may login.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                Navigator.pop(context); // Pop the current screen (Signup page)
                Navigator.pushNamed(
                    context, 'login_page'); // Push the login screen
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        function(context);
      },
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Text(
            "Submit",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
