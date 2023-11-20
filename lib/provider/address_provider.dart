import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_hex/pages/address.dart/addresShow.dart';
import 'package:firebase_hex/pages/address.dart/sideSheetAddress.dart';
import 'package:firebase_hex/widgets/pdfservies.dart';
import 'package:flutter/material.dart';

class AddressProvider with ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  late List<dynamic> arrayFromFirestore;
  late String current_address;
  var fetchedItems;

  Future<bool> isUserDataAvailable(context) async {
    User? user = auth.currentUser;
    if (user != null) {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      arrayFromFirestore = userSnapshot.get('address');

// var addressDataLength=userSnapshot.exists && userSnapshot['address'] ;
// print(userSnapshot.exists && userSnapshot['address'] );

      if (arrayFromFirestore != null) {
        print('aaaaaaaaaaaaaaaaaaaaaa');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddressShow()),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TextAddress()),
        );
      }
      // Check if the desired field exists and contains data
      // return userSnapshot.exists && userSnapshot['address'] != null;
    }
    return false;
  }

  // ignore: non_constant_identifier_names
  Future get_current_address(cartItems) async {
    print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    //  print(userSnapshot);

    arrayFromFirestore = userSnapshot.get('address');
    current_address = arrayFromFirestore[0];
    final last_address = jsonDecode(arrayFromFirestore[0]);
    if (current_address.isNotEmpty) {
      print('22222222222222222222222222');
      PdfService().generateInvoice(cartItems, current_address, last_address);
    }
  }

  

     void removeAddress(int index, var address) async {
    address.removeAt(index);

    await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .update({'address': address});
    notifyListeners();
  }
 
}
