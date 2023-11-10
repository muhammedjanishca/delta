import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> _cartItems = [];
  var _newCartItem = {};
  List<dynamic> _cartData = [];
  var fetchedItems;
  final FirebaseAuth auth = FirebaseAuth.instance;

  List<CartItem> get cartItems => _cartItems;
  getCartData() async {
    fetchedItems = await FirebaseFirestore.instance
        .collection("users")
        .doc(auth.currentUser!.uid)
        .get();

    notifyListeners();
  }
   getAddressData() async {
    fetchedItems = await FirebaseFirestore.instance
        .collection("users")
        .doc(auth.currentUser!.uid)
        .get();

    notifyListeners();
  }
  

  void addToCart(String productCode, double price, int quantity,
      String imageUrl, String productName) async {
    _cartItems
        .add(CartItem(productCode, price, quantity, imageUrl, productName));
    _newCartItem["productCode"] = productCode;
    _newCartItem["price"] = price;
    _newCartItem["quantity"] = quantity;
    _newCartItem["imageUrl"] = imageUrl;
    _newCartItem["productName"] = productName;
    var details = await FirebaseFirestore.instance
        .collection("users")
        .doc(auth.currentUser!.uid)
        .get();
    _cartData = details["cartItems"];
    _cartData.add(jsonEncode(_newCartItem));

    await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .update({'cartItems': _cartData});
    notifyListeners();
  }

  void removeFromCart(int index, var cartItems) async {
    cartItems.removeAt(index);

    await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .update({'cartItems': cartItems});
    notifyListeners();
  }

  // double getTotalPrice() {
  //   double totalPrice = 0.0;
  //   for (var item in fetchedItems["cartItems"]) {
  //     totalPrice += jsonDecode(item)["price"] * jsonDecode(item)["quantity"];
  //   }
  //   return totalPrice;
  // }
 double getTotalPrice() {
  double totalPrice = 0.0;
  for (var item in fetchedItems["cartItems"]) {
    totalPrice += jsonDecode(item)["price"] * jsonDecode(item)["quantity"];
  }
  return totalPrice;
}

double calculateVAT(double subtotal, double vatRate) {
  return subtotal * (vatRate / 100);
}

double getTotalPriceWithVAT(double subtotal, double vatRate) {
  double vat = calculateVAT(subtotal, vatRate);
  return subtotal + vat;
}


  void updateQuantity(int productIndex, int newQuantity) async {
    await getCartData();
    print(jsonDecode(fetchedItems['cartItems'][productIndex])['quantity']);
    var updatedData = jsonDecode(fetchedItems['cartItems'][productIndex]);
    updatedData['quantity'] = newQuantity;
    var updatedList = fetchedItems['cartItems'];
    updatedList.removeAt(productIndex);
    updatedList.insert(productIndex, jsonEncode(updatedData));
    await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .update({'cartItems': updatedList});


    notifyListeners();
  }
  // Future<void> removeAddress() async {
  //   try {
  //     var documentReference = FirebaseFirestore.instance
  //         .collection("users")
  //         .doc(FirebaseAuth.instance.currentUser!.uid);

  //     // Check if the document exists before trying to delete it
  //     var documentSnapshot = await documentReference.get();
  //     if (documentSnapshot.exists) {
  //       // Document exists, proceed with deletion
  //       await documentReference.delete();
  //       print("Address removed successfully");

  //       // Optionally, you can add code here to update your UI or perform any additional actions after deletion.
  //     } else {
  //       print("No address found to remove");
  //     }
  //   } catch (e) {
  //     print("Error removing address: $e");
  //     // Handle the error as needed
  //   }
  // }
  // void updateQuantity(String productCode, int newQuantity) {
  //   final cartItem = _cartItems.firstWhere((item) => item.productCode == productCode);
  //   cartItem.updateQuantity(newQuantity);
  //   notifyListeners();
  // }
}

class CartItem {
  final String productCode;
  final double price;
  int quantity;
  final String imageUrl;
  final String productName;

  CartItem(this.productCode, this.price, this.quantity, this.imageUrl,
      this.productName);

  void updateQuantity(int newQuantity) {
    quantity = newQuantity;
  }
}


