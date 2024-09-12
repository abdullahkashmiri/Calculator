import 'calculator_screen.dart';

// Perform calculation based on operator
void calculateResult(_CalculatorState state) {
  switch (state.operator) {
    case '+':
      state.finalResult = add(state.numOne, state.numTwo);
      break;
    case '-':
      state.finalResult = subtract(state.numOne, state.numTwo);
      break;
    case 'x':
      state.finalResult = multiply(state.numOne, state.numTwo);
      break;
    case '/':
      state.finalResult = divide(state.numOne, state.numTwo);
      break;
    default:
      state.finalResult = state.result;
  }
  state.setState(() {
    state.text = state.finalResult;
    state.result = state.finalResult;
    state.operator = '';
  });
}

// Math operations
String add(double a, double b) => (a + b).toString();
String subtract(double a, double b) => (a - b).toString();
String multiply(double a, double b) => (a * b).toString();
String divide(double a, double b) => (a / b).toString();
