import 'package:flutter/material.dart';

class TextProvider extends ChangeNotifier {
  Color _textColor = Colors.black;

  Color get textColor => _textColor;

  void changeTextColor(Color newColor) {
    _textColor = newColor;
    notifyListeners();
  }
}
