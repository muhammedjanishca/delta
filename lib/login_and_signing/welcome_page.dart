// import 'package:firebase_hex/login_and_signing/loginpage.dart';
// import 'package:firebase_hex/login_and_signing/signup_page.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_carousel_slider/carousel_slider.dart';
// import 'package:google_fonts/google_fonts.dart';

// class WelcomePage extends StatelessWidget {
//   WelcomePage({super.key});

//   final List<String> sliderImages = [
//     'assets/image/Illustration1.png',
//     'assets/image/Illustration2.png',
//     'assets/image/Illustration3.png',
//   ];

//   final List<String> sliderHeadings = [
//     'Gain total control \nof your money',
//     'Know where your \nmoney goes',
//     'Planning ahead'
//   ];
//   final List<String> sliderDescription = [
//     'Become your own money manager \nand make every cent count',
//     'Track your transaction easily,\nwith categories and financial report',
//     'Setup your budget for each category \nso you in control'
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SingleChildScrollView(
//       child: Row(
//         children: [
//           Expanded(
//             flex: 3,
//             child: Container(
//               height: 750,
//               width: 300,
//               child: CarouselSlider.builder(
//                   enableAutoSlider: true,
//                   unlimitedMode: true,
//                   slideBuilder: (index) {
//                     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Image.asset(sliderImages[index],height: 500,),
//                         // SizedBox(
//                           // width: MediaQuery.of(context).size.width / 1.2,
//                            Column(
//                             children: [
//                               Text(
//                                 sliderHeadings[index],
//                                 style: GoogleFonts.inter(
//                                     fontSize: 32,
//                                     fontWeight: FontWeight.w700),
//                                 textAlign: TextAlign.center,
//                               ),
//                               Text(sliderDescription[index],
//                                   style: GoogleFonts.inter(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w500,
//                                       color: Colors.grey),
//                                   textAlign: TextAlign.center),
//                             ],
//                           ),
//                         // )
//                       ],
//                     );
//                   },
//                   slideTransform: CubeTransform(),
//                   slideIndicator: CircularSlideIndicator(
//                     currentIndicatorColor: Colors.deepPurple,
//                     indicatorBackgroundColor: Colors.black12,
//                     padding: EdgeInsets.only(bottom: 32),
//                   ),
//                   itemCount: 3),
//             ),
//           ),
          
//           Expanded(
//             flex: 2,
//             child: Column(
//             children: [
//                ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => SignUpPage()));
//                         },
//                         child:  Text(
//                 "Sign Up",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         style: ButtonStyle(
//                           backgroundColor:
//                               MaterialStateProperty.all(Colors.black),
//                           minimumSize: MaterialStateProperty.all(Size(150, 50)),
//                         ),
//                       ),
//                ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => LoginPage()));
//                         },
//                         child:  Text(
//                 "Login",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         style: ButtonStyle(
//                           backgroundColor:
//                               MaterialStateProperty.all(Colors.black),
//                           minimumSize: MaterialStateProperty.all(Size(150, 50)),
//                         ),
//                       ),
             
//             ],
//           ))
//         ],
//       ),
//     ));
//   }
// }

