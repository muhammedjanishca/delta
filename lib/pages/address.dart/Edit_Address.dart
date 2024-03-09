import 'package:firebase_hex/pages/address.dart/sideSheetAddress.dart';
import 'package:firebase_hex/provider/address_provider.dart';
import 'package:flutter/material.dart';
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
  late TextEditingController _nameController;
  late TextEditingController _ctctController;
  late TextEditingController _line1AddController;
  late TextEditingController _line2AddController;
  late TextEditingController _cityController;
  late String? _selectedLocation;

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Address'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: [
              TextFieldAddress(
                  "Company Name", TextInputType.text, _nameController, context,
                  (value) {
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
              ElevatedButton(
                onPressed: _saveAddress, // Call the method to save the address
                child: Text('Save Address'),
              ),

              // DropdownButton and other fields...
            ],
          ),
        ),
      ),
    );
  }
}
