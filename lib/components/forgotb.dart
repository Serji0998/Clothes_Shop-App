import 'package:flutter/material.dart';

class Forgot extends StatelessWidget {
  const Forgot({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {
              // Add your "Forgot Password" logic here
            },
            child: Text(
              'Forgot Password?',
              style: TextStyle(
                  fontSize: 16,
                  color: const Color.fromARGB(255, 237, 233, 233)),
            ),
          ),
        ],
      ),
    );
  }
}
