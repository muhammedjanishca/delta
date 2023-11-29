import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectedPriceProvider extends ChangeNotifier {
  bool checkPrCode = false;

  void setCheckPrCode(bool value) {
    checkPrCode = value;
    notifyListeners();
  }
}
