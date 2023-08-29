import "dart:math";
import 'package:stack/stack.dart';

double? Postsolution(String eq) {
  Stack<double> stack = Stack();
  List<String> equation = eq.split(' ');

  for (String val in equation) {
    switch (val) {
      case '+':
        double val2 = stack.pop();
        double val1 = stack.pop();
        stack.push(add(val1, val2));
      case '-':
        double val2 = stack.pop();
        double val1 = stack.pop();
        stack.push(minus(val1, val2));
      case '*':
        double val2 = stack.pop();
        double val1 = stack.pop();
        double multi = multiply(val1, val2);
        if (multi > 50.0) {
          return null;
        }
        stack.push(multi);
      case '/':
        double val2 = stack.pop();
        double val1 = stack.pop();
        if (val2 == 0.0) {
          return null;
        }
        double div = division(val1, val2);
        if (div != div.round()) {
          return null;
        }
        stack.push(div);
      case '^':
        double val2 = stack.pop();
        double val1 = stack.pop();
        double exp = exponent(val1, val2);
        print(exp);
        if (exp > 81.0 ||
            exp < -81.0 ||
            exp == double.infinity ||
            exp == 0.0 ||
            exp == double.negativeInfinity ||
            exp != exp ||
            exp != exp.round()) {
          return null;
        }
        stack.push(exp);
      default:
        stack.push(double.parse(val));
    }
  }

  double result = stack.pop();
  return result;
}

double? Presolution(String eq) {
  Stack<double> stack = Stack();
  List<String> equation = eq.split(' ');
  List<String> preEquation = List.from(equation.reversed);

  for (String val in preEquation) {
    switch (val) {
      case '+':
        double val1 = stack.pop();
        double val2 = stack.pop();
        stack.push(add(val1, val2));
      case '-':
        double val1 = stack.pop();
        double val2 = stack.pop();
        stack.push(minus(val1, val2));
      case '*':
        double val1 = stack.pop();
        double val2 = stack.pop();
        double multi = multiply(val1, val2);
        if (multi > 50) {
          return null;
        }
        stack.push(multi);
      case '/':
        double val1 = stack.pop();
        double val2 = stack.pop();
        if (val2 == 0.0) {
          return null;
        }
        double div = division(val1, val2);
        if (div != div.round()) {
          return null;
        }
        stack.push(div);
      case '^':
        double val1 = stack.pop();
        double val2 = stack.pop();
        double exp = exponent(val1, val2);
        if (exp > 81 ||
            exp < -81.0 ||
            exp == double.infinity ||
            exp == 0.0 ||
            exp == double.negativeInfinity ||
            exp != exp ||
            exp != exp.round()) {
          return null;
        }
        stack.push(exp);
      default:
        stack.push(double.parse(val));
    }
  }
  double result = stack.pop();
  return result;
}

String postEquationGenerator({int operators = 4}) {
  int numOfOps = 0;
  int numOfNum = 2;
  String equation = '';
  Random rand = Random();
  List<String> ops = ['+', '-', '*', '/', '^'];

  equation += '${rand.nextInt(10) + 1}';
  equation += ' ${rand.nextInt(10) + 1}';
  while (numOfOps != operators) {
    if (numOfNum - 1 == operators) {
      //Operator
      equation += ' ${ops[rand.nextInt(ops.length)]}';
      numOfOps++;
    } else if (numOfNum - 1 == numOfOps) {
      //Number
      equation += ' ${rand.nextInt(10) + 1}';
      numOfNum++;
    } else {
      //Number or Operator
      int val = rand.nextInt(10);
      if (val <= 4) {
        equation += ' ${rand.nextInt(10) + 1}';
        numOfNum++;
      } else {
        equation += ' ${ops[rand.nextInt(ops.length)]}';
        numOfOps++;
      }
    }
  }
  double? post = Postsolution(equation);
  print(equation);
  if (post == null || post == 0.0 || post != Postsolution(equation)!.round()) {
    equation = postEquationGenerator(operators: operators);
  }
  return equation;
}

String preEquationGenerator({int operators = 4}) {
  int numOfOps = 1;
  int numOfNum = 0;
  String equation = '';
  Random rand = Random();
  List<String> ops = ['+', '-', '*', '/', '^'];

  equation += '${ops[rand.nextInt(ops.length)]}';
  while (numOfNum != operators + 1) {
    if (numOfOps == operators) {
      //Operator
      equation += ' ${rand.nextInt(10) + 1}';
      numOfNum++;
    } else if (numOfNum == numOfOps) {
      //Number
      equation += ' ${ops[rand.nextInt(ops.length)]}';
      numOfOps++;
    } else {
      //Number or Operator
      int val = rand.nextInt(10);
      if (val <= 6) {
        equation += ' ${rand.nextInt(10) + 1}';
        numOfNum++;
      } else {
        equation += ' ${ops[rand.nextInt(ops.length)]}';
        numOfOps++;
      }
    }
  }
  double? post = Presolution(equation);
  if (post == null || post == 0.0 || post != Presolution(equation)!.round()) {
    equation = preEquationGenerator(operators: operators);
  }
  return equation;
}

double add(double val1, double val2) {
  return val1 + val2;
}

double minus(double val1, double val2) {
  return val1 - val2;
}

double multiply(double val1, double val2) {
  return (val1 * val2);
}

double division(double val1, double val2) {
  return (val1 / val2);
}

double exponent(double val1, double val2) {
  return pow(val1, val2) as double;
}
