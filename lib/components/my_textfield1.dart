import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final IconData prefixIcon;

  const MyTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(
          color: Colors.blue, // Text color
          fontSize: 16.0, // Text font size
          fontWeight: FontWeight.normal, // Text font weight
          fontStyle: FontStyle.normal, // Text font style
          decoration: TextDecoration.none, // Text decoration
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon), // Prefix icon (can be customized)
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius:
                BorderRadius.circular(10.0), // Adjust the border radius
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(
            color: const Color.fromARGB(255, 70, 68, 68), // Hint text color
          ),
        ),
      ),
    );
  }
}
