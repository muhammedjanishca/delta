// import 'package:flutter/material.dart';

// class CustTextField extends StatelessWidget {
//   const CustTextField({super.key});

//   @override
//   Widget build(BuildContext context,TextEditingController controller,) {
//     return Container(
//     width: MediaQuery.of(context).size.width / 5,
//     height: 40,
//     child: TextFormField(
//       controller: controller, // Pass the controller
//       keyboardType: TextInputType.phone,
//       decoration: InputDecoration(
//         hintText: hintText, // Pass the hint text
//         hintStyle: TextStyle(
//           color: Colors.white,fontSize: 15
//         ),
//         border: OutlineInputBorder(
//           borderSide: BorderSide(
//             color: Colors.white,
//             width: 2.0,
//           ),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderSide: BorderSide(
//             color: Colors.white,
//             width: 2.0,
//           ),
//         ),
//       ),
//     ),
//   );
//   }
// }
import 'package:flutter/material.dart';

// final _formKey = GlobalKey<FormState>();

Container CustTextField(String hintText, controller, context) {
  return Container(
    width: MediaQuery.of(context).size.width / 4,
    height: 40,
    child: TextFormField(
      controller: controller,
      keyboardType: TextInputType.phone,
      // validator: (value) {
      //   if (value == null || value.isEmpty) {
      //     return '*Required';
      //   }
      //   return null;
      // },
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
