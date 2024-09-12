import 'calculator_screen.dart'; // Import the state class
import 'math_operations.dart'; // Import math operations

// Handles all button inputs
void handleInput(String btnText, _CalculatorState state) {
  if (btnText == 'AC') {
    clearAll(state); // Clear the calculator
  } else if (btnText == '+/-') {
    toggleSign(state); // Toggle positive/negative
  } else if (btnText == '.' || btnText == '%') {
    handleSpecialInput(btnText, state); // Handle decimal or percentage
  } else if (isOperator(btnText)) {
    processOperator(btnText, state); // Process operators (+, -, /, x)
  } else if (btnText == '=') {
    calculateResult(state); // Calculate the result when '=' is pressed
  } else {
    appendNumber(btnText, state); // Append numbers to current input
  }
}

// Check if a button text is an operator
bool isOperator(String btnText) {
  return btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/';
}

// Clear the calculator's display and variables
void clearAll(_CalculatorState state) {
  state.setState(() {
    state.text = '0';
    state.numOne = 0;
    state.numTwo = 0;
    state.result = '';
    state.operator = '';
    state.finalResult = '';
  });
}

// Append a number to the current result
void appendNumber(String btnText, _CalculatorState state) {
  state.setState(() {
    state.result += btnText; // Add the button text to the result
    state.finalResult = state.result; // Set the final result
    state.text = state.finalResult; // Update the display
  });
}

// Toggle between positive and negative numbers
void toggleSign(_CalculatorState state) {
  state.setState(() {
    state.result.toString().startsWith('-')
        ? state.result = state.result.toString().substring(1) // Remove negative sign
        : state.result = '-' + state.result.toString(); // Add negative sign
    state.finalResult = state.result;
    state.text = state.finalResult; // Update display
  });
}

// Handle special inputs like decimal point and percentage
void handleSpecialInput(String btnText, _CalculatorState state) {
  if (btnText == '.') {
    if (!state.result.toString().contains('.')) { // Only add '.' if not already present
      state.setState(() {
        state.result += '.';
        state.finalResult = state.result;
        state.text = state.finalResult;
      });
    }
  } else if (btnText == '%') {
    state.setState(() {
      state.result = (state.numOne / 100).toString(); // Convert to percentage
      state.finalResult = state.result;
      state.text = state.finalResult;
    });
  }
}

// Process the operator when pressed
void processOperator(String btnText, _CalculatorState state) {
  if (state.operator.isEmpty) {
    state.numOne = double.parse(state.result); // Set first number
  } else {
    state.numTwo = double.parse(state.result); // Set second number
    calculateResult(state); // Perform the calculation
  }
  state.operator = btnText; // Set the current operator
  state.result = ''; // Clear result for next input
}
