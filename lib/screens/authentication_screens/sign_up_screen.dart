import 'package:ecohub/widgets/input_text_widget.dart';
import 'package:flutter/material.dart';

import '../../widgets/button.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade300,
          title: Text(
            "Sign Up",
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 20),
                Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: InputTextWidget(
                        'First Name', false, TextEditingController())),
                Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: InputTextWidget(
                        'Last Name', false, TextEditingController())),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 18,
                    ),
                    Expanded(
                      child: Text(
                        "Make sure it matches the name on your Government ID",
                        style: TextStyle(
                          fontSize: 19,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: InputTextWidget(
                        'Email', false, TextEditingController())),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: InputTextWidget(
                      'Passsword', true, TextEditingController()),
                ),
                SizedBox(height: 70),
                Button(text: 'Register', onPressed: () {}),
              ],
            ),
          ),
        ));
  }
}
