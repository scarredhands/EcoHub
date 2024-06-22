import 'package:ecohub/screens/authentication_screens/login_screen.dart';
import 'package:ecohub/screens/feature_screens/advisory_screen/advisory_screen.dart';
import 'package:ecohub/screens/home_screen.dart';
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
      home: AdvisoryScreen(),
      routes: {
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
