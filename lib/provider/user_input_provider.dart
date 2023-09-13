import 'package:flutter/material.dart';

class UserInputProvider with ChangeNotifier {
  String _userInput = '';

  String get userInput => _userInput;

  void setUserInput(String input) {
    _userInput = input;
    notifyListeners();
  }
}