import 'package:flutter/material.dart';

// Custom button widget for calculator
class CalcButton extends StatelessWidget {
  final String btnTxt; // Button label text
  final Color btnColor; // Button background color
  final Color txtColor; // Text color on the button
  final Function(String) onPressed; // Callback when button is pressed

  CalcButton(this.btnTxt, this.btnColor, this.txtColor, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: () => onPressed(btnTxt), // Call the function with the button label
        child: Text(
          btnTxt, // Display button text
          style: TextStyle(fontSize: 30, color: txtColor), // Text style
        ),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(), // Make the button circular
          primary: btnColor, // Background color
          padding: EdgeInsets.all(20), // Padding inside the button
          minimumSize: Size(90, 90), // Button size
        ),
      ),
    );
  }
}
