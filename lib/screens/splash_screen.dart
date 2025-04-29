import 'dart:async'; // For Timer
import 'package:flutter/material.dart';
import 'home_screen.dart'; // Import the HomeScreen

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double progress = 0.0; // Variable to track the progress

  @override
  void initState() {
    super.initState();

    // Timer that increments progress every 50ms (faster progress)
    Timer.periodic(Duration(milliseconds: 20), (timer) {
      setState(() {
        progress += 0.05; // Increment progress by 2% every 50ms (faster rate)
      });

      if (progress >= 1.0) {
        timer.cancel(); // Stop the timer once progress reaches 100%
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ), // Navigate to HomeScreen
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF004aad), // Background color of splash screen
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Custom splash logo image
            Image.asset(
              'assets/splash/splash.png', // Path to your splash image
              width: 150,
              height: 150,
            ),
            SizedBox(height: 20), // Add space between logo and progress bar
            // Linear progress indicator
            Column(
              children: [
                Container(
                  width: 200, // Set the width of the progress bar
                  child: LinearProgressIndicator(
                    value: progress, // Current progress value
                    backgroundColor: Colors.white.withOpacity(
                      0.3,
                    ), // Background color of the progress bar
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.white,
                    ), // Color of the progress bar
                  ),
                ),
                SizedBox(
                  height: 10,
                ), // Space between progress bar and percentage text
                Text(
                  "${(progress * 100).toStringAsFixed(0)}%", // Display percentage as text
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
