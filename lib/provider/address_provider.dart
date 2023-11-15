import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_hex/pages/address.dart/addresShow.dart';
import 'package:firebase_hex/pages/address.dart/addresstyping.dart';
import 'package:firebase_hex/widgets/pdfservies.dart';
import 'package:flutter/material.dart';

class address_provider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late List<dynamic> arrayFromFirestore;
  late String current_address;

  Future<bool> isUserDataAvailable(context) async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      arrayFromFirestore = userSnapshot.get('address');

      if (arrayFromFirestore.length != 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => addressshow()),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TextAddress()),
        );
      }
    }
    return false;
  }

  Future get_current_address(cartItems) async {
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    arrayFromFirestore = userSnapshot.get('address');
    current_address = arrayFromFirestore[0];
    if (current_address != null) {
      PdfService().generateInvoice(cartItems, current_address);
    }
  }
}
