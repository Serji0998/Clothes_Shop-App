import 'package:first_app/components/my_textfield1.dart';
import 'package:first_app/components/signup-submit.dart';
import 'package:first_app/utils/socket_client.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController phonenumber = TextEditingController();
  final SocketClient _socketClient = SocketClient.instance;

  void submitData(BuildContext context) {
    if (username.text.isEmpty ||
        password.text.isEmpty ||
        phonenumber.text.isEmpty) {
      // If  fields are  empty
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Please fill in all fields'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      // Emit the signup event with the user data
      _socketClient.socket!.emit('signup', {
        'username': username.text,
        'password': password.text,
        'phonenumber': phonenumber.text,
      });
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
                  Navigator.pop(
                      context); // Pop the current screen (Signup page)
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/signup-clothes-photo.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 80),
                // Title
                Text(
                  'Sign Up',
                  style: TextStyle(
                      fontSize: 30,
                      color: const Color.fromARGB(255, 233, 230, 230)),
                ),
                SizedBox(height: 90),
                // Username TextField
                MyTextField(
                  controller: username,
                  hintText: 'Username',
                  obscureText: false,
                  prefixIcon: Icons.person,
                ),
                SizedBox(height: 30),
                // Password TextField
                MyTextField(
                  controller: password,
                  hintText: 'Password',
                  obscureText: true,
                  prefixIcon: Icons.lock,
                ),
                SizedBox(height: 30),
                // phone TextField
                MyTextField(
                  controller: phonenumber,
                  hintText: 'Phone Number',
                  obscureText: true,
                  prefixIcon: Icons.phone,
                ),
                SizedBox(height: 60),
                // Sign Up Button
                SignupSubmit(
                  username: username,
                  password: password,
                  phonenumber: phonenumber,
                  function: submitData,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
