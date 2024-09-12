import 'calculator_screen.dart'; // Import state class

// Calculate the result based on the current operator
void calculateResult(_CalculatorState state) {
  switch (state.operator) {
  case '+':
  state.finalResult = add(state.numOne, state.numTwo); // Perform addition
  break;
  case '-':
  state.finalResult
