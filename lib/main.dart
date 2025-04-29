import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(RandomizerApp());
}

class RandomizerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Randomizer',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
