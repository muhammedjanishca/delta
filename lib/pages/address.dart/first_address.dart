

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_hex/pages/address.dart/addresShow.dart';
import 'package:firebase_hex/pages/address.dart/dropdown.dart';
import 'package:firebase_hex/pages/address.dart/sideSheetAddress.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';


class TextTheAddress extends StatelessWidget {
  const TextTheAddress({super.key});

  @override
  Widget build(BuildContext context) {
     final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final ctctController = TextEditingController();
    final line1AddController = TextEditingController();
    final line2AddController = TextEditingController();
    final cityController = TextEditingController();
    // final Controller = TextEditingController();
    var addressDetails = {};
  var fetchedAddressDetails = [];
    TextEditingController stateController = TextEditingController();
//      List<String> list =  <String>[
//   'Riyadh (Ar-Riyad)',
//   'Makkah (Makkah Al-Mukarramah)',
//   'Madinah (Al-Madinah Al-Munawwarah)',
//   'Eastern Province (Ash Sharqiyah)',
//   'Asir',
//   'Qassim (Al-Qassim)',
//   'Hail',
//   'Tabuk',
//   'Najran',
//   'Jazan',
//   'Northern Borders (Al-Hudud ash Shamaliyah)',
//   'Al Jawf',
//   'Baha',
// ]; // Option 
// String dropdownValue = list.first;
  String? _selectedLocation;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:AppBar(
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
        ) ,
        body: LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth > 850) {
      // Screen width is less than 650, so center the content
      return Center(
        child: Form(
          key: _formKey,
          child: Container(
            width: MediaQuery.of(context).size.width / 2,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                SizedBox(
                      height: 40,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15),
                        // child: Text(""),
                      )),
                  // Divider(),
                  Gap(10),
                  Row(
                    children: [
                      Icon(Icons.phone),
                      Text(
                        "CONTACT DETAILS",
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  TextFieldAddress(
                      "Company Name", TextInputType.text, nameController, context, (value) {
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
                        "ADDRESS",
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
                    DropDownPage(),
                  TextFieldAddress("Street Address line 2", TextInputType.text,
                      line2AddController, context, (value) {
                    if (value == null || value.isEmpty) {
                      return '*This field cannot be empty';
                    }
                    return null;
                  }),
                  
            Gap(10),
                 TextFieldAddress(
                      "City", TextInputType.text, cityController, context, (value) {
                    if (value == null || value.isEmpty) {
                      return '*This field cannot be empty';
                    }
                    return null;
                  }),
                  Gap(25),
                  // DropDownPage(),
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
                              'Add ADDRESS',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color.fromARGB(255, 54, 98, 98)),
                              minimumSize: MaterialStateProperty.all(Size(1000, 50)),
                            ),
                          ),
 
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      // Screen width is 650 or more, no need to center the content
      return Form(
        key: _formKey,
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                            SizedBox(
                      height: 40,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15),
                        // child: Text(""),
                      )),
                  // Divider(),
                  Gap(10),
                  Row(
                    children: [
                      Icon(Icons.phone),
                      Text(
                        "CONTACT DETAILS",
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  TextFieldAddress(
                      "Company Name", TextInputType.text, nameController, context, (value) {
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
                        "ADDRESS",
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
               DropDownPage(),
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
                              'Add ADDRESS',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color.fromARGB(255, 54, 98, 98)),
                              minimumSize: MaterialStateProperty.all(Size(1000, 50)),
                            ),
                          ),
              ],
            ),
          ),
        ),
      );
    }
  },
),
         );
  }
}