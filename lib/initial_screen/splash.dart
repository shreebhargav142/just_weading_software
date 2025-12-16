import 'package:flutter/material.dart';
import 'package:just_weding_software/auth/login_screen.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.grey.shade600, // Top color (Greyish)
              Colors.black,         // Bottom color (Black)
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 48.0),
          child: Column(
            // Pushes content towards the bottom like in the screenshot
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Logo Image
              Image.asset(
                "assets/icon/icon.png",
                width: 120, // Adjusted width for better visibility
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 10), // Spacing between Logo and Text

              // Tagline Text
              const Text(
                "App For Next Generation",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                ),
              ),

              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}