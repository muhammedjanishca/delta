
import 'package:flutter/material.dart';

// final _formKey = GlobalKey<FormState>();

Container CustTextField(String hintText, controller, context,String? Function(String?)? validator) {
  return Container(
    width: MediaQuery.of(context).size.width / 4,
    height:40,
    child: TextFormField(
      controller: controller,
      keyboardType: TextInputType.text,
      validator: validator,
      
      style: TextStyle(
        color: Colors.white,
        fontSize: 15,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 2.0,
          ),
        ),
      ),
    ),
  );
}
