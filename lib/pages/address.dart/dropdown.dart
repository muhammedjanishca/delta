import 'package:flutter/material.dart';

class DropDownPage extends StatefulWidget {
  const DropDownPage({Key? key}) : super(key: key);

  @override
  _DropDownPageState createState() => _DropDownPageState();
}

class _DropDownPageState extends State<DropDownPage> {
  // Initial Selected Value
  String dropdownvalue = 'Select the Emirates of the Provinces of Saudi Arabia';

  // List of items in our dropdown menu
  var items = [
  'Select the Emirates of the Provinces of Saudi Arabia',
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
  ];
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      // Initial Value
      value: dropdownvalue,
      // Down Arrow Icon
      icon: const Icon(Icons.keyboard_arrow_down),

      // Array list of items
      items: items.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(items),
        );  
      }).toList(),
      // After selecting the desired option,it will
      // change button value to selected value
      onChanged: (String? newValue) {
        setState(() {
          dropdownvalue = newValue!;
        });
      },
    );
  }
}
