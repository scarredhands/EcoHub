import 'package:ecohub/screens/authentication_screens/login_screen.dart';
import 'package:ecohub/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading spinner
          return CircularProgressIndicator();
        }
        if (snapshot.hasData) {
          // User is logged in, navigate to HomePage
          return HomeScreen();
        } else {
          // User is not logged in, navigate to LoginPage
          return LoginScreen();
        }
      },
    );
  }
}
