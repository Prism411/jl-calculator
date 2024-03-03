class CalculatorService {
  double calculateResult(String expression) {
    double result = 0;
    String currentOperator = '';
    String currentNumber = '';

    for (int i = 0; i < expression.length; i++) {
      String char = expression[i];
      if ("+-X/".contains(char)) {
        if (currentNumber.isNotEmpty) {
          result = _calculate(result, double.tryParse(currentNumber) ?? 0, currentOperator);
          currentNumber = '';
        }
        currentOperator = char;
      } else {
        currentNumber += char;
      }
    }

    if (currentNumber.isNotEmpty) {
      result = _calculate(result, double.tryParse(currentNumber) ?? 0, currentOperator);
    }

    return result;
  }

  double _calculate(double result, double number, String operator) {
    switch (operator) {
      case '+':
        return result + number;
      case '-':
        return result - number;
      case 'X':
        return result * number;
      case '/':
        return result / number;
      default:
        return number;
    }
  }
}
