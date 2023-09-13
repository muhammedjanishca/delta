// import 'package:firebase_hex/login_and_signing/loginpage.dart';
// import 'package:firebase_hex/login_and_signing/signup_page.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_carousel_slider/carousel_slider.dart';
// import 'package:google_fonts/google_fonts.dart';


// class WelcomePage extends StatelessWidget {
//    WelcomePage({super.key});

//   final List<String> sliderImages = [
//     "assets/images/slider1.png",
//     "assets/images/slider2.png",
//     "assets/images/slider3.png",
//   ];

//   final List<String> sliderHeadings = [
//     "Gain total control of your money",
//     "Know where your money goes",
//     "Planning ahead",
//   ];

//   final List<String> sliderDescription = [
//     "Become your own money manager and make every cent count",
//     "Track your transaction easily, with categories and financial report",
//     "Setup your budget for each category so you in control",
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SingleChildScrollView(
//           child: Column(
//               children: [
//           ListView(
//             shrinkWrap: true,
//             children: [
//               Container(
//                 padding: EdgeInsets.only(top: 32),
//                 height: MediaQuery.of(context).size.height / 1.3,
//                 child: CarouselSlider.builder(
//                     enableAutoSlider: true,
//                     unlimitedMode: true,
//                     slideBuilder: (index) {
//                       return Container(
//                           alignment: Alignment.center,
//                           color: Colors.white,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Image.asset(sliderImages[index]),
//                               SizedBox(
//                                 width: MediaQuery.of(context).size.width / 1.2,
//                                 child: Column(
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.only(top: 41),
//                                       child: Text(
//                                         sliderHeadings[index],
//                                         style: GoogleFonts.inter(
//                                             fontSize: 32,
//                                             fontWeight: FontWeight.w700),
//                                         textAlign: TextAlign.center,
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(top: 10),
//                                       child: Text(sliderDescription[index],
//                                           style: GoogleFonts.inter(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.w500,
//                                               color: Colors.grey),
//                                           textAlign: TextAlign.center),
//                                     ),
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ));
//                     },
//                     slideTransform: CubeTransform(),
//                     slideIndicator: CircularSlideIndicator(
//                       currentIndicatorColor: Colors.deepPurple,
//                       indicatorBackgroundColor: Colors.black12,
//                       padding: EdgeInsets.only(bottom: 32),
//                     ),
//                     itemCount: 3),
//               ),
//             ],
//           ),
//           SizedBox(
//             width: MediaQuery.of(context).size.width / 1.1,
//             height: 56,
//             child: TextButton(
//               onPressed: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) =>  SignUpPage(),
//                     ));
//  },
//               child: Text(
//                 "Sign Up",
//                 style: GoogleFonts.inter(
//                   color: Color(0xFFFBFBFB),
//                   fontSize: 18,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               style: ButtonStyle(
//                   shape: MaterialStatePropertyAll(RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16))),
//                   backgroundColor: MaterialStatePropertyAll(Colors.deepPurple)),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top:16),
//             child: SizedBox(
//               width: MediaQuery.of(context).size.width / 1.1,
//               height: 56,
//               child: TextButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) =>  LoginPage(),
//                     ));
//                 },
//                 child: Text(
//                   "Login",
//                   style: GoogleFonts.inter(
//                     color: Colors.deepPurple,
//                     fontSize: 18,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 style: ButtonStyle(
//                     shape: MaterialStatePropertyAll(RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(16))),
//                     backgroundColor: MaterialStatePropertyAll(Color(0xFFEEE5FF))),
//               ),
//             ),
//           )
//               ],
//             ),
//         ));
//   }
// }