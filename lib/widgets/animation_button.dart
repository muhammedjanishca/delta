// import 'dart:convert';
// import 'package:http/http.dart' as http;

// import 'package:flutter/material.dart';

// class GlowingButton extends StatefulWidget {
//   const GlowingButton({Key? key}) : super(key: key);
//   @override
//   GlowingButtonState createState() => GlowingButtonState();
// }

// class GlowingButtonState extends State<GlowingButton> {
//       final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//      final  messageController = TextEditingController();
//     final companyNameController = TextEditingController();
//     final nameController = TextEditingController();
//     final emailController = TextEditingController();
//     final phoneNumberController = TextEditingController();
//     Future<void> sendEmail(String name, String email, String company,
//  String phone, String message) async {
//       final apiUrl = 'https://api.emailjs.com/api/v1.0/email/send';

//       // Replace these values with your actual service, template, and user IDs
//       final serviceId = 'service_54jno8o';
//       final templateId = 'template_leg6o7l';
//       final userId = 'pyy8mA7J7LWSzgAMF';

//       final data = {
//         'service_id': serviceId,
//         'template_id': templateId,
//         'user_id': userId,
//         'template_params': {
//           'name': name,
//           'email': email,
//           'company': company,
//           'phone': phone,
//           'message': message,
//         },
//       };

//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode(data),
//       );

//       if (response.statusCode == 200) {
//         // Email sent successfully
//         print(name);
//         print(email);
//         print(company);
//         print(phone);
//         print(message);
//         print('Your mail is sent!');
//       } else {
//         print('Oops... ${response.body}');
//       }
//     }


//   var glowing = true;
//   var scale = 1.0;
  
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         if (_formKey.currentState!.validate()) {
//                                 // All text fields are valid, you can perform your action here
//                                 sendEmail(
//                                     nameController.text,
//                                     emailController.text,
//                                     companyNameController.text,
//                                     phoneNumberController.text,
//                                     messageController.text);
//                               }
//       },
//       onTapUp: (val) {
//         setState(() {
//           glowing = false;
//           scale = 1.0;
//         });
//       },
//       onHover: (val) {
//         setState(() {
//           glowing = false;
//           scale = 1.0;
//         });
//       },
//       onTapDown: (val) {
//         setState(() {
//           glowing = true;
//           scale = 1.1;
//         });
//       },
//       child: AnimatedContainer(
//         transform: Matrix4.identity()..scale(scale),
//         duration: const Duration(milliseconds: 200),
//         height: 48,
//         width: 160,
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(40),
//             gradient: LinearGradient(
//               colors: [
//                 Colors.black,
//                 Colors.amber
//                 // AppColors.kPrimary,
//                 // AppColors.kBlack,
//               ],
//             ),
//             boxShadow: glowing
//                 ? [
//                     BoxShadow(
//                       color: Colors.black,
//                       spreadRadius: 1,
//                       blurRadius: 16,
//                       offset: const Offset(-8, 0),
//                     ),
//                     BoxShadow(
//                       color: Colors.black,
//                       spreadRadius: 1,
//                       blurRadius: 16,
//                       offset: const Offset(8, 0),
//                     ),
//                     BoxShadow(
//                       color: Colors.black,
//                       spreadRadius: 16,
//                       blurRadius: 32,
//                       offset: const Offset(-8, 0),
//                     ),
//                     BoxShadow(
//                       color: Colors.black,
//                       spreadRadius: 16,
//                       blurRadius: 32,
//                       offset: const Offset(8, 0),
//                     )
//                   ]
//                 : []),
//         child: Text(
//           glowing ? "Glowing" : "Dimmed",
//           style: const TextStyle(
//               color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
//         ),
//       ),
//     );
//   }
// }
