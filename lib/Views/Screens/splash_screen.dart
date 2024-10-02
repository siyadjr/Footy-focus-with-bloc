import 'package:flutter/material.dart';
import 'package:footy_focus/Views/Screens/sign_in.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Trigger navigation inside build method (not ideal)
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (ctx) => LoginScreen()));
    });

    return Scaffold(
      body: Center(
        child: Image.asset('lib/Assets/Logo footy focus.png'),
      ),
    );
  }
}
