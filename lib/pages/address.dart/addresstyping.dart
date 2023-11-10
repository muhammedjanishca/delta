import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_hex/pages/address.dart/addresShow.dart';
import 'package:firebase_hex/pages/address.dart/address_text.dart';
import 'package:firebase_hex/provider/cart_provider.dart';
import 'package:firebase_hex/widgets/style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

class Delivarypage extends StatefulWidget {
  const Delivarypage({Key? key}) : super(key: key);

  @override
  _DelivarypageState createState() => _DelivarypageState();
}

class _DelivarypageState extends State<Delivarypage> {
  final nameController = TextEditingController();
  final companyNameController = TextEditingController();
  final addressController = TextEditingController();
  final vatController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();
  final phoneController = TextEditingController();
  var addressDetails = {};
  var fetchedAddressDetails = [];
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    // companyNameController.dispose();
    // addressController.dispose();
    // emailController.dispose();
    // phoneNumberController.dispose();

    super.dispose();
  }

  getAddress() async {
    var ad = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    return ad;
  }
Future<void> removeAddress() async {
  try {
    var documentReference = FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid);

    // Check if the document exists before trying to delete it
    var documentSnapshot = await documentReference.get();
    if (documentSnapshot.exists) {
      // Document exists, proceed with deletion
      await documentReference.delete();
      print("Address removed successfully");
    } else {
      print("No address found to remove");
    }
  } catch (e) {
    print("Error removing address: $e");
    // Handle the error as needed
  }
}

  // removalAddress() async {
  //   var remove = await FirebaseFirestore.instance
  //   .collection("users");
  //   .doc(FirebaseAuth.instance.currentUser! .uid)
  // }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getCartData();
    var cartItems = cartProvider.fetchedItems;
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  // color: Colors.blue,
                  width: 150,
                  height: MediaQuery.of(context).size.height,
                ),
                Container(
                  // color: Colors.amber,
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height / 1,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 57,
                      ),
                      // ElevatedButton(
                      //   onPressed: () async {
                      //     addressDetails['Name'] = nameController.text;
                      //     addressDetails['companyName'] =
                      //         companyNameController.text;
                      //     addressDetails['address'] = addressController.text;
                      //     addressDetails['vat'] = vatController.text;
                      //     addressDetails['state'] = stateController.text;
                      //     addressDetails['city'] = cityController.text;
                      //     addressDetails['phone'] = phoneController.text;

                      //     var details = await FirebaseFirestore.instance
                      //         .collection("users")
                      //         .doc(FirebaseAuth.instance.currentUser!.uid)
                      //         .get();
                      //     fetchedAddressDetails = details["address"];
                      //     fetchedAddressDetails.add(jsonEncode(addressDetails));

                      //     await FirebaseFirestore.instance
                      //         .collection('users')
                      //         .doc(FirebaseAuth.instance.currentUser!.uid)
                      //         .update({'address': fetchedAddressDetails});
                      //     // Navigator.push(context,  MaterialPageRoute(builder: (context) => const dood()));
                      //   },
                      //   style: ButtonStyle(
                      //     backgroundColor: MaterialStateProperty.all<Color>(Colors
                      //         .black), // Change the color to your desired color
                      //   ),
                      //   child: Text('Show Data on Next Page'),
                      // ),
                      Text(
                        'ENTER COMPANY NAME AND ADDRESS',
                        style: GoogleFonts.oswald(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 57,
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width / 2.5,
                          child: DelivaryCustTextField(
                            'NAME',
                            nameController,
                            context,
                          )),
                      SizedBox(
                        height: 57,
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width / 2.5,
                          child: DelivaryCustTextField(
                            'COMPANY NAME',
                            companyNameController,
                            context,
                          )),
                      SizedBox(
                        height: 57,
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width / 2.5,
                          child: DelivaryCustTextField(
                            'ADDRESS',
                            addressController,
                            context,
                          )),
                      SizedBox(
                        height: 57,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: MediaQuery.of(context).size.height / 5,
                          color: Colors.white,
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                    //width: MediaQuery.of(context).size.width / 2.5,
                                    width: 250,
                                    child: DelivaryCustTextField(
                                      'VAT NO',
                                      vatController,
                                      context,
                                    )),
                                SizedBox(
                                    //width: MediaQuery.of(context).size.width / 2.5,
                                    width: 250,
                                    child: DelivaryCustTextField(
                                      'STATE',
                                      stateController,
                                      context,
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                    //width: MediaQuery.of(context).size.width / 2.5,
                                    width: 250,
                                    child: DelivaryCustTextField(
                                      'CITY',
                                      cityController,
                                      context,
                                    )),
                                SizedBox(
                                    //width: MediaQuery.of(context).size.width / 2.5,
                                    width: 250,
                                    child: DelivaryCustTextField(
                                      'phone',
                                      phoneController,
                                      context,
                                    )),
                              ],
                            ),
                          ])),
                      Gap(5),
                      ElevatedButton(
                        onPressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => addressshow()));
                          addressDetails['Name'] = nameController.text;
                          addressDetails['companyName'] =
                              companyNameController.text;
                          addressDetails['address'] = addressController.text;
                          addressDetails['vat'] = vatController.text;
                          addressDetails['state'] = stateController.text;
                          addressDetails['city'] = cityController.text;
                          addressDetails['phone'] = phoneController.text;

                          var details = await FirebaseFirestore.instance
                              .collection("users")
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .get();
                          fetchedAddressDetails = details["address"];
                          fetchedAddressDetails.add(jsonEncode(addressDetails));

                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .update({'address': fetchedAddressDetails});
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors
                              .black), // Change the color to your desired color
                        ),
                        child: Text('Continue'),
                      ),

                      //
                    ],
                  ),
                ),
                // SizedBox(
                //     width: MediaQuery.of(context).size.width / 2.5,
                //     height: MediaQuery.of(context).size.width / 2.1,
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //       children: [
                //         Container(
                //           color: janishcolor,
                //           child: Column(
                //             children: [
                //               ListView.builder(
                //                 scrollDirection: Axis.vertical,
                //                 shrinkWrap: true,
                //                 itemCount: cartItems["address"].length,
                //                 itemBuilder: (BuildContext context, int index) {
                //                   // Check if it's not the first item
                //                   bool isNotFirstItem = index != 0;

                //                   // If it's not the first item, add a Divider
                //                   if (isNotFirstItem) {
                //                     return Column(
                //                       children: [
                //                         Divider(
                //                           color: Colors
                //                               .black, // Set the color of the divider
                //                           thickness:
                //                               1, // Set the thickness of the divider
                //                         ),
                //                         AddressData(jsonDecode(
                //                             cartItems["address"][index])),
                //                       ],
                //                     );
                //                   }

                //                   // If it's the first item, don't add a Divider
                //                   return AddressData(
                //                       jsonDecode(cartItems["address"][index]));
                //                 },
                //               ),
                //               Row(
                //                 mainAxisAlignment: MainAxisAlignment.end,
                //                 children: [
                //                   ElevatedButton(
                //                     onPressed: () {
                //                       // Your button's action here
                //                     },
                //                     style: ButtonStyle(
                //                       backgroundColor: MaterialStateProperty
                //                           .all<Color>(Colors
                //                               .black), // Change the color to your desired color
                //                     ),
                //                     child: Text('My Button'),
                //                   ),
                //                 ],
                //               )
                //             ],
                //           ),
                //         )
                //       ],
                //     )
                //     ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

AddressData(data) {
  final item = data;
  return Column(
    children: [
      Text(
        "${item['Name']} ,  " "${item['companyName']}",
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18
            // You can also specify other text styles here, e.g., fontSize, color, etc.
            ),
      ),
      Text(
        "${item['address']}",
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18
            // You can also specify other text styles here, e.g., fontSize, color, etc.
            ),
      ),
      Text(
        "${item['vat']} ,  " "${item['state']}",
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18
            // You can also specify other text styles here, e.g., fontSize, color, etc.
            ),
      ),
      Text(
        "${item['city']} ,  " "${item['phone']}",
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18
            // You can also specify other text styles here, e.g., fontSize, color, etc.
            ),
      ),
    ],
  );
}
