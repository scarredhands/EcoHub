import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'main.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Splash'),
        centerTitle: true,
      ),
      body: Center(
        child: Lottie.network(
          'https://lottie.host/embed/8c439857-fbe0-419d-aa47-4b33cd2000a5/ZmaPQUHnTe.json',
          width: 200,
          height: 200,
          frameBuilder: (context, child, composition) {
            if (composition == null) {
              return Center(child: CircularProgressIndicator());
            } else {
              return child;
            }
          },
          errorBuilder: (context, error, stackTrace) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error, size: 60, color: Colors.red),
                SizedBox(height: 20),
                Text('Failed to load animation',
                    style: TextStyle(color: Colors.red)),
              ],
            );
          },
        ),
      ),
    );
  }
}
