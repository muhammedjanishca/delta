import 'package:firebase_hex/pages/address.dart/sideSheetAddress.dart';
import 'package:firebase_hex/pages/another_pages/IRSH.dart';
import 'package:firebase_hex/provider/address_provider.dart';
import 'package:firebase_hex/widgets/style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class EditAddressdesk extends StatefulWidget {
  final Map<String, dynamic> addressData;
  final int index;
  const EditAddressdesk({Key? key, required this.addressData, required this.index})
      : super(key: key);

  @override
  _EditAddressState createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddressdesk> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _nameController;
  late TextEditingController _ctctController;
  late TextEditingController _line1AddController;
  late TextEditingController _line2AddController;
  late TextEditingController _cityController;

  //focusnode
  final FocusNode _dropdown = FocusNode();
  final FocusNode _ccntact = FocusNode();
  final FocusNode _cemail = FocusNode();
  final FocusNode _cline1 = FocusNode();
  final FocusNode _cline2 = FocusNode();
  final FocusNode _city = FocusNode();
  final FocusNode _enter = FocusNode();
  late String?
      _selectedLocation; // Changed from TextEditingController to String
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

  Future<void> _saveAddress() async {
    Map<String, dynamic> updatedAddress = {
      'Company Name': _nameController.text,
      'Contact Number': _ctctController.text,
      'Email':_emailController.text,
      'Street Address': _line1AddController.text,
      'Street Address line 2': _line2AddController.text,
      'City': _cityController.text,
      'Location': _selectedLocation,
    };

    await Provider.of<AddressProvider>(context, listen: false)
        .updateAddress(widget.index, updatedAddress);

    Navigator.pop(context); // Close the EditAddress screen after saving
  }

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.addressData['Email']);

    _nameController =
        TextEditingController(text: widget.addressData['Company Name']);
    _ctctController =
        TextEditingController(text: widget.addressData['Contact Number']);
    _line1AddController =
        TextEditingController(text: widget.addressData['Street Address']);
    _line2AddController = TextEditingController(
        text: widget.addressData['Street Address line 2']);
    _cityController = TextEditingController(text: widget.addressData['City']);
    _selectedLocation = widget.addressData['Location'];
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _ctctController.dispose();
    _line1AddController.dispose();
    _line2AddController.dispose();
    _cityController.dispose();
    // _selectedLocation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: custSmallAppBar(context, Colors.white),
      body: Center(
        child: Form(
          key: _formKey,
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(40),
                  const SizedBox(
                      height: 40,
                      child: Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Text("ADD ADDRESS"),
                      )),
                  Divider(),
                  Gap(10),
                  const Row(
                    children: [
                      Icon(Icons.phone),
                      Text(
                        "Contact Details",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  TextFieldAddress(hintText: "Company Name", keyboardType: TextInputType.text,
                     controller:  _nameController, context: context,
                     focunodenext:_ccntact ,focunode:FocusNode() ,validator:  (value) {
                    if (value == null || value.isEmpty) {
                      return '*This field cannot be empty';
                    }
                    return null;
                  }),
                  TextFieldAddress(hintText: "Contact Number",keyboardType:  TextInputType.phone,
                      controller: _ctctController,context:  context,focunodenext: _cemail,focunode: _ccntact,validator:  (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field cannot be empty';
                    }
                    if (!isValidPhoneNumber(value)) {
                      return 'Please enter the valid phone number';
                    }
                    return null;
                  }),
                  TextFieldAddress(
                      hintText: "Email",focunodenext: _cline1,focunode: _cemail,keyboardType:  TextInputType.text,controller:  _emailController, context:  context,
                      validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field cannot be empty';
                    }
                    if (!isValidEmail(value)) {
                      return 'Please enter the valid email Id';
                    }
                    return null;
                  }),
                  TextFieldAddress(hintText: "Street Address",keyboardType:  TextInputType.text,
                     controller:   _line1AddController,context:  context, focunodenext: _cline2,focunode: _cline1,validator:  (value) {
                    if (value == null || value.isEmpty) {
                      return '*This field cannot be empty';
                    }
                    return null;
                  }),
                  TextFieldAddress(hintText: "Street Address line 2",
                  keyboardType:  TextInputType.text,
                      controller: _line2AddController,context:  context,
                        focunodenext: _dropdown,focunode: _cline2,validator:  (value) {
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
                    value: _selectedLocation,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedLocation = newValue;
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
                  Gap(10),
                  TextFieldAddress(
                      hintText: "City", keyboardType:  TextInputType.text,
                      focunode: _city,focunodenext: _enter,
                      controller:  _cityController,context:  context,
                    validator:   (value) {
                    if (value == null || value.isEmpty) {
                      return '*This field cannot be empty';
                    }
                    return null;
                  }),

                  ElevatedButton(
                    focusNode: _enter,
                    onPressed:
                    
                        _saveAddress, // Call the method to save the address
                    child: Text(
                      'Save Address',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(colorTwo),
                      minimumSize: MaterialStateProperty.all(Size(1500, 50)),
                    ),
                  ),

                  // DropdownButton and other fields...
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
