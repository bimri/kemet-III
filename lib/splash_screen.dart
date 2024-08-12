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
  final List<Widget> _splashScreens = [
    _buildSplashContent(
      image: 'assets/bmr.jpg',
      text: 'Welcome',
    ),
    _buildSplashContent(
      image: 'assets/kemet-splashscreen.jpg',
      text: 'to',
    ),
    _buildSplashContent(
      image: 'assets/kemet-splashscreen.jpg',
      text: 'Kemet',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() {
    const duration =
        Duration(milliseconds: 2666); // ~5 seconds total for 3 screens
    Timer.periodic(duration, (Timer timer) {
      if (_currentIndex < 2) {
        setState(() {
          _currentIndex++;
        });
      } else {
        timer.cancel();
        _navigateToHomePage(); // Call the navigation function here
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
          duration: const Duration(milliseconds: 500),
          child: _splashScreens[_currentIndex],
        ),
      ),
    );
  }

  static Widget _buildSplashContent(
      {required String image, required String text}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.asset(
              image,
              width: 300,
              height: 300,
              fit: BoxFit.contain,
            ),
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
