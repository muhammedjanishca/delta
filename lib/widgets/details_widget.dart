import 'package:flutter/material.dart';

Widget backButton(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.pop(context);
    },
    child: Container(
      padding: EdgeInsets.all(8.0),
      child: Icon(Icons.arrow_back),
    ),
  );
}