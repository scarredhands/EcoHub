import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecohub/widgets/input_text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../widgets/button.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<void> _signUp() async {
    try {
      // Create user with email and password
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      // Store additional user data in Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'firstName': _firstNameController.text,
        'lastName': _lastNameController.text,
        'email': _emailController.text,
      });

      // User signed up successfully
      print("Signed up: ${userCredential.user!.uid}");
      // Navigate to the next screen or show a success message
      _showSuccessDialog();
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists for that email.';
      } else {
        message = 'Error: ${e.message}';
      }
      _showErrorDialog(message);
    } catch (e) {
      _showErrorDialog('Error: $e');
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Success'),
        content: Text('Your account has been created successfully!'),
        actions: <Widget>[
          TextButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).popUntil((route) => route
                  .isFirst); // Pop all dialogs including the success dialog
              Navigator.pushReplacementNamed(
                  ctx, '/home'); // Replace current screen with the Home screen
            },
          )
        ],
      ),
    );
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
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 249, 249),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 255, 249, 249),
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
                        'First Name', false, _firstNameController)),
                // Padding(
                //     padding: const EdgeInsets.all(15.0),
                //     child: InputTextWidget(
                //         'Last Name', false, _lastNameController)),

                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    controller: _lastNameController,
                    decoration: InputDecoration(
                      helperText: 'Name should match with Government ID',
                      helperStyle: TextStyle(
                        fontSize: 15,
                      ),
                      labelText: 'Last Name',
                      labelStyle: TextStyle(color: Colors.grey.withOpacity(1)),
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      fillColor: Colors.grey.shade300,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade500),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade800),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: InputTextWidget('Email', false, _emailController)),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child:
                      InputTextWidget('Passsword', true, _passwordController),
                ),
                SizedBox(height: 20),
                Button(
                  text: 'Register',
                  onPressed: () {
                    _signUp();
                  },
                )
              ],
            ),
          ),
        ));
  }
}
