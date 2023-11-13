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
  final ctctController = TextEditingController();
  final line1AddController = TextEditingController();
  final line2AddController = TextEditingController();
  final cityController = TextEditingController();
  var addressDetails = {};
  var fetchedAddressDetails = [];
   List<String> _locations = [
  'Riyadh (Ar-Riyad)',
  'Makkah (Makkah Al-Mukarramah)',
  'Madinah (Al-Madinah Al-Munawwarah)',
  'Eastern Province (Ash Sharqiyah)',
  'Asir',
  'Qassim (Al-Qassim)',
  'Hail',
  'Tabuk',
  'Najran',
  'Jazan',
  'Northern Borders (Al-Hudud ash Shamaliyah)',
  'Al Jawf',
  'Baha',
]; // Option 2
  String? _selectedLocation;
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
 
    super.dispose();
  }

  getAddress() async {
    var ad = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    return ad;
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getCartData();
    var cartItems = cartProvider.fetchedItems;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:  AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leadingWidth: 48,
          title: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/');
                },
                child: Text(
                  "DELTA",
                  style: GoogleFonts.oswald(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 45,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Text(
                "\n NATIONAL",
                style: GoogleFonts.oswald(
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      body: Center(
        child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width / 2.5,
          height: MediaQuery.of(context).size.height / 1,
          child: Column(
            children: [
              const SizedBox(
                height: 57,
              ),
      
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
              Gap(35),
               Row(
                children: [
                  Icon(Icons.location_on_outlined),
                  Text(
                    "Address",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
             
             TextFieldAddress(
                  " COMPANY NAME", TextInputType.text, nameController, context, (value) {
                if (value == null || value.isEmpty) {
                  return '*This field cannot be empty';
                }
                return null;
              }),
             TextFieldAddress("Contact Number", TextInputType.phone,
                  ctctController, context, (value) {
                if (value == null || value.isEmpty) {
                  return '*This field cannot be empty';
                }
                return null;
              }),
               Gap(25),
                Row(
                children: [
                  Icon(Icons.location_on_outlined),
                  Text(
                    "Address",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
             TextFieldAddress(
                  "Street Address", TextInputType.text, line1AddController, context,
                  (value) {
                if (value == null || value.isEmpty) {
                  return '*This field cannot be empty';
                }
                return null;
              }),
              TextFieldAddress("Street Address line 2", TextInputType.text,
                  line2AddController, context, (value) {
                if (value == null || value.isEmpty) {
                  return '*This field cannot be empty';
                }
                return null;
              }),
               Gap(10),
       DropdownButton(
            hint: Text('Please choose a location'), // Not necessary for Option 1
            value: _selectedLocation,
            onChanged: (newValue) {
              setState(() {
                _selectedLocation = newValue;
              });
            },
            items: _locations.map((location) {
              return DropdownMenuItem(
                child: new Text(location),
                value: location,
              );
            }).toList(),),
             TextFieldAddress(
                  "City", TextInputType.text, cityController, context, (value) {
                if (value == null || value.isEmpty) {
                  return '*This field cannot be empty';
                }
                return null;
              }),
              Gap(25),
                     ElevatedButton(
                        onPressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => addressshow()));
                          // addressDetails['Name'] = nameController.text;
                          addressDetails['COMPANY NAME'] =
                              nameController.text;
                          addressDetails['Contact Number'] = ctctController.text;
                          addressDetails['Street Address'] = line1AddController.text;
                          addressDetails['Street Address line 2'] = line2AddController.text;
                          addressDetails['city'] = cityController.text;
                          // addressDetails['phone'] = phoneController.text;

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
                        child: Text(
                          'Save Address and Continue',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 54, 98, 98)),
                          minimumSize: MaterialStateProperty.all(Size(670, 50)),
                        ),
                      ),
            ],
          ),
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
        "${item['COMPANY NAME']}",
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18
            // You can also specify other text styles here, e.g., fontSize, color, etc.
            ),
      ),
      Text(
        "${item['Contact Number']}",
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18
            // You can also specify other text styles here, e.g., fontSize, color, etc.
            ),
      ),
      Text(
        "${item['City']}",
        // "${item['vat']} ,  " "${item['state']}",
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18
            // You can also specify other text styles here, e.g., fontSize, color, etc.
            ),
      ),
      Text(
        "${item['Street Address']} ,  " "${item['Street Address line 2']}",
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18
            // You can also specify other text styles here, e.g., fontSize, color, etc.
            ),
      ),
    ],
  );
}