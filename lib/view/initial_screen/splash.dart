import 'package:flutter/material.dart';
import 'dart:async';

import '../auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  Timer? _timer;
  bool _autoSlideUp = false;
  bool _showSplash = true;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _timer = Timer(const Duration(seconds: 7), () {
      if (mounted) {
        setState(() {
          _autoSlideUp = true;
        });

        Future.delayed(const Duration(milliseconds: 600), () {
          if (mounted) {
            setState(() {
              _showSplash = false;
            });
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
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
          if (_showSplash)
            AnimatedSlide(
              offset: _autoSlideUp ? const Offset(0, -1) : Offset.zero,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              child: Dismissible(
                key: const Key('splash'),
                direction: DismissDirection.up,
                onDismissed: (_) {
                  setState(() {
                    _showSplash = false;
                  });
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