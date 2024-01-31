import 'package:first_app/components/forgotb.dart';
import 'dart:async';
import 'package:first_app/components/my_textfield1.dart';
import 'package:first_app/components/mybutton.dart';
import 'package:first_app/components/signup_button.dart';
import 'package:first_app/utils/socket_client.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class LoginScreen extends StatelessWidget {
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  final SocketClient _socketClient = SocketClient.instance;

  Future<bool> searchUser(BuildContext context) {
    Completer<bool> completer = Completer<bool>();
    bool completerCompleted = false;
    bool userFound = false;

    void complete(bool value) {
      if (!completerCompleted) {
        completer.complete(value);
        completerCompleted = true;
      }
    }

    _socketClient.socket!.emit('searchUser', {
      'username': username.text,
      'password': password.text,
    });

    _socketClient.socket!.on('searchUserResponse', (data) {
      if (!userFound && data['user'] != null) {
        final foundUser = data['user'];
        userFound = true;

        if (foundUser['password'] == password.text) {
          print('User found and password correct');
          complete(true);
        } else {
          Future.microtask(() {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Error'),
                content: Text('Incorrect password'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      complete(false);
                    },
                    child: Text('OK'),
                  ),
                ],
              ),
            );
          });
        }
      } else if (!userFound && data['message'] != null) {
        Future.microtask(() {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Error'),
              content: Text(data['message']),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    complete(false);
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          );
        });
      }
    });

    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/clothes-photo.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                // Icon
                SizedBox(height: 120),
                // Text
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 30,
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                SizedBox(height: 80),
                // username
                MyTextField(
                  controller: username,
                  hintText: 'Username',
                  obscureText: false,
                  prefixIcon: Icons.person,
                ),
                SizedBox(height: 10),
                // password
                MyTextField(
                  controller: password,
                  hintText: 'Password',
                  obscureText: true,
                  prefixIcon: Icons.lock,
                ),
                SizedBox(height: 10),
                Forgot(),
                SizedBox(height: 20),
                Mybutton(
                  username: username,
                  password: password,
                  searchuser: searchUser,
                ),
                SizedBox(height: 50),
                SignUpText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
