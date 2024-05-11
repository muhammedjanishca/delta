import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_hex/pages/address.dart/addresShow.dart';
import 'package:firebase_hex/widgets/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../another_pages/IRSH.dart';

class TextAddress extends StatefulWidget {
  const TextAddress({super.key});

  @override
  State<TextAddress> createState() => _TextAddressState();
}

class _TextAddressState extends State<TextAddress> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final ctctController = TextEditingController();
  final emailController = TextEditingController();
  final line1AddController = TextEditingController();
  final line2AddController = TextEditingController();
  final cityController = TextEditingController();
  
  final FocusNode _dropdown = FocusNode();
  final FocusNode _ccntact = FocusNode();
  final FocusNode _cemail = FocusNode();
  final FocusNode _cline1 = FocusNode();
  final FocusNode _cline2 = FocusNode();
  final FocusNode _city = FocusNode();
  final FocusNode _enter = FocusNode();
  


  var addressDetails = {};
  var fetchedAddressDetails = [];
  TextEditingController stateController = TextEditingController();
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
  String? selectedLocation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: custSmallAppBar(context, Colors.white),
        body: LayoutBuilder(builder: (context, Constraints) {
          if (Constraints.maxWidth > 850) {
            return Center(
                child: Form(
              key: _formKey,
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(40),
                      SizedBox(
                          height: 40,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Text("ADD ADDRESS",style: GoogleFonts.poppins(),),
                          )),
                      Divider(),
                      Gap(10),
                      Row(
                        children: [
                          Icon(Icons.phone),
                          Text(
                            "Contact Details",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      TextFieldAddress(hintText: "Company Name",keyboardType:  TextInputType.text,
                         controller:  nameController,focunodenext: _ccntact,
                         context:  context, validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '*This field cannot be empty';
                        }
                        return null;
                      }),
                      TextFieldAddress(hintText: "Contact Number", keyboardType: TextInputType.phone,focunode:_ccntact ,
                          controller: ctctController,focunodenext:_cemail , context: context, validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field cannot be empty';
                        }
                        if (!isValidPhoneNumber(value)) {
                          return 'Please enter the valid phone number';
                        }
                        return null;
                      }),
                      TextFieldAddress(
                          hintText: "Email",keyboardType:  TextInputType.text,
                          focunode:_cemail,focunodenext: _cline1,
                          controller:emailController,context:  context,
                         validator:  (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field cannot be empty';
                        }
                        if (!isValidEmail(value)) {
                          return 'Please enter the valid email Id';
                        }
                        return null;
                      }),
                      Gap(25),
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined),
                          Text(
                            "Address",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      TextFieldAddress(hintText: "Street Address", keyboardType: TextInputType.text,
                          controller: line1AddController,context:  context,focunode: _cline1,focunodenext: _cline2, validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '*This field cannot be empty';
                        }
                        return null;
                      }),
                      TextFieldAddress(
                          hintText: "Street Address line 2",
                          keyboardType: TextInputType.text,
                          controller: line2AddController,
                         context:  context,focunode: _cline2,focunodenext: _dropdown,
                         validator:  (value) {
                        if (value == null || value.isEmpty) {
                          return '*This field cannot be empty';
                        }
                        return null;
                      }),
                        Gap(10),
                        DropdownButton(
                          
                          focusNode: _dropdown,
                          
                          hint: Text(
                              'Please choose a location'), // Not necessary for Option 1
                          value: selectedLocation,
                          onChanged: (newValue) {
                            setState(() {
                              selectedLocation = newValue;
                            });
                             FocusScope.of(context).requestFocus(_city);
                          },
                          items: _locations.map((location) {
                            return DropdownMenuItem(
                              child: new Text(location),
                              value: location,
                            );
                          }).toList(),
                        ),
                        TextFieldAddress(hintText: 
                            "City",keyboardType:  TextInputType.text,controller:  cityController,
                            context:  context,focunodenext:_enter ,
                            focunode: _city,
                           validator:  (value) {
                          if (value == null || value.isEmpty) {
                            return '*This field cannot be empty';
                          }
                          return null;
                        }),
                        Gap(25),
                        ElevatedButton(
                          focusNode: _enter,
                          onPressed: () async {
                             FocusScope.of(context).requestFocus();
                            if (_formKey.currentState!.validate()) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddressShowPage()));
                              // addressDetails['Name'] = nameController.text;
                              addressDetails['Company Name'] =
                                  nameController.text;
                              addressDetails['Contact Number'] =
                                  ctctController.text;
                              addressDetails['Email'] = emailController.text;
                              addressDetails['Street Address'] =
                                  line1AddController.text;
                              addressDetails['Street Address line 2'] =
                                  line2AddController.text;
                              addressDetails['City'] = cityController.text;
                              addressDetails['Location'] = selectedLocation;

                              var details = await FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .get();
                              fetchedAddressDetails = details["address"];
                              fetchedAddressDetails
                                  .add(jsonEncode(addressDetails));

                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .update({'address': fetchedAddressDetails});
                            }
                          },
                          child: Text(
                            'ADD ADDRESS',
                            style: GoogleFonts.merriweather(color: Colors.white),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(colorTwo),
                            minimumSize:
                                MaterialStateProperty.all(Size(500, 50)),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ));
          } else {
            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: mai,
                      children: [
                        SizedBox(
                            height: 40,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Text("ADD ADDRESS",style: GoogleFonts.merriweather(),),
                            )),
                        Divider(),
                        Gap(10),
                        Row(
                          children: [
                            Icon(Icons.phone),
                            Text(
                              "Contact Details",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                       TextFieldAddress(hintText: "Company Name",keyboardType:  TextInputType.text,
                         controller:  nameController,focunodenext: _ccntact,
                         context:  context, validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '*This field cannot be empty';
                        }
                        return null;
                      }),
                      TextFieldAddress(hintText: "Contact Number", keyboardType: TextInputType.phone,focunode:_ccntact ,
                          controller: ctctController,focunodenext:_cemail , context: context, validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field cannot be empty';
                        }
                        if (!isValidPhoneNumber(value)) {
                          return 'Please enter the valid phone number';
                        }
                        return null;
                      }),
                      TextFieldAddress(
                          hintText: "Email",keyboardType:  TextInputType.text,
                          focunode:_cemail,focunodenext: _cline1,
                          controller:emailController,context:  context,
                         validator:  (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field cannot be empty';
                        }
                        if (!isValidEmail(value)) {
                          return 'Please enter the valid email Id';
                        }
                        return null;
                      }),
                        Gap(25),
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined),
                            Text(
                              "Address",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        TextFieldAddress(hintText: "Street Address", keyboardType: TextInputType.text,
                          controller: line1AddController,context:  context,focunode: _cline1,focunodenext: _cline2, validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '*This field cannot be empty';
                        }
                        return null;
                      }),
                      TextFieldAddress(
                          hintText: "Street Address line 2",
                          keyboardType: TextInputType.text,
                          controller: line2AddController,
                         context:  context,focunode: _cline2,focunodenext: _dropdown,validator:  (value) {
                        if (value == null || value.isEmpty) {
                          return '*This field cannot be empty';
                        }
                        return null;
                      }),
                        Gap(10),
                        DropdownButton(
                          
                          focusNode: _dropdown,
                          
                          hint: Text(
                              'Please choose a location'), // Not necessary for Option 1
                          value: selectedLocation,
                          onChanged: (newValue) {
                            setState(() {
                              selectedLocation = newValue;
                            });
                             FocusScope.of(context).requestFocus(_city);
                          },
                          items: _locations.map((location) {
                            return DropdownMenuItem(
                              child: new Text(location),
                              value: location,
                            );
                          }).toList(),
                        ),
                        TextFieldAddress(hintText: 
                            "City",keyboardType:  TextInputType.text,controller:  cityController,
                            context:  context,focunodenext:_enter ,
                            focunode: _city,
                           validator:  (value) {
                          if (value == null || value.isEmpty) {
                            return '*This field cannot be empty';
                          }
                          return null;
                        }),
                        Gap(25),
                        ElevatedButton(
                          focusNode: _enter,
                          onPressed: () async {
                             FocusScope.of(context).requestFocus();
                            if (_formKey.currentState!.validate()) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddressShowPage()));
                              // addressDetails['Name'] = nameController.text;
                              addressDetails['Company Name'] =
                                  nameController.text;
                              addressDetails['Contact Number'] =
                                  ctctController.text;
                              addressDetails['Email'] = emailController.text;
                              addressDetails['Street Address'] =
                                  line1AddController.text;
                              addressDetails['Street Address line 2'] =
                                  line2AddController.text;
                              addressDetails['City'] = cityController.text;
                              addressDetails['Location'] = selectedLocation;

                              var details = await FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .get();
                              fetchedAddressDetails = details["address"];
                              fetchedAddressDetails
                                  .add(jsonEncode(addressDetails));

                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .update({'address': fetchedAddressDetails});
                            }
                          },
                          child: Text(
                            'ADD ADDRESS',
                            style: GoogleFonts.merriweather(color: Colors.white),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(colorTwo),
                            minimumSize:
                                MaterialStateProperty.all(Size(500, 50)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        }));
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }

  bool isValidPhoneNumber(String phoneNumber) {
    final phoneRegex = RegExp(r'^\d{10}$');
    return phoneRegex.hasMatch(phoneNumber);
  }
}
// String _selectedLocation = 'Please choose a location';

Container TextFieldAddress(
  {required String hintText,
  required TextInputType keyboardType,
  controller,
  required FocusNode focunodenext,
  FocusNode? focunode,
  context,
  String? Function(String?)? validator,}
) {
  return Container(
    child: TextFormField(
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(focunodenext);
      },
      focusNode: focunode,
      controller: controller,
      keyboardType: keyboardType,
      validator: validator, // Add the validator here

      decoration: InputDecoration(
        labelText: hintText,
        labelStyle: TextStyle(
          fontSize: 14,
          color: const Color.fromARGB(255, 54, 98, 98),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 236, 71, 126),
            width: 0.7,
          ),
        ),
      ),
    ),
  );
}
