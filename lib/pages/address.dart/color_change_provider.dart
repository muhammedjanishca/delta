import 'package:flutter/material.dart';

class ColorChangingProvider extends ChangeNotifier {
  int _selectedIndex = -1;

  int get selectedIndex => _selectedIndex;

  void updateSelectedIndex(BuildContext context, int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
