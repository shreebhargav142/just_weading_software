import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:just_weding_software/auth/login_screen.dart';
import 'dart:async'; // Timer ke liye import zaroori hai

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  Timer? _timer;
  bool _autoSlideUp = false;

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();

    // 1. Arrow Animation Setup
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 10).animate( // Thoda movement badhaya (4 se 10) visible hone ke liye
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // 2. Start 4 Second Timer
    _timer = Timer(const Duration(seconds: 7), () {
      if (mounted) {
        setState(() {
          _autoSlideUp = true; // 4 second baad slide up trigger hoga
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Memory leak rokne ke liye
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double logoSize = screenWidth > 600 ? 300 : 160;

    double fontSize = screenWidth > 600 ? 24 : 16;
    return Scaffold(
      body: Stack(
        children: [
          const LoginScreen(),
          AnimatedSlide(
            offset: _autoSlideUp ? const Offset(0, -1) : Offset.zero, // -1 matlab poora screen upar
            duration: const Duration(milliseconds: 500), // Smooth exit animation
            curve: Curves.easeInOut,
            child: Dismissible(
              key: const Key('splash'),
              direction: DismissDirection.up,
              onDismissed: (_) {
                _timer?.cancel();
              },
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.white,
                child: Stack(
                  children: [
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            "assets/icon/icon.png",
                            width: logoSize,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "App For Next Generation",
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 50.0),
                        child: AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(0, -_animation.value),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.keyboard_arrow_up, size: 30, color: Colors.grey),
                                  Text(
                                    "Swipe Up",
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}