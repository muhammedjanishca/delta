// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserInputProvider with ChangeNotifier {
  var user;
  String _userInput = '';

  String get userInput => _userInput;


  void setUserInput(String input) {
    _userInput = input;
    notifyListeners();
  }
}
