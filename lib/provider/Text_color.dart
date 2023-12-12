// import 'package:flutter/material.dart';

// class TextProvider extends ChangeNotifier {
//   Color _textColor = Colors.black;

//   Color get textColor => _textColor;

//   void changeTextColor(Color newColor) {
//     _textColor = newColor;
//     notifyListeners();
//   }
// }

import 'package:flutter/material.dart';

class SelectedPriceNotifier extends ChangeNotifier {
  String _selectedPrice = '';
  String get selectedPrice => _selectedPrice;

  bool _isProductCodeSelected = false;
  bool get isProductCodeSelected => _isProductCodeSelected;

  void setSelectedPrice(String price) {
    _selectedPrice = price;
    notifyListeners();
  }

  void setProductCodeSelected(bool isSelected) {
    _isProductCodeSelected = isSelected;
    notifyListeners();
  }
}
