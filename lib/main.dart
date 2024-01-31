import 'package:first_app/components/ProductProvider.dart';
import 'package:first_app/components/shop.dart';
import 'package:first_app/components/theme1.dart';
import 'package:first_app/home.dart';
import 'package:first_app/utils/cart_page.dart';
import 'package:first_app/utils/login_screen.dart';
import 'package:first_app/utils/signup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => Shop()),
        // Add other providers if needed
      ],
      child: MaterialApp(
        theme: lightMode,
        home: LoginScreen(),
        routes: {
          'login_page': (context) => LoginScreen(),
          'SignUpPage': (context) => SignUpPage(),
          'homec': (context) => Homepag(),
          'cart_page': (context) => CartPage(),
        },
      ),
    );
  }
}
