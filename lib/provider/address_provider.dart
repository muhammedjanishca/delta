import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_hex/pages/address.dart/addresShow.dart';
import 'package:firebase_hex/pages/address.dart/sideSheetAddress.dart';
import 'package:firebase_hex/provider/indexprovider.dart';
import 'package:firebase_hex/widgets/pdfservies.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressProvider with ChangeNotifier {
  int selectIndex = 0;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  late List<dynamic> arrayFromFirestore;
  late String current_address;
    
     
    //                                            ##  ADDRESS PAGE CONDITION (GENERATE QUOTATION, ELEVATED BUTTON IN CART.DART) ##
    //#############################################################################################################
    //##################################################################################################################################
    //##################################################################################################################################


  Future<bool> isUserDataAvailable(context) async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      arrayFromFirestore = userSnapshot.get('address');

// var addressDataLength=userSnapshot.exists && userSnapshot['address'] ;
// print(userSnapshot.exists && userSnapshot['address'] );

      if (arrayFromFirestore.isEmpty) {
        // print('aaaaaaaaaaaaaaaaaaaaaadd');
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TextAddress()),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddressShow()),
        );
      }
    }
    return false;
  }

  void deleteAddress(int index) async{
    arrayFromFirestore.removeAt(index);

    await FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .update({'address': arrayFromFirestore});
    notifyListeners();
    // if (index >= 5 && index < arrayFromFirestore.length) {
    //   arrayFromFirestore.removeAt(index);
    //   notifyListeners();
    // } else {
    //   print("Invalid index: $index");
    //   print(arrayFromFirestore[index]);
    // }
  }

  Future get_current_address(cartItems, context) async {
// var sssd=context.read<Indexprovider>().selectIndex;
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    //  print(userSnapshot);

    arrayFromFirestore = userSnapshot.get('address');

    current_address = arrayFromFirestore[selectIndex];
    final last_address = jsonDecode(arrayFromFirestore[selectIndex]);
    if (current_address.isNotEmpty) {
      // print('22222222222222222222222222');
      PdfService().generateInvoice(cartItems, current_address, last_address);
    }
  }

  UpdateSelectindex(context, id) {
    // print("___nottttapped");
    selectIndex = id;
    notifyListeners();
  }
}
