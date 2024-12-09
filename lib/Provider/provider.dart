import 'dart:io';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

import '../Theme/themes.dart';

class CalculatorProvider with ChangeNotifier {
  String _question = '';
  String _answer = '0';
  int _bnIndex = 0;
  File? _image;



  File? get image => _image;
  String get question => _question;
  String get answer => _answer;
  int get bnIndex => _bnIndex;

  void onButtonPressed(String value) {
    if (value == 'C') {
      _question = '';
      _answer = '0';
    } else if (value == '\u232B') {
      if (_question.isNotEmpty) {
        _question = _question.substring(0, _question.length - 1);
      }
    } else if (value == '=') {
      try {
        String parsedQuestion = _question
            .replaceAll('\u00D7', '*')
            .replaceAll('\u00F7', '/')
            .replaceAll('%', 'mod');
        Parser parser = Parser();
        Expression exp = parser.parse(parsedQuestion);
        ContextModel cm = ContextModel();
        double eval = exp.evaluate(EvaluationType.REAL, cm);
        if (eval % 1 == 0) {
          _answer = eval.toInt().toString();
        } else {
          _answer = eval.toStringAsFixed(2);
        }
      } catch (e) {
        _answer = 'Error';
      }
    } else {
      _question += value;
    }
    notifyListeners();
  }

  Color getButtonColor(String button) {
    if (['C', '%', '\u232B'].contains(button)) {
      return Themes.buttongrey;
    } else if (['+', '-', '\u00D7', '\u00F7'].contains(button)) {
      return Themes.orange;
    } else if (['='].contains(button)) {
      return Themes.darkblue;
    } else {
      return Themes.cream;
    }
  }

  Color getTextColor(String button) {
    if (['+', '-', '\u00D7', '\u00F7', '='].contains(button)) {
      return Themes.white;
    } else {
      return Themes.black;
    }
  }

  double fontSize(String button) {
    if (['+', '-', '\u00D7', '\u00F7', '='].contains(button)) {
      return 36;
    } else {
      return 28;
    }
  }

  void setBottomNavIndex(int index) {
    _bnIndex = index;
    notifyListeners();
  }

  void setImage(File image) {
    _image = image;
    notifyListeners();
  }

  void removeImage() {
    _image = null;
    notifyListeners();
  }
}
