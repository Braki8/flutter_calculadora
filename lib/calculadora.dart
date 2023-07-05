import 'dart:math';
import 'package:flutter/material.dart';

class Calculadora extends StatefulWidget {
  const Calculadora({Key? key}) : super(key: key);

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  Widget numButton(String btnText, Color btnColor, Color txtColor) {
    return ElevatedButton(
      onPressed: () {
        calculate(btnText);
      },
      child: Text(
        btnText,
        style: TextStyle(fontSize: btnText == "log" ? 15 : 25, color: txtColor),
      ),
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(70, 70),
        shape: const CircleBorder(),
        primary: btnColor,
      ),
    );
  }

  Widget trigonometricButton(String btnText, Color btnColor, Color txtColor) {
    return ElevatedButton(
      onPressed: () {
        calculateTrigonometric(btnText);
      },
      child: Text(
        btnText,
        style: TextStyle(fontSize: 13, color: txtColor),
      ),
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(70, 70),
        shape: const CircleBorder(),
        primary: btnColor,
      ),
    );
  }

  String text = "";
  double? firstNumber;
  String operation = "";

  void calculate(String btnText) {
    if (btnText == "C") {
      text = "";
      firstNumber = null;
      operation = "";
    } else if (btnText == "+" ||
        btnText == "-" ||
        btnText == "X" ||
        btnText == "/" ||
        btnText == "^") {
      firstNumber = double.tryParse(text);
      operation = btnText;
      text = "";
    } else if (btnText == "=") {
      if (firstNumber != null) {
        final secondNumber = double.tryParse(text);
        if (secondNumber != null) {
          switch (operation) {
            case "+":
              text = (firstNumber! + secondNumber).toString();
              break;
            case "-":
              text = (firstNumber! - secondNumber).toString();
              break;
            case "X":
              text = (firstNumber! * secondNumber).toString();
              break;
            case "/":
              if (secondNumber != 0) {
                text = (firstNumber! / secondNumber).toString();
              } else {
                text = "Error";
              }
              break;
            case "^":
              text = pow(firstNumber!, secondNumber).toString();
              break;
            default:
              text = "Error";
          }
        } else {
          text = "Error";
        }
      } else {
        text = "Error";
      }
    } else if (btnText == "log") {
      if (firstNumber != null) {
        text = log(firstNumber!).toStringAsFixed(2);
      } else {
        text = "Error";
      }
    } else {
      text += btnText;
    }

    setState(() {});
  }

  void calculateTrigonometric(String btnText) {
    double value = double.parse(text);
    double result;

    switch (btnText) {
      case "sin":
        result = sin(value);
        break;
      case "cos":
        result = cos(value);
        break;
      case "tan":
        result = tan(value);
        break;
      default:
        return;
    }

    text = result.toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 1, 10, 27),
      appBar: AppBar(
        title: const Text("Calculadora Científica"),
        backgroundColor: Color.fromARGB(255, 1, 10, 27),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    text,
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white, fontSize: 80),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                trigonometricButton("sin", Colors.grey, Colors.black),
                trigonometricButton("cos", Colors.grey, Colors.black),
                trigonometricButton("tan", Colors.grey, Colors.black),
                numButton("^", (Colors.grey)!,
                    Color.fromARGB(255, 0, 0, 0)), // Botón de exponenciación
                numButton(
                    "log", (Colors.grey)!, const Color.fromARGB(255, 0, 0, 0)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                numButton("C", Colors.grey, Colors.red),
                numButton("+/-", Colors.grey, Colors.black),
                numButton("%", Colors.grey, Colors.black),
                numButton("/", Colors.orange, Colors.white),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                numButton("7", (Colors.grey[850])!, Colors.white),
                numButton("8", (Colors.grey[850])!, Colors.white),
                numButton("9", (Colors.grey[850])!, Colors.white),
                numButton("X", Colors.orange, Colors.white),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                numButton("4", (Colors.grey[850])!, Colors.white),
                numButton("5", (Colors.grey[850])!, Colors.white),
                numButton("6", (Colors.grey[850])!, Colors.white),
                numButton("-", Colors.orange, Colors.white),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                numButton("1", (Colors.grey[850])!, Colors.white),
                numButton("2", (Colors.grey[850])!, Colors.white),
                numButton("3", (Colors.grey[850])!, Colors.white),
                numButton("+", Colors.orange, Colors.white),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    calculate("0");
                  },
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    primary: (Colors.grey[850])!,
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(28, 12, 90, 12),
                    child: Text(
                      "0",
                      style: TextStyle(fontSize: 35, color: Colors.white),
                    ),
                  ),
                ),
                numButton(".", (Colors.grey[850])!, Colors.white),
                numButton("=", Colors.orange, Colors.white),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: Calculadora(),
  ));
}
