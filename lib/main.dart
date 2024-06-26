import 'package:ecohub/onboarding_screen.dart';
import 'package:ecohub/screens/home_screen.dart';
import 'package:ecohub/services/auth_wrapper.dart';
import 'package:ecohub/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OnBoardingScreen(),
      routes: {
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
