import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
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
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      } else if (buttonText == "=") {
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }

        equationFontSize = 38.0;
        resultFontSize = 48.0;
      } else if (buttonText == "±") {
        if (equation != "0") {
          if (equation.startsWith("-")) {
            equation = equation.substring(1);
          } else {
            equation = "-$equation";
          }
        }
      } else if (buttonText == "⌫") {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else {
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
        equationFontSize = 48.0;
        resultFontSize = 38.0;
      }
    });
  }

  Widget buildButton(String buttonText, Color buttonColor, Color textColor) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.zero,
        child: TextButton(
          onPressed: () => buttonPressed(buttonText),
          style: TextButton.styleFrom(
            backgroundColor: buttonColor,
            minimumSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
          ),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 30.0,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
                  child: Text(
                    equation,
                    style: TextStyle(fontSize: equationFontSize),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
                  child: Text(
                    result,
                    style: TextStyle(fontSize: resultFontSize),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
            ],
          ),
          const Expanded(
            child: Divider(),
          ),
          Column(
            children: [
              Row(
                children: [
                  buildButton("C", Colors.redAccent, Colors.white),
                  buildButton("()", Colors.grey, Colors.white),
                  buildButton("%", Colors.grey, Colors.white),
                  buildButton("÷", Colors.green, Colors.white),
                ],
              ),
              Row(
                children: [
                  buildButton("7", Colors.black54, Colors.white),
                  buildButton("8", Colors.black54, Colors.white),
                  buildButton("9", Colors.black54, Colors.white),
                  buildButton("×", Colors.green, Colors.white),
                ],
              ),
              Row(
                children: [
                  buildButton("4", Colors.black54, Colors.white),
                  buildButton("5", Colors.black54, Colors.white),
                  buildButton("6", Colors.black54, Colors.white),
                  buildButton("-", Colors.green, Colors.white),
                ],
              ),
              Row(
                children: [
                  buildButton("1", Colors.black54, Colors.white),
                  buildButton("2", Colors.black54, Colors.white),
                  buildButton("3", Colors.black54, Colors.white),
                  buildButton("+", Colors.green, Colors.white),
                ],
              ),
              Row(
                children: [
                  buildButton("±", Colors.black54, Colors.white),
                  buildButton("0", Colors.black54, Colors.white),
                  buildButton(".", Colors.black54, Colors.white),
                  buildButton("=", Colors.green, Colors.white),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}