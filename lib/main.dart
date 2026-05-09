import 'package:flutter/material.dart';
import 'package:login_mobile/login.dart';

void main() async {
  runApp(chat_app());
}

class chat_app extends StatelessWidget {
  const chat_app({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {'login': (context) => Login()},
      initialRoute: 'login',
    );
  }
}
