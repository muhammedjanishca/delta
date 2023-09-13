// import 'package:firebase_hex/signup_page.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_carousel_slider/carousel_slider.dart';
// import 'package:google_fonts/google_fonts.dart';

// import 'loginpage.dart';

// class Secondpage extends StatelessWidget {
//   Secondpage({super.key});
//   final List<String> images = [
//     'assets/image/Illustration1.png',
//     'assets/image/Illustration2.png',
//     'assets/image/Illustration3.png'
//   ];

//   final List<String> imagecap1 = [
//     'Gain total control \nof your money',
//     'Know where your \nmoney goes',
//     'Planning ahead'
//   ];
//   final List<String> imagecap2 = [
//     'Become your own money manager \nand make every cent count',
//     'Track your transaction easily,\nwith categories and financial report',
//     'Setup your budget for each category \nso you in control'
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           SizedBox(
//             height: 600,
//             child: CarouselSlider.builder(
//               enableAutoSlider: true,
//               autoSliderTransitionCurve: Curves.bounceOut,
//               unlimitedMode: true,
//               itemCount: 3,
//               scrollDirection: Axis.horizontal,
//               slideIndicator: CircularSlideIndicator(
//                 indicatorRadius: 5,
//                 currentIndicatorColor: const Color.fromRGBO(127, 61, 255, 1),
//                 itemSpacing: 20,
//                 alignment: Alignment.bottomCenter,
//                 padding: const EdgeInsets.only(top: 30)
//               ),
//                 slideBuilder: (index) {
//                   return Column(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(top: 76),
//                         child: SizedBox(
//                           height: 312,
//                           width: 312,
//                           child: Image.asset(images[index],
//                           scale: 2,),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 41),
//                         child: Text(
//                           imagecap1[index],
//                           textAlign: TextAlign.center,
//                           style: GoogleFonts.inter(
//                             fontSize: 32,
//                             fontWeight: FontWeight.w700,
//                             color: const Color(0xFF212224)
//                           )
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 17),
//                         child: Text(
//                           imagecap2[index],
//                           textAlign: TextAlign.center,
//                           style: GoogleFonts.inter(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w500,
//                             color: const Color(0xFF90909F)
//                           ),),
//                       )
//                     ],
//                   );
//                 },
//                 ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 50),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(16),
//               child: SizedBox(
//                 width: 350,
//                 height: 56,
//                 child: Expanded(
//                   child: ElevatedButton(
//                       style: const ButtonStyle(
//                         backgroundColor: MaterialStatePropertyAll(
//                             Color.fromRGBO(127, 61, 255, 1)),
//                       ),
//                       onPressed: () {
//                         Navigator.push(context, CupertinoPageRoute(builder: (context)=>SignUpPage()));
//                       },
//                       child: Text(
//                         'Sign Up',
//                         style: GoogleFonts.inter(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.white),
//                       )),
//                 ),
//               ),
//             ),
//           ),
//             const SizedBox(
//             height: 20
//           ),
//           ClipRRect(
//             borderRadius: BorderRadius.circular(16),
//             child: SizedBox(
//               width: 350,
//               height: 56,
//               child: ElevatedButton(
//                   style: const ButtonStyle(
//                       backgroundColor: MaterialStatePropertyAll(
//                           Color.fromRGBO(238, 229, 255, 1))),
//                   onPressed: () {
//                     Navigator.push(context, CupertinoPageRoute(builder: (context)=>LoginPage()));
//                   },
//                   child: Text(
//                     'Login',
//                     style: GoogleFonts.inter(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.purple.shade900),
//                   )),
//             ),
//           ),
//           const SizedBox(
//             height: 10,
//           )
        
//         ],
//       ),
      
//     );
//   }
// }