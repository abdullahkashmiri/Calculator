import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

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

  // Button creation function
  Widget calcButton(String btnTxt, Color btnColor, Color txtColor) {
    return Container(
      child: ElevatedButton(
        onPressed: () => buttonPressed(btnTxt),
        child: Text(
          btnTxt,
          style: TextStyle(fontSize: 30, color: txtColor),
        ),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          primary: btnColor,
          padding: EdgeInsets.all(20),
          minimumSize: Size(90, 90),
        ),
      ),
    );
  }

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
            // Calculator display
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
            buildCalcButtonRow(['3', '2', '1', '+'], Colors.grey[850]!, Colors.black),
            buildLastRow(),
          ],
        ),
      ),
    );
  }

  // Refactored to build button rows
  Row buildCalcButtonRow(List<String> buttonLabels, Color btnColor, Color txtColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttonLabels.map((label) => calcButton(label, btnColor, txtColor)).toList(),
    );
  }

  // Last row with 0 button
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
        calcButton('.', Colors.grey[850]!, Colors.white),
        calcButton('=', Colors.amber[700]!, Colors.white),
      ],
    );
  }

  // Handle button press and route to appropriate function
  void buttonPressed(String btnText) {
    if (btnText == 'AC') {
      clearAll();
    } else if (btnText == '+/-') {
      toggleSign();
    } else if (btnText == '.' || btnText == '%') {
      handleSpecialInput(btnText);
    } else if (isOperator(btnText)) {
      processOperator(btnText);
    } else if (btnText == '=') {
      calculateResult();
    } else {
      appendNumber(btnText);
    }
  }

  // Helper function to check if the button is an operator
  bool isOperator(String btnText) {
    return btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/';
  }

  // Clear all inputs
  void clearAll() {
    setState(() {
      text = '0';
      numOne = 0;
      numTwo = 0;
      result = '';
      operator = '';
      finalResult = '';
    });
  }

  // Handle number input
  void appendNumber(String btnText) {
    setState(() {
      result += btnText;
      finalResult = result;
      text = finalResult;
    });
  }

  // Toggle between positive and negative sign
  void toggleSign() {
    setState(() {
      result.toString().startsWith('-')
          ? result = result.toString().substring(1)
          : result = '-' + result.toString();
      finalResult = result;
      text = finalResult;
    });
  }

  // Handle special inputs like decimal point and percentage
  void handleSpecialInput(String btnText) {
    if (btnText == '.') {
      if (!result.toString().contains('.')) {
        setState(() {
          result += '.';
          finalResult = result;
          text = finalResult;
        });
      }
    } else if (btnText == '%') {
      setState(() {
        result = (numOne / 100).toString();
        finalResult = result;
        text = finalResult;
      });
    }
  }

  // Process operator input and handle calculations
  void processOperator(String btnText) {
    if (operator.isEmpty) {
      numOne = double.parse(result);
    } else {
      numTwo = double.parse(result);
      calculateResult();
    }
    operator = btnText;
    result = '';
  }

  // Perform calculation based on the operator
  void calculateResult() {
    switch (operator) {
      case '+':
        finalResult = add();
        break;
      case '-':
        finalResult = subtract();
        break;
      case 'x':
        finalResult = multiply();
        break;
      case '/':
        finalResult = divide();
        break;
      default:
        finalResult = result;
    }
    setState(() {
      text = finalResult;
      result = finalResult;
      operator = '';
    });
  }

  // Math operation functions
  String add() => (numOne + numTwo).toString();
  String subtract() => (numOne - numTwo).toString();
  String multiply() => (numOne * numTwo).toString();
  String divide() => (numOne / numTwo).toString();
}
