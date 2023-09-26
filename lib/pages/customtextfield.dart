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

Container CustTextField(String hintText, TextEditingController controller, context) {
  return Container(
    width: MediaQuery.of(context).size.width / 4,
    height: 40,
    child: TextFormField(
      controller: controller, // Pass the controller
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        hintText: hintText, // Pass the hint text
        hintStyle: TextStyle(
          color: Colors.white,fontSize: 15
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
