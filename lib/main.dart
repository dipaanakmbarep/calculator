import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kalkulator iPhone',
      theme: ThemeData(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      home: const Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String output = "0"; // Output to display on the screen

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        // Clear the display when C is pressed
        output = "0";
      } else if (buttonText == "=") {
        // Evaluate the expression when = is pressed
        try {
          output = evaluateExpression(output);
        } catch (e) {
          output = "Error"; // Handle errors in the expression
        }
      } else {
        if (output == "0") {
          output = buttonText; // Replace 0 with the pressed button if it's a number
        } else {
          output += buttonText; // Append to the existing expression
        }
      }
    });
  }

  String evaluateExpression(String expression) {
    try {
      expression = expression.replaceAll("x", "*");
      final parsedExpression = Expression.parse(expression);
      const evaluator = ExpressionEvaluator();
      final result = evaluator.eval(parsedExpression, {});
      return result.toString();
    } catch (e) {
      return "Error"; // Return "Error" for invalid expressions
    }
  }

  Widget buildButton(String buttonText, Color color, {double widthFactor = 1.0}) {
    return Expanded(
      flex: widthFactor.toInt(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 22),
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0),
            ),
            elevation: 0,
          ),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Display the output (calculation result)
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(right: 24, bottom: 24),
              alignment: Alignment.bottomRight,
              child: Text(
                output,
                style: const TextStyle(fontSize: 80, color: Colors.white),
              ),
            ),
          ),
          // Button layout
          Column(
            children: [
              Row(
                children: [
                  buildButton("C", Colors.grey.shade600),
                  buildButton("+/-", Colors.grey.shade600),
                  buildButton("%", Colors.grey.shade600),
                  buildButton("/", Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton("7", Colors.grey.shade600),
                  buildButton("8", Colors.grey.shade600),
                  buildButton("9", Colors.grey.shade600),
                  buildButton("x", Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton("4", Colors.grey.shade600),
                  buildButton("5", Colors.grey.shade600),
                  buildButton("6", Colors.grey.shade600),
                  buildButton("-", Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton("1", Colors.grey.shade600),
                  buildButton("2", Colors.grey.shade600),
                  buildButton("3", Colors.grey.shade600),
                  buildButton("+", Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton("0", Colors.grey.shade600, widthFactor: 2),
                  buildButton(".", Colors.grey.shade600),
                  buildButton("=", Colors.orange),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}