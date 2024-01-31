import 'package:flutter/material.dart';
import 'dart:async';

class Mybutton extends StatelessWidget {
  final TextEditingController username;
  final TextEditingController password;
  final Function searchuser;

  const Mybutton({
    Key? key,
    required this.username,
    required this.password,
    required this.searchuser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        bool result = await searchuser(context);
        if (result) {
          Navigator.pushNamed(context, 'homec');
        }
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
            "Sign in",
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
