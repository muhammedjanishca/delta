import 'package:flutter/foundation.dart';

class ImageHoveroProvider extends ChangeNotifier {
  int selectedImageIndex = -1;

  void setSelectedImageIndex(int index) {
    selectedImageIndex = index;
    notifyListeners();
  }
}
