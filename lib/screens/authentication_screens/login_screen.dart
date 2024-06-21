import 'package:ecohub/screens/authentication_screens/forgot_password_screen.dart';
import 'package:ecohub/screens/authentication_screens/sign_up_screen.dart';
import 'package:ecohub/screens/home_screen.dart';
import 'package:ecohub/widgets/button.dart';
import 'package:ecohub/widgets/input_text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailTextController = TextEditingController();

  TextEditingController _passwordTextController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signInWithEmailAndPassword() async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: _emailTextController.text.trim(),
        password: _passwordTextController.text.trim(),
      );
      // Navigate to the next screen after successful login
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } catch (e) {
      _showErrorDialog('Error: $e');
      // Handle errors such as invalid email/password, user not found, etc.
      // Example: Show a snackbar or alert dialog with an error message
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

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
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPasswordScreen()));
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Text('Forget Password?'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Button(
                  text: 'Login',
                  onPressed: () {
                    _signInWithEmailAndPassword();
                  }),
              const SizedBox(height: 22),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()));
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Text("Don't have an account? Register Now"),
                ),
              ),
            ])))));
  }
}
