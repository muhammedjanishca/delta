import 'package:flutter/material.dart';

class SelectedContainerColorNotifier extends ChangeNotifier {
  Color? selectedColor;

  void setSelectedColor(Color color) {
    selectedColor = color;
    notifyListeners();
  }
}
