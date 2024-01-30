import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../main.dart';
import '../../widgets/bottom_sheet.dart';

class DesktopLanding extends StatefulWidget {
  @override
  State<DesktopLanding> createState() => _DesktopLandingState();
}

class _DesktopLandingState extends State<DesktopLanding> {
  PageController pageController = PageController(viewportFraction: 0.6);

  final FirebaseAuth auth = FirebaseAuth.instance;
  double pageOffSet = 0;
  //button hover
  bool isHovered = false;
  bool iHovered = false;
  //image hover
   bool issHovered = false;
  double offset = 0;

  List<String> imageUrls = [
    // 'assets/image/lugs 4.jpg',
    'assets/image/landing.jpg',
    'assets/image/glands 4.png',
    'assets/image/crimping tools 3.jpg',
    'assets/image/accessories 3.jpg',
    'assets/image/connectors 2.jpg'
  ];
  List<String> textindex = [
    'LUGS',
    'GALNDS',
    'CRIMPING TOOL',
    'ACCESSORIES',
    'CONNECTERS',
  ];

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        pageOffSet = pageController.page!;
      });
      debugPrint(pageOffSet.toString());
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void _navigateToPage(BuildContext context, int index) {
    switch (index) {
      case 0:
        navigateToPage(context, '/Lugs');
        break;
      case 1:
        navigateToPage(context, '/Glands');
        break;
      case 2:
        navigateToPage(context, '/CrimpingTools');
        break;
      case 3:
        navigateToPage(context, '/Accessories');
        break;
      case 4:
        navigateToPage(context, '/Connectors');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // final nameStyle = Theme.of(context).textTheme.displayMedium;
    double screenWidth = MediaQuery.of(context).size.width;

    // final descriptionStyle = Theme.of(context).textTheme.headlineMedium;
    return LayoutBuilder(builder: (context, Constraints) {
      if (Constraints.maxWidth > 850) {
        return Material(
          color: Colors.black,
          child: NotificationListener<ScrollNotification>(
            onNotification: updateOffsetAccordingToScroll,
            child: ScrollConfiguration(
              behavior: NoScrollGlow(),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: -.25 * offset,
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: kHeroImage,
                      // height: height,
                      // width: width,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Positioned(
                    top: -.25 * offset,
                    child: SizedBox(
                      // color: Colors.yellow,
                      height: 600,
                      width: width,
                      child: Align(
                        alignment: const Alignment(0, 0),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 130,
                              ),
                              // Gap(45),
                              Text(
                                "EXPERIENCE THE NEW",
                                style: GoogleFonts.abrilFatface(
                                  textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 35,
                                    shadows: <Shadow>[
                                      // Shadow(
                                      //   offset: Offset(2.0, 2.0),
                                      //   blurRadius: 3.0,
                                      //   color: Colors.grey.withOpacity(0.5),
                                      // )
                                    ],
                                  ),
                                ),
                              ),
                              Text(
                                "DELTA PREMIUM PRODUCTS",
                                style: GoogleFonts.abrilFatface(
                                  textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 35,
                                    shadows: <Shadow>[
                                      // Shadow(
                                      //   offset: Offset(2.0, 2.0),
                                      //   blurRadius: 3.0,
                                      //   color: Colors.grey.withOpacity(0.5),
                                      // )
                                    ],
                                  ),
                                ),
                              ),
                              const Text(
                                "\nTested Products | Efficient Service | Trusted Brand\n",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                height: height / 3.5,
                                width: width / 2,
                                // color: Colors.white,
                                child:
                                    //  AnimatedTextKit(
                                    //               animatedTexts: [
                                    //                 RotateAnimatedText('AWESOME',
                                    //                     textStyle: TextStyle(
                                    //                         fontSize: 30,
                                    //                         color: Colors.white,
                                    //                         backgroundColor: Colors.blue)),
                                    //                 RotateAnimatedText('OPTIMISTIC',
                                    //                     textStyle: TextStyle(
                                    //                         letterSpacing: 3,
                                    //                         fontSize: 30,
                                    //                         fontWeight: FontWeight.bold,
                                    //                         color: Colors.orange)),
                                    //                 RotateAnimatedText(
                                    //                   'DIFFERENT',
                                    //                   textStyle: TextStyle(
                                    //                     fontSize: 30,
                                    //                     decoration: TextDecoration.underline,
                                    //                   ),
                                    //                 ),
                                    //               ],
                                    //               isRepeatingAnimation: true,
                                    //               totalRepeatCount: 10,
                                    //               pause: Duration(milliseconds: 1000),
                                    //             ),
                                    Center(
                                  child: AnimatedTextKit(
                                    totalRepeatCount: 40,
                                    animatedTexts: [
                                      RotateAnimatedText(
                                          'Trans Delta Trading'.toUpperCase(),
                                          textStyle: const TextStyle(
                                              letterSpacing: 3,
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.orange)),
                                      FadeAnimatedText(
                                        'Powering Progress: Your Source for Premium Electrical Solutions',
                                        textStyle: const TextStyle(
                                            // backgroundColor: Colors.green,
                                            color: Color.fromARGB(
                                                255, 243, 149, 35),
                                            fontSize: 25.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      ScaleAnimatedText(
                                        'We are introducing our products',
                                        duration:
                                            const Duration(milliseconds: 4000),
                                        textStyle: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 50.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              //                        InkWell(
                              //   onTap: () {
                              //     // Navigate to the Contact Us page
                              //     Navigator.pushNamed(context, '/Lugs');
                              //   },
                              //   child: Container(
                              //     padding: EdgeInsets.all(16),
                              //     decoration: BoxDecoration(
                              //       color: Colors.blue, // Customize the color
                              //       borderRadius: BorderRadius.circular(8),
                              //     ),
                              //     child: Text(
                              //       "Contact Us",
                              //       style: TextStyle(
                              //         color: Colors.white,
                              //         fontSize: 16,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: height),
                        Container(
                          // height: ,
                          width: width,
                          color: Colors.white,
                          child: Column(
                            children: [
                              const Gap(45),
                              Text(
                                'What are we offering'.toUpperCase(),
                                style: GoogleFonts.quicksand(
                                  color:
                                      const Color.fromARGB(255, 156, 155, 155),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Our Products'.toUpperCase(),
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 4, 4, 4),
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              // sdfg
                              const Gap(35),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  MouseRegion(
                                    onEnter: (_) =>
                                        setState(() => isHovered = true),
                                    onExit: (_) =>
                                        setState(() => isHovered = false),
                                    child: Stack(
                                      children: [
                                        FittedBox(
                                          child: Container(
                                            height: 320,
                                            width: MediaQuery.of(context).size.width /2.8,
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              gradient: LinearGradient(
                                                begin: Alignment.bottomCenter,
                                                end: Alignment.topCenter,
                                                colors: [
                                                  Color.fromARGB(
                                                      255, 192, 191, 191),
                                                  Color.fromARGB(
                                                      255, 215, 215, 214),
                                                  Color.fromARGB(
                                                      255, 240, 239, 239),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        //  if (isHovered)
                                        Positioned(
                                          top: 100,
                                          left: 20,
                                          child: FittedBox(
                                            child: Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Cable Terminal Ends'
                                                        .toUpperCase(),
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromRGBO(
                                                          249, 156, 6, 1.0),
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  const Text(
                                                    "\nHEX is renowned for its superior quality\nof brass cable gland kits in the global market.",
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                  const Gap(15),
                                                  if (isHovered)
                                                    Row(
                                                      children: [
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.pushNamed(
                                                                context,
                                                                '/Connectors');
                                                          },
                                                          style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all(Colors
                                                                        .white),
                                                            minimumSize:
                                                                MaterialStateProperty
                                                                    .all(const Size(
                                                                        120,
                                                                        50)),
                                                          ),
                                                          child: const Text(
                                                            'CONNECTORS',
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        249,
                                                                        156,
                                                                        6,
                                                                        1.0),
                                                                fontSize: 14),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 10),
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.pushNamed(
                                                                context,
                                                                '/Lugs');
                                                          },
                                                          child: const Text(
                                                            'LUGS',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 15),
                                                          ),
                                                          style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all(
                                                              const Color
                                                                      .fromRGBO(
                                                                  249,
                                                                  156,
                                                                  6,
                                                                  1.0),
                                                            ),
                                                            minimumSize:
                                                                MaterialStateProperty
                                                                    .all(const Size(
                                                                        120,
                                                                        50)),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 10,
                                          left: 10,
                                          child: Image.asset(
                                            'assets/image/hex_logo.png',
                                            width: 25,
                                            height: 25,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Container(
                                          child: Positioned(
                                            right: 0,
                                            top: 60,
                                            child: Image.asset(
                                              'assets/image/w-removebg-preview (1).png',
                                              width: 200,
                                              height: 200,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Gap(10),
                                  MouseRegion(
                                    onEnter: (_) =>
                                        setState(() => iHovered = true),
                                    onExit: (_) =>
                                        setState(() => iHovered = false),
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 320,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.8,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            gradient: LinearGradient(
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                              colors: [
                                                Color.fromARGB(
                                                    255, 192, 191, 191),
                                                Color.fromARGB(
                                                    255, 215, 215, 214),
                                                Color.fromARGB(
                                                    255, 240, 239, 239),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 100,
                                          left: 20,
                                          child: FittedBox(
                                            child: Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Brass Cable Gland Kits"
                                                        .toUpperCase(),
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromRGBO(
                                                          249, 156, 6, 1.0),
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  const Text(
                                                    '\nHEX is a manufacturer of high-quality\ncable terminal ends & accessories.',
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                  const Gap(15),
                                                  if (iHovered)
                                                    Row(
                                                      children: [
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.pushNamed(
                                                                context,
                                                                '/Accessories');
                                                          },
                                                          style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all(Color(0xFFFFFFFF)),
                                                            minimumSize:
                                                                MaterialStateProperty
                                                                    .all(const Size(
                                                                        120,
                                                                        50)),
                                                          ),
                                                          child: const Text(
                                                            'ACCESSORIES',
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        249,
                                                                        156,
                                                                        6,
                                                                        1.0),
                                                                fontSize: 14),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 10),
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.pushNamed(
                                                                context,
                                                                '/Glands');
                                                          },
                                                          child: const Text(
                                                            'GLANDS',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 15),
                                                          ),
                                                          style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all(
                                                              const Color
                                                                      .fromRGBO(
                                                                  249,
                                                                  156,
                                                                  6,
                                                                  1.0),
                                                            ),
                                                            minimumSize:
                                                                MaterialStateProperty
                                                                    .all(const Size(
                                                                        120,
                                                                        50)),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 10,
                                          left: 10,
                                          child: Image.asset(
                                            'assets/image/hex_logo.png',
                                            width: 25,
                                            height: 25,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Positioned(
                                          right: 0,
                                          top: 30,
                                          child: Image.asset(
                                            'assets/image/w1-removebg-preview (1).png',
                                            width: 250,
                                            height: 250,
                                            // fit: BoxFit.cover,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  
                                ],
                              ),
                             SizedBox(
                                height: MediaQuery.of(context).size.height/6,
                                width: MediaQuery.of(context).size.width,
                             ),
                              FittedBox(
                                child: Container(
                                  color: const Color.fromARGB(255, 236, 242, 242),
                                  height: MediaQuery.of(context).size.height/1.1,
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    children: [
                                     MouseRegion(
                                      onEnter: (_) =>
                                          setState(() => issHovered = true),
                                      onExit: (_) =>
                                          setState(() => issHovered = false),
                                      
                                        child: Stack(
                                          children:[ 
                                           FittedBox(
                                             child: SizedBox( 
                                             height: MediaQuery.of(context).size.height/1.1,
                                             width:  MediaQuery.of(context).size.width/2,
                                             child: Image.asset('assets/image/glands 4.png',
                                             fit: BoxFit.fill)),
                                           ),
                                           if(issHovered)
                                           FittedBox(
                                             child: SizedBox( 
                                             height: MediaQuery.of(context).size.height/1.1,
                                             width:  MediaQuery.of(context).size.width/2,
                                             child: Image.asset('assets/image/glands 2.png',
                                             fit: BoxFit.fill)),
                                           ),
                                           ]
                                        ),
                                      ),
                                      Container(
                                        child:  Row(
                                          children: [
                                            Gap(75),
                                            Container(
                                              height: MediaQuery.of(context).size.height/3,
                                              width: 10,
                                              color: Colors.yellow,),
                                               Gap(15),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('Where the',
                                                style: GoogleFonts.workSans(fontSize: 45,color: Color.fromARGB(255, 30, 30, 30),fontWeight: FontWeight.w500),),
                                                Text('world of', style: GoogleFonts.workSans(fontSize: 45,color: Color.fromARGB(255, 51, 51, 51),fontWeight: FontWeight.w500),),
                              
                                                Text('construction',style: GoogleFonts.workSans(fontSize: 45,color: const Color.fromARGB(255, 129, 129, 129),fontWeight: FontWeight.w500),),
                              
                                                Text('gets together',style: GoogleFonts.workSans(fontSize: 45,color: const Color.fromARGB(255, 184, 183, 183),fontWeight: FontWeight.w500),),
                              
                                                
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 550,
                                width: double.infinity,
                                // color: Colors.amber,
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Container(
                                            color: Colors.white,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                    'assets/image/hex-logo-new.png'),
                                                const Text(
                                                  "\nRENOWNED MANUFACTURERS OF WORLD\nCLASS ELECTRICAL AND BRASS COMPONENTS",
                                                  style: TextStyle(
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                )
                                              ],
                                            ))),
                                    Expanded(
                                        child: Container(
                                      color: Colors.white,
                                      child: Image.network(
                                        "https://www.lkea.in/assets/images/about/2.jpg",
                                        // width: 170,
                                        // height: 60,
                                        // fit: BoxFit.cover,
                                      ),
                                    ))
                                  ],
                                ),
                              ),
                              Container(
                                  width: double.infinity,
                                  child:
                                      MediaQuery.of(context).size.width >= 700
                                          ? const deskBottomSheett()
                                          : const mobiledeskBottomSheett())
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      } else {
        return Material(
            color: Colors.black,
            child: NotificationListener<ScrollNotification>(
              onNotification: updateOffsetAccordingToScroll,
              child: ScrollConfiguration(
                  behavior: NoScrollGlow(),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                          top: -.25 * offset,
                          child: FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: kHeroImage,
                            fit: BoxFit.fitWidth,
                          )),
                      Positioned(
                        top: -.25 * offset,
                        child: SizedBox(
                          // color: Colors.yellow,
                          height: 600,
                          width: width,
                          child: Align(
                            alignment: const Alignment(0, 0),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.10,
                                  ),
                                  // Gap(45),
                                  Text(
                                    "EXPERIENCE THE NEW DELTA PREMIUM PRODUCTS",
                                    style: GoogleFonts.abrilFatface(
                                      textStyle: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        // shadows: <Shadow>[
                                        // Shadow(
                                        //   offset: Offset(2.0, 2.0),
                                        //   blurRadius: 3.0,
                                        //   color: Colors.grey.withOpacity(0.5),
                                        // )
                                        // ],
                                      ),
                                    ),
                                  ),
                                  // Text(
                                  //   "DELTA PREMIUM PRODUCTS",
                                  //   style: GoogleFonts.abrilFatface(
                                  //     textStyle: const TextStyle(
                                  //       color: Colors.white,
                                  //       fontSize: 25,
                                  //       shadows: <Shadow>[
                                  //         // Shadow(
                                  //         //   offset: Offset(2.0, 2.0),
                                  //         //   blurRadius: 3.0,
                                  //         //   color: Colors.grey.withOpacity(0.5),
                                  //         // )
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
                                  const Text(
                                    "\nTested Products | Efficient Service | Trusted Brand\n",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: height / 3.5,
                                    width: width / 1,
                                    // color: Colors.white,
                                    child:
                                        //  AnimatedTextKit(
                                        //               animatedTexts: [
                                        //                 RotateAnimatedText('AWESOME',
                                        //                     textStyle: TextStyle(
                                        //                         fontSize: 30,
                                        //                         color: Colors.white,
                                        //                         backgroundColor: Colors.blue)),
                                        //                 RotateAnimatedText('OPTIMISTIC',
                                        //                     textStyle: TextStyle(
                                        //                         letterSpacing: 3,
                                        //                         fontSize: 30,
                                        //                         fontWeight: FontWeight.bold,
                                        //                         color: Colors.orange)),
                                        //                 RotateAnimatedText(
                                        //                   'DIFFERENT',
                                        //                   textStyle: TextStyle(
                                        //                     fontSize: 30,
                                        //                     decoration: TextDecoration.underline,
                                        //                   ),
                                        //                 ),
                                        //               ],
                                        //               isRepeatingAnimation: true,
                                        //               totalRepeatCount: 10,
                                        //               pause: Duration(milliseconds: 1000),
                                        //             ),
                                        Center(
                                      child: AnimatedTextKit(
                                        totalRepeatCount: 40,
                                        animatedTexts: [
                                          RotateAnimatedText(
                                              'Trans Delta Trading'
                                                  .toUpperCase(),
                                              textStyle: const TextStyle(
                                                  letterSpacing: 3,
                                                  // fontSize: 30,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.orange)),
                                          FadeAnimatedText(
                                            'Powering Progress: Your Source for Premium Electrical Solutions',
                                            textStyle: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 243, 149, 35),
                                                // fontSize: 25.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          ScaleAnimatedText(
                                            'We are introducing our products',
                                            duration: const Duration(
                                                milliseconds: 4000),
                                            textStyle: const TextStyle(
                                              color: Colors.white,
                                              // fontSize: 50.0
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // const SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: height),
                            Container(
                                width: width,
                                color: Colors.white,
                                child: Column(
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Gap(35),
                                    Text(
                                      'What are we offering'.toUpperCase(),
                                      style: GoogleFonts.quicksand(
                                        color: const Color.fromARGB(
                                            255, 156, 155, 155),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Our Products'.toUpperCase(),
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 4, 4, 4),
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Gap(35),
                                    SizedBox(
                                      height: 450,
                                      child: PageView.builder(
                                        controller: pageController,
                                        itemCount: imageUrls.length,
                                        itemBuilder: (context, index) {
                                          debugPrint(
                                              "{-pageOffSet.abs() + index}");
                                          return GestureDetector(
                                            onTap: () {
                                              _navigateToPage(context, index);
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                              child: Stack(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    child: SizedBox(
                                                      height: 350,
                                                      child: Image.asset(
                                                        imageUrls[index],
                                                        fit: BoxFit.cover,
                                                        alignment: Alignment(
                                                            -pageOffSet.abs() +
                                                                index,
                                                            0),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    bottom: 20,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15),
                                                      child: Text(
                                                        textindex[index],
                                                        style: const TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              137,
                                                              137,
                                                              137),
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                )),
                            Container(
                                color: Colors.white,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Gap(15),
                                    Image.asset(
                                        'assets/image/hex-logo-new.png'),
                                    const Gap(15),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 15),
                                      child: Text(
                                        "RENOWNED MANUFACTURERS OF WORLD CLASS ELECTRICAL AND BRASS COMPONENTS",
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    )
                                    // Text(
                                    //   "\nRENOWNED MANUFACTURERS OF WORLD\nCLASS ELECTRICAL AND BRASS COMPONENTS",
                                    //   style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                                    // )
                                  ],
                                )),
                            Container(
                              width: double.infinity,
                              color: Colors.white,
                              child: Image.network(
                                  "https://www.lkea.in/assets/images/about/2.jpg")),
                            Container(
                                width: double.infinity,
                                child: MediaQuery.of(context).size.width >= 700
                                    ? const deskBottomSheett()
                                    : const mobiledeskBottomSheett())
                          ],
                        ),
                      )
                    ],
                  )),
            ));
      }
    });
  }

  bool updateOffsetAccordingToScroll(ScrollNotification scrollNotification) {
    setState(() => offset = scrollNotification.metrics.pixels);
    return true;
  }
}

Future<bool> checkIfDataExists() async {
  QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
      .instance
      .collection('users')
      .where('address', isNotEqualTo: null)
      .limit(1)
      .get();

  return querySnapshot.docs.isNotEmpty;
}

class NoScrollGlow extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) {
    return child;
  }
}

const kHeroImage = 
    'https://deltabuckets.s3.ap-south-1.amazonaws.com/carousel+images/landing_page+images/landingpage.png';
