import 'package:flutter/material.dart';
import 'calculator_screen.dart';

// Main function to run the app
void main() => runApp(MyApp());

// The main widget for the app
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove debug banner
      home: Calculator(), // Start with the Calculator screen
    );
  }
}
