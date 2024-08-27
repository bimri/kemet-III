import 'package:flutter/material.dart';
import 'splash_screen.dart';


class KemetApp extends StatelessWidget {
  const KemetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kemet',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SplashScreen(), // Start with SplashScreen
    );
  }
}
