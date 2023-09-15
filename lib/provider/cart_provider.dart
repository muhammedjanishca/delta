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
 
  double getTotalPrice() {
    double totalPrice = 0.0;
    for (var item in fetchedItems["cartItems"]) {
      totalPrice += jsonDecode(item)["price"] * jsonDecode(item)["quantity"];
    }
    return totalPrice;
  }

  // void updateQuantity(String productCode, int newQuantity) {
  //   final cartItem = _cartItems.firstWhere((item) => item.productCode == productCode);
  //   cartItem.updateQuantity(newQuantity);
  //   notifyListeners();
  // }
  
  void updateQuantity(String productCode, int newQuantity) {
    final cartItem = _cartItems.firstWhere((item) => item.productCode == productCode);
    cartItem.updateQuantity(newQuantity);
    notifyListeners();
  }
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



 // void removeFromCart(String productCode) {
  //   _cartItems.removeWhere((item) => item.productCode == productCode);
  //   notifyListeners();
  // }

  // double getTotalPrice() {
  //   double totalPrice = 0.0;
  //   for (var item in _cartItems) {
  //     totalPrice += item.price * item.quantity;
  //   }
  //   return totalPrice;
  // }