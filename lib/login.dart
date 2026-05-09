import 'package:flutter/material.dart';
import 'package:login_mobile/widgets/customButton.dart';
import 'package:login_mobile/widgets/textFeiled.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? email;

  String? password;

  bool loader = false;

  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 2, 44, 78),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              SizedBox(height: 90),

              SizedBox(height: 30),
              Text(
                'log in to your account',
                style: TextStyle(fontSize: 32, color: Colors.white),
              ),
              SizedBox(height: 30),
              Center(
                child: Row(
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    SizedBox(height: 60),
                  ],
                ),
              ),
              textfeiled(
                onchange: (data) {
                  email = data;
                },
                hinttext: 'email',
              ),
              SizedBox(height: 25),
              textfeiled(
                onchange: (date) {
                  password = date;
                },
                hinttext: 'password',
              ),
              SizedBox(height: 30),
              Custombutton(
                ontap: () async {
                  loader = true;
                  setState(() {});
                },
                text: 'login',
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'you do not have an account ? ',
                    style: TextStyle(color: Colors.white),
                  ),

                  Text('register', style: TextStyle(color: Colors.orange)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
