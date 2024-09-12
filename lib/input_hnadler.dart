import 'calculator_screen.dart';
import 'math_operations.dart';

// Handle input and dispatch to the appropriate function
void handleInput(String btnText, _CalculatorState state) {
  if (btnText == 'AC') {
    clearAll(state);
  } else if (btnText == '+/-') {
    toggleSign(state);
  } else if (btnText == '.' || btnText == '%') {
    handleSpecialInput(btnText, state);
  } else if (isOperator(btnText)) {
    processOperator(btnText, state);
  } else if (btnText == '=') {
    calculateResult(state);
  } else {
    appendNumber(btnText, state);
  }
}

bool isOperator(String btnText) {
  return btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/';
}

// Clear input
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

// Append number
void appendNumber(String btnText, _CalculatorState state) {
  state.setState(() {
    state.result += btnText;
    state.finalResult = state.result;
    state.text = state.finalResult;
  });
}

// Toggle sign
void toggleSign(_CalculatorState state) {
  state.setState(() {
    state.result.toString().startsWith('-')
        ? state.result = state.result.toString().substring(1)
        : state.result = '-' + state.result.toString();
    state.finalResult = state.result;
    state.text = state.finalResult;
  });
}

// Handle special input
void handleSpecialInput(String btnText, _CalculatorState state) {
  if (btnText == '.') {
    if (!state.result.toString().contains('.')) {
      state.setState(() {
        state.result += '.';
        state.finalResult = state.result;
        state.text = state.finalResult;
      });
    }
  } else if (btnText == '%') {
    state.setState(() {
      state.result = (state.numOne / 100).toString();
      state.finalResult = state.result;
      state.text = state.finalResult;
    });
  }
}

// Process operator
void processOperator(String btnText, _CalculatorState state) {
  if (state.operator.isEmpty) {
    state.numOne = double.parse(state.result);
  } else {
    state.numTwo = double.parse(state.result);
    calculateResult(state);
  }
  state.operator = btnText;
  state.result = '';
}
