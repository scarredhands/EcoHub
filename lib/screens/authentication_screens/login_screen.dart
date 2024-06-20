import 'package:ecohub/screens/authentication_screens/sign_up_screen.dart';
import 'package:ecohub/widgets/button.dart';
import 'package:ecohub/widgets/input_text_widget.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailTextController = TextEditingController();

  TextEditingController _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: const Color.fromARGB(255, 255, 249, 249),
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(255, 255, 249, 249),
              title: const Center(
                  child: Text(
                "I have an account",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )),
            ),
            body: SingleChildScrollView(
                child: Center(
                    child: Column(children: [
              Padding(
                  padding: EdgeInsets.all(15),
                  child: Image.asset('assets/EcoHubLogo.jpg')),
              Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: InputTextWidget('Email', false, _emailTextController)),
              Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: InputTextWidget(
                      'Password', true, _passwordTextController)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Text('Forget Password?'),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()));
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: Text('Register Now'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Button(text: 'Login', onPressed: () {})
            ])))));
  }
}
