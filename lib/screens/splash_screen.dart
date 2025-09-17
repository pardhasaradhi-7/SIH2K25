import 'dart:async';
import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade700,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.agriculture, size: 100, color: Colors.white),
            SizedBox(height: 20),
            Text(
              "AgriAssist 🌱",
              style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
