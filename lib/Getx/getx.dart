import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:math_expressions/math_expressions.dart';

import '../Theme/themes.dart';

class CalculatorController extends GetxController {
  var question = ''.obs;
  var answer = '0'.obs;
  var bnindex = 0.obs;

  void onButtonPressed(String value) {
    if (value == 'C') {
      question.value = '';
      answer.value = '0';
    } else if (value == '\u232B') {
      if (question.isNotEmpty) {
        question.value = question.substring(0, question.value.length - 1);
      }
    } else if (value == '=') {
      try {
        String parsedQuestion = question.value
            .replaceAll('\u00D7', '*')
            .replaceAll('\u00F7', '/')
            .replaceAll('%', 'mod');
        Parser parser = Parser();
        Expression exp = parser.parse(parsedQuestion);
        ContextModel cm = ContextModel();
        double eval = exp.evaluate(EvaluationType.REAL, cm);
        if (eval % 1 == 0) {
          answer.value = eval.toInt().toString();
        } else {
          answer.value = eval.toStringAsFixed(2);
        }
      } catch (e) {
        answer.value = 'Error';
      }
    } else {
      question.value += value;
    }
  }

  Color getButtonColor(String button) {
    if (['C', '%', '\u232B'].contains(button)) {
      return Themes.buttongrey;
    } else if (['+', '-', '\u00D7', '\u00F7'].contains(button)) {
      return Themes.orange;
    } else if(['='].contains(button)) {
      return Themes.darkblue;
    } else {
      return Themes.cream;
    }
  }

  Color getTextColor(String button) {
    if (['+', '-', '\u00D7', '\u00F7', '\u00F7', '='].contains(button)) {
      return Themes.white;
    } else {
      return Themes.black;
    }
  }

  double fontSize(String button) {
    if (['+', '-', '\u00D7', '\u00F7', '\u00F7', '='].contains(button)) {
      return 36;
    } else {
      return 28;
    }
  }

  void bottomnavindex(int index) {
    bnindex.value = index;
  }
}