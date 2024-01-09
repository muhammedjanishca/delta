import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_hex/main.dart';
import 'package:firebase_hex/pages/another_pages/contact_us.dart';
import 'package:firebase_hex/widgets/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transparent_image/transparent_image.dart';

class DesktopLanding extends StatefulWidget {
  @override
  State<DesktopLanding> createState() => _DesktopLandingState();
}

class _DesktopLandingState extends State<DesktopLanding> {
  PageController pageController = PageController(viewportFraction: 0.6);

  final FirebaseAuth auth = FirebaseAuth.instance;
  double pageOffSet = 0;
  bool isHovered = false;
  bool iHovered = false;
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
    final nameStyle = Theme.of(context).textTheme.displayMedium;
    final descriptionStyle = Theme.of(context).textTheme.headlineMedium;
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
                      height: height,
                      width: width,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Positioned(
                    top: -.25 * offset,
                    child: SizedBox(
                      height: 600,
                      width: width,
                      child: Align(
                        alignment: Alignment(0, 0),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 130,),
                              // Gap(45),
                              Text(
                                "EXPERIENCE THE NEW",
                                style: GoogleFonts.abrilFatface(
                                  textStyle: TextStyle(
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
                                  textStyle: TextStyle(
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
                                "\nTested Products | Efficient Service | Trusted Brand\n",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            Container(
                              height: height/3.5,
                              width: width/2,
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
                    
                      RotateAnimatedText('Trans Delta Trading'.toUpperCase(), 
                                                  textStyle: TextStyle( 
                                                      letterSpacing: 3, 
                                                      fontSize: 30, 
                                                      fontWeight: FontWeight.bold, 
                                                      color: Colors.orange)), 
                    FadeAnimatedText( 
                      'Powering Progress: Your Source for Premium Electrical Solutions', 
                      textStyle: const TextStyle( 
                          // backgroundColor: Colors.green, 
                          color: Color.fromARGB(255, 243, 149, 35), 
                          fontSize: 25.0, 
                          fontWeight: FontWeight.bold), 
                    ), 
                    ScaleAnimatedText( 
                      'We are introducing our products', 
                      duration: Duration(milliseconds: 4000), 
                      textStyle: 
                          const TextStyle(color: Colors.white, fontSize: 50.0), 
                    ), 
                  ], 
                ), 
              ),
                            ),
                              SizedBox(
                                  height:
                                      20),
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
                              Gap(45),
                              Text(
                                'What are we offering'.toUpperCase(),
                                style: GoogleFonts.quicksand(
                                  color: Color.fromARGB(255, 156, 155, 155),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Our Products'.toUpperCase(),
                                style: TextStyle(
                                  color: Color.fromARGB(255, 4, 4, 4),
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
              
              
              
                              // sdfg
                              Gap(35),
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
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.8,
                                            decoration: BoxDecoration(
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
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromRGBO(
                                                          249, 156, 6, 1.0),
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  Text(
                                                    "\nHEX is renowned for its superior quality\nof brass cable gland kits in the global market.",
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                  Gap(15),
                                                  if (isHovered)
                                                    Row(
                                                      children: [
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.pushNamed(
                                                                context,
                                                                '/Connectors');
                                                          },
                                                          child: Text(
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
                                                          style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all(Colors
                                                                        .white),
                                                            minimumSize:
                                                                MaterialStateProperty
                                                                    .all(Size(
                                                                        120,
                                                                        50)),
                                                          ),
                                                        ),
                                                        SizedBox(width: 10),
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.pushNamed(
                                                                context,
                                                                '/Lugs');
                                                          },
                                                          child: Text(
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
                                                              Color.fromRGBO(
                                                                  249,
                                                                  156,
                                                                  6,
                                                                  1.0),
                                                            ),
                                                            minimumSize:
                                                                MaterialStateProperty
                                                                    .all(Size(
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
                                  Gap(10),
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
                                          decoration: BoxDecoration(
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
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromRGBO(
                                                          249, 156, 6, 1.0),
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  Text(
                                                    '\nHEX is a manufacturer of high-quality\ncable terminal ends & accessories.',
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                  Gap(15),
                                                  if (iHovered)
                                                    Row(
                                                      children: [
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.pushNamed(
                                                                context,
                                                                '/Accessories');
                                                          },
                                                          child: Text(
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
                                                          style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all(Colors
                                                                        .white),
                                                            minimumSize:
                                                                MaterialStateProperty
                                                                    .all(Size(
                                                                        120,
                                                                        50)),
                                                          ),
                                                        ),
                                                        SizedBox(width: 10),
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.pushNamed(
                                                                context,
                                                                '/Glands');
                                                          },
                                                          child: Text(
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
                                                              Color.fromRGBO(
                                                                  249,
                                                                  156,
                                                                  6,
                                                                  1.0),
                                                            ),
                                                            minimumSize:
                                                                MaterialStateProperty
                                                                    .all(Size(
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
                              Container(
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
                                                Text(
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
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  height:
                                      MediaQuery.of(context).size.height / 1.5,
                                  child:
                                      MediaQuery.of(context).size.width >= 700
                                          ? deskBottomSheett()
                                          : mobiledeskBottomSheett())
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
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: Image.network(
                      'https://knowhow.distrelec.com/wp-content/uploads/2021/11/iStock-1477511739.jpg',
                      // 'https://i0.wp.com/www.compliancesigns.com/blog/wp-content/uploads/2023/05/5-Electrical-Safety-Tips.jpg?fit=1200%2C630&ssl=1',
                      // 'https://electrek.co/wp-content/uploads/sites/3/2021/05/bird-three-header-scooter.jpg?quality=82&strip=all',
                      width: 200,
                      height: 200,
                      // color: Colors.amber,
                      fit: BoxFit.cover,
                    ),
                  ),
                  BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0.0),

                      // blur(sigmaX:.0,sigmaY:0.0),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 45, top: 45),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "EXPERIENCE THE NEW\nDELTA PREMIUM PRODUCTS",
                              style: GoogleFonts.abrilFatface(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    // color: Color.fromARGB(255, 54, 98, 98),
                                    fontSize: 35,
                                    shadows: <Shadow>[
                                      Shadow(
                                        offset: Offset(2.0, 2.0),
                                        blurRadius: 3.0,
                                        color: const Color.fromARGB(
                                                255, 13, 13, 13)
                                            .withOpacity(0.5),
                                      )
                                    ]),
                              ),
                            ),
                            Text(
                              "\nTested Products || Efficient Service || Trusted Brand\n",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ContactUsPage()),
                                    );
                                  },
                                  child: FittedBox(
                                    child: Container(
                                      child: Center(
                                          child: Text(
                                        "ABOUT US",
                                        style: GoogleFonts.firaSans(
                                            fontWeight: FontWeight.w600),
                                      )),
                                      width:
                                          MediaQuery.of(context).size.width / 5,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              18,
                                      decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            249, 156, 6, 1.0),
                                        // borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.white,
                                              offset: Offset(8, 8),
                                              blurRadius: 1),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Gap(15),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ContactUsPage()),
                                    );
                                  },
                                  child: FittedBox(
                                    child: Container(
                                      child: Center(
                                          child: Text(
                                        "CONTACT US",
                                        style: GoogleFonts.firaSans(
                                            fontWeight: FontWeight.w500,
                                            color: Color.fromRGBO(
                                                249, 156, 6, 1.0)),
                                      )),
                                      width:
                                          MediaQuery.of(context).size.width / 5,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              18,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        // borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color.fromRGBO(
                                                  249, 156, 6, 1.0),
                                              // blurRadius: 4,
                                              offset: Offset(8, 8),
                                              blurRadius: 1),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // ElevatedButton(
                            //   onPressed: () {
                            //     Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (context) => const Card()),
                            //     );
                            //   },
                            //   child: Text(
                            //     'CHECKOUT',
                            //     style: TextStyle(color: Colors.white),
                            //   ),
                            //   style: ButtonStyle(
                            //     backgroundColor: MaterialStateProperty.all(
                            //         const Color.fromARGB(255, 54, 98, 98)),
                            //     minimumSize: MaterialStateProperty.all(Size(150, 50)),
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 320,
                            // ),
                            // SizedBox(
                            //   height: 280,
                            // ),
                          ],
                        ),
                      )),
                ],
              ),
              Container(
                width: double.infinity,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Industrial Cable Management System for your Electrical Projects!',
                          style: GoogleFonts.abel(
                              textStyle: const TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold)),
                        ),
                        Gap(10),
                        Text(
                          '     Delta Cable Management Systems are designed to efficiently organize and secure electrical and electronic cables in various settings, be it a facility, residence, or office. Industrial cable wholesale sellers in Saudi Arabia prioritize crafting cables that promote tidy workspaces, minimize trip hazards, prevent short circuits, and ultimately elevate electrical safety and functionality within your environment',
                          style: GoogleFonts.abel(
                              fontSize: 20, fontWeight: FontWeight.w300),
                        ),
                      ]),
                ),
              ),
              Gap(20),
              Container(
                  width: double.infinity,
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'What are we offering'.toUpperCase(),
                        style: GoogleFonts.quicksand(
                          color: Color.fromARGB(255, 156, 155, 155),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Our Products'.toUpperCase(),
                        style: TextStyle(
                          color: Color.fromARGB(255, 4, 4, 4),
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  )),
              Gap(10),
              Container(
                height: 450,
                child: PageView.builder(
                  controller: pageController,
                  itemCount: imageUrls.length,
                  itemBuilder: (context, index) {
                    debugPrint("{-pageOffSet.abs() + index}");
                    return GestureDetector(
                      onTap: () {
                        _navigateToPage(context, index);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: SizedBox(
                                height: 350,
                                child: Image.asset(
                                  imageUrls[index],
                                  fit: BoxFit.cover,
                                  alignment:
                                      Alignment(-pageOffSet.abs() + index, 0),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 20,
                              child: Padding(
                                padding: EdgeInsets.all(15),
                                child: Text(
                                  textindex[index],
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 137, 137, 137),
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
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
              Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Gap(15),
                      Image.asset('assets/image/hex-logo-new.png'),
                      Gap(15),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          "RENOWNED MANUFACTURERS OF WORLD CLASS ELECTRICAL AND BRASS COMPONENTS",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w700),
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
                    "https://www.lkea.in/assets/images/about/2.jpg"),
              ),
              Container(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  height: 1000,
                  // height: MediaQuery.of(context).size.height/1,
                  child: MediaQuery.of(context).size.width >= 700
                      ? deskBottomSheett()
                      : mobiledeskBottomSheett())
            ],
          ),
        );
      }
    });
  }

  bool updateOffsetAccordingToScroll(ScrollNotification scrollNotification) {
    setState(() => offset = scrollNotification.metrics.pixels);
    return true;
  }
}

Future<bool> checkIfDataExists() async {
  // Replace 'users' with your actual collection name
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

const kHeroImage = 'assets/image/landingpage.png';

List imagepath = [
  'assets/image/brass-cable-glands-1.jpg',
  'assets/image/cable-terminal-ends-1.png',
  'assets/image/crimping-tools.png',
];
final List<String> headingss = [
  '\nCable Terminal Ends',
  '\nBrass Cable Gland Kits',
  '\nCrimping Tools'
];
final List<String> descriptionn = [
  '\nHEX is a manufacturer ofhigh-quality\ncable terminalends & accessories.',
  '\nHEX is renowned for its superiorquality\nof brass cable gland kitsin the global market.',
  '\nHEX provides a wide range ofcrimping\ntools for use with otherproducts.'
];
