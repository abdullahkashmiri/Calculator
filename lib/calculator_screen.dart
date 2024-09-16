import 'package:flutter/material.dart';
import 'button_widget.dart'; // Import the button widget
import 'input_handler.dart'; // Import input handler

// Main calculator screen
class Calculator extends StatefulWidget {
  @override
  State<Calculator> createState() => _CalculatorState();
}

// State class for the calculator
class _CalculatorState extends State<Calculator> {
  dynamic text = '0'; // Display text
  double numOne = 0; // First number
  double numTwo = 0; // Second number
  dynamic result = ''; // Current result
  dynamic finalResult = ''; // Final result after calculation
  dynamic operator = ''; // Current operator
  dynamic preOperator = ''; // Previous operator

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Background color
      appBar: AppBar(
        title: Text('Calculator'),
        backgroundColor: Colors.black, // App bar color
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Display panel for numbers and results
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      '$text', // Dynamic text display
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 100, // Font size for the display
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            // Buttons layout
            buildCalcButtonRow(['AC', '+/-', '%', '/'], Colors.grey[300]!, Colors.black),
            buildCalcButtonRow(['7', '8', '9', 'x'], Colors.grey[850]!, Colors.black),
            buildCalcButtonRow(['4', '5', '6', '-'], Colors.grey[850]!, Colors.black),
            buildCalcButtonRow(['1', '2', '3', '+'], Colors.grey[850]!, Colors.black),
            buildLastRow(), // Last row with '0', '.', '='
          ],
        ),
      ),
    );
  }

  // Helper function to build a row of buttons
  Row buildCalcButtonRow(List<String> buttonLabels, Color btnColor, Color txtColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttonLabels.map((label) => CalcButton(label, btnColor, txtColor, buttonPressed)).toList(),
    );
  }

  // Function to create the last row with special buttons
  Row buildLastRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Special '0' button with larger width
        ElevatedButton(
          onPressed: () => buttonPressed('0'),
          style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
            minimumSize: Size(180, 90), // Larger size for '0'
            primary: Colors.grey[900]!, // Button color
          ),
          child: Center(
            child: Text(
              '0',
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
          ),
        ),
        CalcButton('.', Colors.grey[850]!, Colors.white, buttonPressed), // Decimal point button
        CalcButton('=', Colors.amber[700]!, Colors.white, buttonPressed), // Equals button
      ],
    );
  }

  // Function to handle button presses
  void buttonPressed(String btnText) {
    handleInput(btnText, this); // Delegate to input handler
  }

  // Function to update display
  void updateDisplay(String newText) {
    setState(() {
      text = newText; // Update the display text
    });
  }
}

