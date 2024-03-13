import 'package:firebase_hex/pages/address.dart/sideSheetAddress.dart';
import 'package:firebase_hex/pages/another_pages/IRSH.dart';
import 'package:firebase_hex/provider/address_provider.dart';
import 'package:firebase_hex/widgets/style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class EditAddress extends StatefulWidget {
  final Map<String, dynamic> addressData;
  final int index;
  const EditAddress({Key? key, required this.addressData, required this.index})
      : super(key: key);

  @override
  _EditAddressState createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _ctctController;
  late TextEditingController _line1AddController;
  late TextEditingController _line2AddController;
  late TextEditingController _cityController;
  late String? _selectedLocation; // Changed from TextEditingController to String
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
                            child: Text("ADD ADDRESS"),
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
                  TextFieldAddress("Company Name", TextInputType.text,
                      _nameController, context, (value) {
                    if (value == null || value.isEmpty) {
                      return '*This field cannot be empty';
                    }
                    return null;
                  }),
                  TextFieldAddress("Contact Number", TextInputType.phone,
                      _ctctController, context, (value) {
                    if (value == null || value.isEmpty) {
                      return '*This field cannot be empty';
                    }
                    return null;
                  }),
                  TextFieldAddress("Street Address", TextInputType.text,
                      _line1AddController, context, (value) {
                    if (value == null || value.isEmpty) {
                      return '*This field cannot be empty';
                    }
                    return null;
                  }),
                  TextFieldAddress("Street Address line 2", TextInputType.text,
                      _line2AddController, context, (value) {
                    if (value == null || value.isEmpty) {
                      return '*This field cannot be empty';
                    }
                    return null;
                  }),
                    Gap(10),
                     DropdownButton(
                        hint: Text(
                            'Please choose a location'), // Not necessary for Option 1
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
                        }).toList(),
                      ),
                      Gap(10),
                       TextFieldAddress("City", TextInputType.text,
                     _cityController, context, (value) {
                    if (value == null || value.isEmpty) {
                      return '*This field cannot be empty';
                    }
                    return null;
                  }),

                  ElevatedButton(
                    onPressed:
                        _saveAddress, // Call the method to save the address
                     child: Text(
                          'Save Address',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            colorTwo
                          ),
                          minimumSize:
                              MaterialStateProperty.all(Size(1500, 50)),
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
}
