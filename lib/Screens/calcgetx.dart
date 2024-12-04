import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calcgetx extends StatefulWidget {
  const Calcgetx({super.key});

  @override
  CalcgetxState createState() => CalcgetxState();
}

class CalcgetxState extends State<Calcgetx> {
  String question = '';
  String answer = '0';

  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        question = '';
        answer = '0';
      } else if (value == '⌫') {
        if (question.isNotEmpty) {
          question = question.substring(0, question.length - 1);
        }
      } else if (value == '=') {
        try {
          String parsedQuestion = question
              .replaceAll('×', '*')
              .replaceAll('÷', '/')
              .replaceAll('%', 'mod');
          Parser parser = Parser();
          Expression exp = parser.parse(parsedQuestion);
          ContextModel cm = ContextModel();
          double eval = exp.evaluate(EvaluationType.REAL, cm);
          answer = eval.toString();
        } catch (e) {
          answer = 'Error';
        }
      } else {
        question += value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Display the question
          Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Text(
              question,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          // Display the answer
          Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Text(
              answer,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),
          // Keypad
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemCount: buttons.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _onButtonPressed(buttons[index]),
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        buttons[index],
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<String> buttons = [
    '7', '8', '9', '÷',
    '4', '5', '6', '×',
    '1', '2', '3', '-',
    'C', '0', '00', '+',
    '%', '⌫', '=', '/',
  ];
}
