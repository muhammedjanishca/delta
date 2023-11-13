import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_hex/pages/address.dart/addresShow.dart';
import 'package:firebase_hex/pages/address.dart/addresstyping.dart';
import 'package:firebase_hex/provider/cart_provider.dart';
import 'package:firebase_hex/widgets/pdfservies.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      print('6666666666666666666');
      print(arrayFromFirestore.length);

      print(arrayFromFirestore);
// var addressDataLength=userSnapshot.exists && userSnapshot['address'] ;
// print(userSnapshot.exists && userSnapshot['address'] );

      if (arrayFromFirestore.length != 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => addressshow()),
        );
      } else {
        print('aaaaaaaaaaaaaaaaaaaaaa');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Delivarypage()),
        );
      }
      // Check if the desired field exists and contains data
      // return userSnapshot.exists && userSnapshot['address'] != null;
    }
    return false;
  }

  Future get_current_address(cartItems) async {
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    //  print(userSnapshot);

    arrayFromFirestore = userSnapshot.get('address');
    current_address = arrayFromFirestore[0];
    if (current_address != null) {
      PdfService().generateInvoice(cartItems, current_address);
    }
// print(current_address);
  }
}

class puthiyapage extends StatelessWidget {
  const puthiyapage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getCartData();
    var cartItems = cartProvider.fetchedItems;

    return Scaffold(body:
       Container(
  padding: EdgeInsets.all(16.0),
  child: Column(
    children: List.generate(cartItems["address"].length, (index) {
      final item = cartItems["address"][index];

      // Check if the item is not null before decoding
      if (item != null) {
        final decodedItem = jsonDecode(item);

        // Extract the data from the decoded item
        String itemName = decodedItem['COMPANY NAME'] ?? 'N/A';
        String itemCompany = decodedItem['Contact Number'] ?? 'N/A';
        String itemAddress = decodedItem['Street Address'] ?? 'N/A';

        // Create a Container for each item
        return Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name: $itemName'),
              Text('Company: $itemCompany'),
              Text('Address: $itemAddress'),
              // Add any other widgets or styling as needed
            ],
          ),
        );
      } else {
        // Handle the case where the item is null
        return Container(
          child: Text('Item is null'),
        );
      }
    }),
  ),
)

    );
  }
}





//  floatingActionButton: FloatingActionButton(
//         backgroundColor: Color.fromARGB(255, 76, 138, 131),
//         onPressed: () {
//           context.read<address_provider>().get_current_address(cartItems);
// // late var address_data=context.read<address_provider>().current_address;
// // print(address_data);
// print('3333333333333333');
//           // Add your FloatingActionButton logic here
//           // PdfService().generateInvoice(cartItems,);
//         },
//         child: const Icon(Icons.print),
//       ),
