import 'package:flutter/foundation.dart';

class SelectedThumbnailProvider extends ChangeNotifier {
  String? _selectedThumbnail;
  int? selectedIndex;
 String _selectedThumbnails = "";
  String? get selectedThumbnail => _selectedThumbnail;

  void setSelectedThumbnail(
    String thumbnailUrl,
  {int? index}) {
    _selectedThumbnail = thumbnailUrl;
    selectedIndex = index;
    notifyListeners();
  }
 void setSelectedThumbnails(String imageUrl) {
    _selectedThumbnails = imageUrl;
    notifyListeners();
  }

}
class SelectedKiduProvider extends ChangeNotifier {
  String? _selectedKidu;
  // int? selectedIndex;

  String? get selectedKidu => _selectedKidu;

  void setSelectedKidu(String thumbnailUrl) {
    _selectedKidu = thumbnailUrl;
    // selectedIndex = index??selectedIndex;
    notifyListeners();
  }
}
class ImageSelection extends ChangeNotifier {
  String? _selectedImage;


  String? get selecteImage => _selectedImage;

  void setSelectedImage(String thumbnailUrl,) {
    _selectedImage = thumbnailUrl;
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

