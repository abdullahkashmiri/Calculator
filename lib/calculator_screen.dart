import 'package:flutter/material.dart';
import 'button_widget.dart';
import 'input_handler.dart';

class Calculator extends StatefulWidget {
  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  dynamic text = '0';
  double numOne = 0;
  double numTwo = 0;
  dynamic result = '';
  dynamic finalResult = '';
  dynamic operator = '';
  dynamic preOperator = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Calculator'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Display
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      '$text',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 100,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            // Calculator buttons
            buildCalcButtonRow(['AC', '+/-', '%', '/'], Colors.grey[300]!, Colors.black),
            buildCalcButtonRow(['7', '8', '9', 'x'], Colors.grey[850]!, Colors.black),
            buildCalcButtonRow(['4', '5', '6', '-'], Colors.grey[850]!, Colors.black),
            buildCalcButtonRow(['1', '2', '3', '+'], Colors.grey[850]!, Colors.black),
            buildLastRow(),
          ],
        ),
      ),
    );
  }

  Row buildCalcButtonRow(List<String> buttonLabels, Color btnColor, Color txtColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttonLabels.map((label) => CalcButton(label, btnColor, txtColor, buttonPressed)).toList(),
    );
  }

  Row buildLastRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () => buttonPressed('0'),
          style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
            minimumSize: Size(180, 90),
            primary: Colors.grey[900]!,
          ),
          child: Center(
            child: Text(
              '0',
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
          ),
        ),
        CalcButton('.', Colors.grey[850]!, Colors.white, buttonPressed),
        CalcButton('=', Colors.amber[700]!, Colors.white, buttonPressed),
      ],
    );
  }

  void buttonPressed(String btnText) {
    handleInput(btnText, this);
  }

  void updateDisplay(String newText) {
    setState(() {
      text = newText;
    });
  }
}
