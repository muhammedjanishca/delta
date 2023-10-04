import 'package:flutter/material.dart';


class AddressAddPage extends StatefulWidget {
  @override
  _AddressAddPageState createState() => _AddressAddPageState();
}

class _AddressAddPageState extends State<AddressAddPage> {
  final TextEditingController streetController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();

  void _saveAddress(BuildContext context) {
    String street = streetController.text;
    String city = cityController.text;
    String state = stateController.text;
    String zipCode = zipCodeController.text;

    // Navigate to the SavedPage and pass the address data
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SavedPage(
          street: street,
          city: city,
          state: state,
          zipCode: zipCode,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Address'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: streetController,
              decoration: InputDecoration(labelText: 'Street'),
            ),
            TextField(
              controller: cityController,
              decoration: InputDecoration(labelText: 'City'),
            ),
            TextField(
              controller: stateController,
              decoration: InputDecoration(labelText: 'State'),
            ),
            TextField(
              controller: zipCodeController,
              decoration: InputDecoration(labelText: 'ZIP Code'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _saveAddress(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

class SavedPage extends StatelessWidget {
  final String street;
  final String city;
  final String state;
  final String zipCode;

  SavedPage({
    required this.street,
    required this.city,
    required this.state,
    required this.zipCode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Address'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Street: $street'),
            Text('City: $city'),
            Text('State: $state'),
            Text('ZIP Code: $zipCode'),
          ],
        ),
      ),
    );
  }
}

