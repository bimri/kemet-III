import 'package:flutter/material.dart';
import 'dart:async';

import 'package:kemet/views/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, this.nextScreen});
  final Widget? nextScreen;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int _currentIndex = 0;
  final List<Map<String, String>> _splashData = [
    {'image': 'assets/bmr.jpg', 'text': 'Welcome'},
    {'image': 'assets/kemet-splashscreen.jpg', 'text': 'to'},
    {'image': 'assets/kemet-splashscreen.jpg', 'text': 'Kemet'},
  ];

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() {
    const duration = Duration(milliseconds: 1500); // Reduced total time to ~4.5 seconds
    Timer.periodic(duration, (Timer timer) {
      if (_currentIndex < 2) {
        setState(() {
          _currentIndex++;
        });
      } else {
        timer.cancel();
        _navigateToHomePage();
      }
    });
  }

  void _navigateToHomePage() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 236, 233, 233),
              Color.fromARGB(255, 230, 227, 227)
            ],
          ),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300), // Reduced animation duration
          child: _buildSplashContent(
            key: ValueKey<int>(_currentIndex),
            image: _splashData[_currentIndex]['image']!,
            text: _splashData[_currentIndex]['text']!,
          ),
        ),
      ),
    );
  }

  Widget _buildSplashContent({
    required Key key,
    required String image,
    required String text,
  }) {
    return Center(
      key: key,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            width: 300,
            height: 300,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 24),
          Text(
            text,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
