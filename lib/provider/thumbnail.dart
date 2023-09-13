import 'package:flutter/foundation.dart';

class SelectedThumbnailProvider extends ChangeNotifier {
  String? _selectedThumbnail;

  String? get selectedThumbnail => _selectedThumbnail;

  void setSelectedThumbnail(String thumbnailUrl) {
    _selectedThumbnail = thumbnailUrl;
    notifyListeners();
  }
}
class SelectedCodeProvider extends ChangeNotifier {
  String? _selectedProductCode;

  String? get selectedProductCode => _selectedProductCode;

  void setSelectedProductCode(String productCode) {
    _selectedProductCode = productCode;
    notifyListeners();
  }
}
