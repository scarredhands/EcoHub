import 'package:ecohub/widgets/input_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../widgets/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecohub/widgets/dialogs/show_success_dialog.dart';
import 'package:ecohub/widgets/dialogs/show_error_dialog.dart';

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
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
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
        message = 'An error occurred. Please try again.';
      }
      _showErrorDialog(message);
    } catch (e) {
      _showErrorDialog('An error occurred. Please try again.');
    }
  }


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
                        'First Name', false, _firstNameController)),
                Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: InputTextWidget(
                        'Last Name', false, _lastNameController)),
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
                    child: InputTextWidget('Email', false, _emailController)),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child:
                      InputTextWidget('Passsword', true, _passwordController),
                ),
                SizedBox(height: 70),
                Button(text: 'Register', onPressed: () {

                  Navigator.push(context,builder:(context)=>HomeScreen())}),
              ],
            ),
          ),
        ));
  }
}
