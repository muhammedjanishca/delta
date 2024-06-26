import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_hex/widgets/style.dart';
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
    'https://deltabuckets.s3.ap-south-1.amazonaws.com/carousel+images/landing+page+scroll+images/landing+page+scroll+pictures/canva+1+(1).png',
    'https://deltabuckets.s3.ap-south-1.amazonaws.com/carousel+images/landing+page+scroll+images/landing+page+scroll+pictures/canva+1+(5).png',
    'https://deltabuckets.s3.ap-south-1.amazonaws.com/carousel+images/landing+page+scroll+images/landing+page+scroll+pictures/canva+1+(7).png',
    'https://deltabuckets.s3.ap-south-1.amazonaws.com/carousel+images/landing+page+scroll+images/landing+page+scroll+pictures/canva+1+(2).png',
    'https://deltabuckets.s3.ap-south-1.amazonaws.com/carousel+images/landing+page+scroll+images/landing+page+scroll+pictures/canva+1+(6).png',
    'https://deltabuckets.s3.ap-south-1.amazonaws.com/carousel+images/landing+page+scroll+images/landing+page+scroll+pictures/canva+1+(4).png',
    'https://deltabuckets.s3.ap-south-1.amazonaws.com/carousel+images/landing+page+scroll+images/landing+page+scroll+pictures/canva+1+(8).png',
    
  ];
  List<String> textindex = [
    'PVC Coated Galvanised Flexible Conduit',
    'Hose clamps',
    'Double plate "u" clamp',
    'Crimping tool',
    'Roller ball type stainless steel cable ties',
    'Insulated bus bar system for mcb',
    'Copper Bonded Grounding Rods',
  ];
  List<String> descriptionCarosal = [
    'Cable Support Systems\n',
    'Cable Jointing & Termination\nKit Components',
    'Earthing & lightning protection\naccessories',
    'View more crimping tools\n',
    'Stainless steel cable\nties & markers',
    'Switch Board Control\nPanel Accessories',
    'Earthing & Lightning\nProtection',
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
        navigateToPage(context, '/cable-support-systems/');
        break;
      case 1:
        navigateToPage(context, '/cable-jointing-and-termination-kit-components/');
        break;
      case 2:
        navigateToPage(context, '/earthing-lightning-protection-systems/earthing-lightning-protection-accessories/');
        break;
      case 3:
        navigateToPage(context, '/crimping-tools/');
        break;
      case 4:
        navigateToPage(context, '/Stainless Steel Cable Ties & Markers');
        break;
      case 5:
      navigateToPage(context, '/switch-board-control-panel-accessories/');
        break;  
        case 5:
      navigateToPage(context, '/earthing-lightning-protection-systems/earthing-lightning-protection/');
        break;  
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    
    return LayoutBuilder(builder: (context, Constraints) {
      if (Constraints.maxWidth > 850) {
        return Container(
           decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [colorOne,colorTwo], // Define your gradient colors here
      ),
    ),
          child: Material(
            color: Colors.transparent,
            child: NotificationListener<ScrollNotification>(
              onNotification: updateOffsetAccordingToScroll,
              child: ScrollConfiguration(
                behavior: NoScrollGlow(),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: -.25 * offset,
                      child: FittedBox(
                        child: Container(
                          child: FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: kHeroImage,
                            // height: height,
                            width: width,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    // Positioned(
                    //   top: -.25 * offset,
                    //   child: SizedBox(
                    //     // color: Colors.yellow,
                    //     height: 600,
                    //     width: width,
                    //     child: Align(
                    //       alignment: const Alignment(0, 0),
                    //       child: Padding(
                    //         padding: const EdgeInsets.symmetric(horizontal: 40),
                    //         child: Column(
                    //           mainAxisAlignment: MainAxisAlignment.start,
                    //           crossAxisAlignment: CrossAxisAlignment.center,
                    //           children: [
                    //             const SizedBox(
                    //               height: 130,
                    //             ),
                    //             // Gap(45),
                    //             Text(
                    //               "Experience the new",
                    //               // "EXPERIENCE THE NEW",
                    //               style: GoogleFonts.poppins(
                    //                 textStyle: const TextStyle(
                    //                   color: Colors.white,
                    //                   fontSize: 35,
                    //                    fontWeight: FontWeight.bold,
                    //                 ),
                    //               ),
                    //             ),
                    //             Text(
                    //               // "DELTA PREMIUM PRODUCTS",
                    //               "Delta premium products",
                    //               style: GoogleFonts.poppins(
                    //                 textStyle: const TextStyle(
                    //                   color: Colors.white,
                    //                   fontSize: 35,
                    //                   fontWeight: FontWeight.bold,
                    //                 ),
                    //               ),
                    //             ),
                    //              Text(
                    //               "\nTested Products | Efficient Service | Trusted Brand",
                    //               style: GoogleFonts.poppins(
                    //                 fontSize: 20,
                    //                 fontWeight: FontWeight.w400,
                    //                 color: Colors.white,
                    //               ),
                    //             ),
                    //             // Container(
                    //             //   color: Colors.amber,
                    //             //   height: height / 3.5,
                    //             //   width: width / 2,
                    //             //   // color: Colors.white,
                    //             //   child:
                    //             //       Center(
                    //             //     child: AnimatedTextKit(
                    //             //       totalRepeatCount: 40,
                    //             //       animatedTexts: [
                    //             //         RotateAnimatedText(
                    //             //             'Trans Delta Trading'.toUpperCase(),
                    //             //             textStyle: const TextStyle(
                    //             //                 letterSpacing: 3,
                    //             //                 fontSize: 30,
                    //             //                 fontWeight: FontWeight.bold,
                    //             //                 color: Colors.orange)),
                    //             //         FadeAnimatedText(
                    //             //           'Powering Progress: Your Source for Premium Electrical Solutions',
                    //             //           textStyle: const TextStyle(
                    //             //               // backgroundColor: Colors.green,
                    //             //               color: Color.fromARGB(
                    //             //                   255, 243, 149, 35),
                    //             //               fontSize: 25.0,
                    //             //               fontWeight: FontWeight.bold),
                    //             //         ),
                    //             //         ScaleAnimatedText(
                    //             //           'We are introducing our products',
                    //             //           duration:
                    //             //               const Duration(milliseconds: 4000),
                    //             //           textStyle: const TextStyle(
                    //             //               color: Colors.white,
                    //             //               fontSize: 50.0),
                    //             //         ),
                    //             //       ],
                    //             //     ),
                    //             //   ),
                    //             // ),
                    //             const SizedBox(height: 20),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
        
                    SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Container(
                            color: Colors.transparent,
                            height: height,
                            child: Column(
                              children: [
                                SizedBox(
                                  // color: Colors.amber,
                                  height:
                                      MediaQuery.of(context).size.height / 9.7,
                                ),
                                // Row(
                                //   // crossAxisAlignment: CrossAxisAlignment.center,
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   children: [
                                //     Text(
                                //       "Experience ",
                                //       // "EXPERIENCE THE NEW",
                                //       style: GoogleFonts.poppins(
                                //         textStyle: const TextStyle(
                                //           color: Colors.white,
                                //           fontSize: 45,
                                //           fontWeight: FontWeight.bold,
                                //         ),
                                //       ),
                                //     ),
                                //     Text(
                                //       "The New",
                                //       // "EXPERIENCE THE NEW",
                                //       style: GoogleFonts.poppins(
                                //         textStyle: const TextStyle(
                                //           color: Colors.white,
                                //           fontSize: 45,
                                //           // fontWeight: FontWeight.bold,
                                //         ),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   children: [
                                //     Text(
                                //       // "DELTA PREMIUM PRODUCTS",
                                //       "Delta ",
                                //       style: GoogleFonts.poppins(
                                //         textStyle: const TextStyle(
                                //           color: Colors.white,
                                //           fontSize: 45,
                                //           // fontWeight: FontWeight.bold,
                                //         ),
                                //       ),
                                //     ),
                                //     Text(
                                //       // "DELTA PREMIUM PRODUCTS",
                                //       "Premium Products.",
                                //       style: GoogleFonts.poppins(
                                //         textStyle: const TextStyle(
                                //           color: Colors.white,
                                //           fontSize: 45,
                                //           fontWeight: FontWeight.bold,
                                //         ),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                // SizedBox(
                                //   // color: Colors.blue,
                                //   height: height / 2,
                                //   width: width / 1,
                                //   // color: Colors.white,
                                //   child: Center(
                                //     child: AnimatedTextKit(
                                //       totalRepeatCount: 40,
                                //       animatedTexts: [
                                //         RotateAnimatedText(
                                //             '   tested\nproducts'.toUpperCase(),
                                //             // .toUpperCase(),
                                //             textStyle: GoogleFonts.poppins(
                                //               letterSpacing: 3,
                                //               fontSize: 80,
                                //               fontWeight: FontWeight.bold,
                                //               color: const Color.fromARGB(
                                //                   255, 217, 220, 60),
                                //             )),
                                //         RotateAnimatedText(
                                //           'efficient\n service'.toUpperCase(),
                                //           textStyle: GoogleFonts.poppins(
                                //             fontSize: 80.0,
                                //             fontWeight: FontWeight.bold,
                                //             color: const Color.fromARGB(
                                //                 255, 217, 220, 60),
                                //           ),
                                //         ),
                                //         RotateAnimatedText(
                                //           'trusted\n  brand'.toUpperCase(),
                                //           duration:
                                //               const Duration(milliseconds: 4000),
                                //           textStyle: GoogleFonts.poppins(
                                //             fontSize: 80.0,
                                //             fontWeight: FontWeight.bold,
                                //             color: const Color.fromARGB(
                                //                 255, 217, 220, 60),
                                //           ),
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // ),
                                const Gap(10),
                                // SizedBox(
                                //     width: MediaQuery.of(context).size.width / 3,
                                //     child:
                                //         TypeAheadFormField<Map<String, dynamic>>(
                                //       textFieldConfiguration:
                                //           TextFieldConfiguration(
                                //         decoration: InputDecoration(
                                //             hintText: 'Search here...',
                                //             hintStyle: TextStyle(
                                //               color:
                                //                   Colors.black.withOpacity(0.5),
                                //               fontSize: 16,
                                //             ),
                                //             fillColor: Color.fromARGB(
                                //                 255, 249, 250, 210),
                                //             filled: true,
                                //             prefixIcon: Icon(
                                //               Icons.search,
                                //               color: Color.fromARGB(
                                //                   221, 101, 101, 101),
                                //             ),
                                //             suffixIcon: ElevatedButton(
                                //                 onPressed: () {},
                                //                 child: Text("Search"))),
                                //       ),
                                //       suggestionsCallback: (query) async {
                                //         // Only call the fetchData() method if the search query is not empty.
                                //         if (query.isNotEmpty) {
                                //           return await productProvider
                                //               .fetchData(query);
                                //         } else {
                                //           return [];
                                //         }
                                //       },
                                //       itemBuilder: (context, suggestion) {
                                //         return SizedBox(
                                //           child: ListTile(
                                //             leading: CircleAvatar(
                                //               backgroundImage: NetworkImage(
                                //                   suggestion['thumbnail'])
                                //             ),
                                //             title: Text(suggestion['product_name']),
                                //           ),
                                //         );
                                //       },
                                //       onSuggestionSelected: (suggestion) {
                                //         final productName =
                                //             suggestion['product_name'];
                                //         final type = suggestion['type'];
                                //         final productNameWithUnderscores =
                                //             productName.replaceAll(" ", "_");
                                //         // final thumbnail = suggestion["thumbnail"];
                                //         selectedThumbnailProvider
                                //             .setSelectedThumbnail("",
                                //                 index: null);
                                //         navigateToProductDetailsFromSearch(
                                //             context,
                                //             productNameWithUnderscores,
                                //             type);
                                //       },
                                //     ))
                              ],
                            ),
                          ),
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
                                    color: colorTwo,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                // Text(
                                //   'What are we offering'.toUpperCase(),
                                //   style: GoogleFonts.quicksand(
                                //     color:
                                //         const Color.fromARGB(255, 156, 155, 155),
                                //     fontSize: 18,
                                //     fontWeight: FontWeight.bold,
                                //   ),
                                // ),
                                // Text(
                                //   'Our Products'.toUpperCase(),
                                //   style: GoogleFonts.poppins(
                                //     color: Color.fromARGB(255, 4, 4, 4),
                                //     fontSize: 22,
                                //     fontWeight: FontWeight.bold,
                                //   ),
                                // ),
                                // sdfg
                                const Gap(35),
                                SizedBox(
                                  // color: colorTwo,
                                  width: MediaQuery.of(context).size.width / 1.2,
                                  height: MediaQuery.of(context).size.height / 2,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      MouseRegion(
                                        onEnter: (_) =>
                                            setState(() => isHovered = true),
                                        onExit: (_) =>
                                            setState(() => isHovered = false),
                                        child: Container(
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
                                          height:
                                              MediaQuery.of(context).size.height /
                                                  2,
                                          width:
                                              MediaQuery.of(context).size.width /
                                                  2.6,
                                          child: Row(
                                            children: [
                                              Stack(children: [
                                                SizedBox(
                                                  // color: Colors.amber,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      2,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      4.5,
                                                  child: FittedBox(
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(
                                                          left: 15, right: 10),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Cable Terminal Ends'
                                                                .toUpperCase(),
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              color: colorTwo,
                                                              fontSize: 20,
                                                            ),
                                                          ),
                                                          Text(
                                                            "\nHEX is renowned for its superior quality\nof brass cable gland kits in the global market.",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    fontSize: 16),
                                                          ),
                                                          const Gap(15),
                                                          if (isHovered)
                                                            Row(
                                                              children: [
                                                                ElevatedButton(
                                                                  onPressed: () {
                                                                    Navigator.pushNamed(
                                                                        context,
                                                                        '/cable-terminal-ends/connectors/');
                                                                  },
                                                                  style:
                                                                      ButtonStyle(
                                                                    backgroundColor:
                                                                        MaterialStateProperty.all(
                                                                            Colors
                                                                                .white),
                                                                    minimumSize: MaterialStateProperty.all(
                                                                        const Size(
                                                                            120,
                                                                            50)),
                                                                  ),
                                                                  child: Text(
                                                                    'CONNECTORS',
                                                                    style: TextStyle(
                                                                        color:
                                                                            colorTwo,
                                                                        fontSize:
                                                                            14),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    width: 10),
                                                                ElevatedButton(
                                                                  onPressed: () {
                                                                    Navigator.pushNamed(
                                                                        context,
                                                                        '/cable-terminal-ends/lugs/');
                                                                  },
                                                                  child: const Text(
                                                                    'LUGS',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            15),
                                                                  ),
                                                                  style:
                                                                      ButtonStyle(
                                                                    backgroundColor:
                                                                        MaterialStateProperty
                                                                            .all(
                                                                                colorTwo),
                                                                    minimumSize: MaterialStateProperty.all(
                                                                        const Size(
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
                                              ]),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    2,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    6.2,
                                                child: FittedBox(
                                                  child: Image.asset(
                                                    'assets/image/w-removebg-preview (1).png',
                                                    width: 200,
                                                    height: 200,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      const Gap(15),
                                      MouseRegion(
                                        onEnter: (_) =>
                                            setState(() => iHovered = true),
                                        onExit: (_) =>
                                            setState(() => iHovered = false),
                                        child: Container(
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
                                          height:
                                              MediaQuery.of(context).size.height /
                                                  2,
                                          width:
                                              MediaQuery.of(context).size.width /
                                                  2.6,
                                          child: Row(
                                            children: [
                                              Stack(children: [
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      2,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      4.5,
                                                  child: FittedBox(
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(
                                                          left: 15, right: 10),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Brass Cable Gland Kits'
                                                                .toUpperCase(),
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              color: colorTwo,
                                                              fontSize: 20,
                                                            ),
                                                          ),
                                                          Text(
                                                            "\nHEX is renowned for its superior quality\nof brass cable gland kits in the global market.",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    fontSize: 16),
                                                          ),
                                                          const Gap(15),
                                                          if (iHovered)
                                                            Row(
                                                              children: [
                                                                ElevatedButton(
                                                                  onPressed: () {
                                                                    Navigator.pushNamed(
                                                                        context,
                                                                        '/switch-board-control-panel-accessories/');
                                                                  },
                                                                  style:
                                                                      ButtonStyle(
                                                                    backgroundColor:
                                                                        MaterialStateProperty.all(
                                                                            const Color(
                                                                                0xFFFFFFFF)),
                                                                    minimumSize: MaterialStateProperty.all(
                                                                        const Size(
                                                                            120,
                                                                            50)),
                                                                  ),
                                                                  child: Text(
                                                                    'ACCESSORIES',
                                                                    style: TextStyle(
                                                                        color:
                                                                            colorTwo,
                                                                        fontSize:
                                                                            14),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    width: 10),
                                                                ElevatedButton(
                                                                  onPressed: () {
                                                                    Navigator.pushNamed(
                                                                        context,
                                                                        '/brass-cable-gland-kits-accessories/brass-cable-glands/');
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                    'GLANDS',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            15),
                                                                  ),
                                                                  style:
                                                                      ButtonStyle(
                                                                    backgroundColor:
                                                                        MaterialStateProperty
                                                                            .all(
                                                                                colorTwo),
                                                                    minimumSize: MaterialStateProperty.all(
                                                                        const Size(
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
                                              ]),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    2,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    6.2,
                                                child: FittedBox(
                                                  child: Image.asset(
                                                    'assets/image/w1-removebg-preview (1).png',
                                                    width: 200,
                                                    height: 200,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // gap
                                Padding(
                                  padding: const EdgeInsets.only(left: 50),
                                  child: Container(
                                    color: Colors.white,
                                    height: height / 1.2,
                                    width: width,
                                    child:  Center(
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        clipBehavior: Clip.antiAlias,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            FittedBox(
                                                child: ProductContainer(
                                                   onPressed: () {
                                                                    Navigator.pushNamed(
                                                                        context,
                                                                        '/cable-support-systems/');
                                                                  },
                                              title: "PVC Coated Galvanised Flexible Conduit",
                                                  subtitle: "Cable Support Systems",
                                              imagePath:
                                                  'https://deltabuckets.s3.ap-south-1.amazonaws.com/carousel+images/landing+page+scroll+images/landing+page+scroll+pictures/canva+1+(1).png',
                                                 
                                            )
                                            ),
                                            const Gap(10),
                                             FittedBox(
                                                child: ProductContainer(
                                                  onPressed: (){
         Navigator.pushNamed(
                                                                        context,
                                                                        '/cable-jointing-and-termination-kit-components/');
                                                                    },
                                              title:
                                                  'hose clamps',
                                                  subtitle: "Cable Jointing & Termination Kit Components",
                                              imagePath:
                                                  'https://deltabuckets.s3.ap-south-1.amazonaws.com/carousel+images/landing+page+scroll+images/landing+page+scroll+pictures/canva+1+(5).png',
                                            )),
                                            const Gap(10),
                                             FittedBox(
                                                child: ProductContainer(
                                                   onPressed: (){
                                                     Navigator.pushNamed(
                                                                        context,
                                                                        '/earthing-lightning-protection-systems/earthing-lightning-protection-accessories/');
                                                                 
                                                  },
                                              title: 'double plate "u" clamp',
                                              subtitle: "earthing & lightning protection accessories",
                                              imagePath:
                                                  'https://deltabuckets.s3.ap-south-1.amazonaws.com/carousel+images/landing+page+scroll+images/landing+page+scroll+pictures/canva+1+(7).png',
                                            )),
                                            const Gap(10),
                                             FittedBox(
                                                child: ProductContainer(
                                                   onPressed: (){
                                                     Navigator.pushNamed(
                                                                        context,
                                                                        '/crimping-tools/');
                                                                 
                                                  },
                                              title:
                                                  'crimping tool',
                                                  subtitle: "view more crimping tools",
                                              imagePath:
                                                  'https://deltabuckets.s3.ap-south-1.amazonaws.com/carousel+images/landing+page+scroll+images/landing+page+scroll+pictures/canva+1+(2).png',
                                            )),
                                            const Gap(10),
                                             FittedBox(
                                                child: ProductContainer(
                                                  onPressed: (){
                                                     Navigator.pushNamed(
                                                                        context,
                                                                        '/Stainless Steel Cable Ties & Markers');
                                                                 
                                                  },
                                              title:
                                                  'Roller ball type stainless steel cable ties',
                                                  subtitle: "Stainless steel cable ties & markers",
                                              imagePath:
                                                  'https://deltabuckets.s3.ap-south-1.amazonaws.com/carousel+images/landing+page+scroll+images/landing+page+scroll+pictures/canva+1+(6).png',
                                            )),
                                            const Gap(10),
                                             FittedBox(
                                                child: ProductContainer(
                                                   onPressed: (){
                                                     Navigator.pushNamed(
                                                                        context,
                                                                        '/switch-board-control-panel-accessories/');
                                                                 
                                                  },
                                              title:
                                                  'Insulated bus bar system for mcb',
                                                  subtitle: "Switch Board Control Panel Accessories",
                                              imagePath:
                                                  'https://deltabuckets.s3.ap-south-1.amazonaws.com/carousel+images/landing+page+scroll+images/landing+page+scroll+pictures/canva+1+(4).png',
                                            )),
                                            Gap(10),
                                            FittedBox(
                                                child: ProductContainer(
                                                   onPressed: (){
                                                     Navigator.pushNamed(
                                                                        context,
                                                                        '/earthing-lightning-protection-systems/earthing-lightning-protection/');
                                                                 
                                                  },
                                              title: 'Copper Bonded Grounding Rods',
                                              subtitle: "Earthing & Lightning Protection",
                                              imagePath:
                                                  'https://deltabuckets.s3.ap-south-1.amazonaws.com/carousel+images/landing+page+scroll+images/landing+page+scroll+pictures/canva+1+(8).png',
                                            )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
        Gap(65),
                                Container(
                                  color: const Color.fromARGB(255, 236, 242, 242),
                                  height:
                                      MediaQuery.of(context).size.height / 1.1,
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      MouseRegion(
                                        onEnter: (_) =>
                                            setState(() => issHovered = true),
                                        onExit: (_) =>
                                            setState(() => issHovered = false),
                                        child: Stack(children: [
                                          FittedBox(
                                            child: SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    1.1,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2,
                                                child: Image.asset(
                                                    'assets/image/glands 4.png',
                                                    fit: BoxFit.fill)),
                                          ),
                                          if (issHovered)
                                            FittedBox(
                                              child: SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      1.1,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2,
                                                  child: Image.asset(
                                                      'assets/image/glands 2.png',
                                                      fit: BoxFit.fill)),
                                            ),
                                        ]),
                                      ),
                                      SizedBox(
                                        child: Row(
                                          children: [
                                            const Gap(75),
                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  3,
                                              width: 10,
                                              color: Colors.yellow,
                                            ),
                                            const Gap(15),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Where the',
                                                  style: GoogleFonts.workSans(
                                                      fontSize: 45,
                                                      color: const Color.fromARGB(
                                                          255, 30, 30, 30),
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  'world of',
                                                  style: GoogleFonts.workSans(
                                                      fontSize: 45,
                                                      color: const Color.fromARGB(
                                                          255, 51, 51, 51),
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  'construction',
                                                  style: GoogleFonts.workSans(
                                                      fontSize: 45,
                                                      color: const Color.fromARGB(
                                                          255, 129, 129, 129),
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  'gets together',
                                                  style: GoogleFonts.workSans(
                                                      fontSize: 45,
                                                      color: const Color.fromARGB(
                                                          255, 184, 183, 183),
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
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
                                                const Gap(35),
                                                  Text(
                            'Renowed Manufactures Of',
                            style: GoogleFonts.raleway(
                                fontSize: 25, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'World Class Electrical',
                            style: GoogleFonts.raleway(
                                fontSize: 25, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'And Brass Components',
                            style: GoogleFonts.raleway(
                                fontSize: 25, fontWeight: FontWeight.w500),
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
          ),
        );
      } else {
        return SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      // height: MediaQuery.of(context).size.height / 2,
                      child: Image.network(
                        'https://deltabuckets.s3.ap-south-1.amazonaws.com/carousel+images/landing_page+images/White+Minimal+Furniture+Website+Desktop+Prototype+(1).png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Positioned(
                    //   child: Column(
                    //     children: [
                    //       SizedBox(
                    //         height: MediaQuery.of(context).size.height / 17,
                    //       ),
                    //       Row(
                    //         // crossAxisAlignment: CrossAxisAlignment.center,
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           Text(
                    //             "Experience ",
                    //             // "EXPERIENCE THE NEW",
                    //             style: GoogleFonts.poppins(
                    //               textStyle: const TextStyle(
                    //                 color: Colors.white,
                    //                 fontSize: 21,
                    //                 fontWeight: FontWeight.bold,
                    //               ),
                    //             ),
                    //           ),
                    //           Text(
                    //             "The New",
                    //             // "EXPERIENCE THE NEW",
                    //             style: GoogleFonts.poppins(
                    //               textStyle: const TextStyle(
                    //                 color: Colors.white,
                    //                 fontSize: 21,
                    //                 // fontWeight: FontWeight.bold,
                    //               ),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           Text(
                    //             // "DELTA PREMIUM PRODUCTS",
                    //             "Delta ",
                    //             style: GoogleFonts.poppins(
                    //               textStyle: const TextStyle(
                    //                 color: Colors.white,
                    //                 fontSize: 21,
                    //                 // fontWeight: FontWeight.bold,
                    //               ),
                    //             ),
                    //           ),
                    //           Text(
                    //             // "DELTA PREMIUM PRODUCTS",
                    //             "Premium Products.",
                    //             style: GoogleFonts.poppins(
                    //               textStyle: const TextStyle(
                    //                 color: Colors.white,
                    //                 fontSize: 21,
                    //                 fontWeight: FontWeight.bold,
                    //               ),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //       SizedBox(
                    //         // color: Colors.blue,
                    //         height: height / 3,
                    //         width: width / 1,
                    //         // color: Colors.white,
                    //         child: Center(
                    //           child: AnimatedTextKit(
                    //             totalRepeatCount: 50,
                    //             animatedTexts: [
                    //               RotateAnimatedText(
                    //                   '   tested\nproducts'.toUpperCase(),
                    //                   // .toUpperCase(),
                    //                   textStyle: GoogleFonts.poppins(
                    //                     letterSpacing: 3,
                    //                     fontSize: 40,
                    //                     fontWeight: FontWeight.bold,
                    //                     color: const Color.fromARGB(
                    //                         255, 217, 220, 60),
                    //                   )),
                    //               RotateAnimatedText(
                    //                 'efficient\n service'.toUpperCase(),
                    //                 textStyle: GoogleFonts.poppins(
                    //                   fontSize: 40.0,
                    //                   fontWeight: FontWeight.bold,
                    //                   color: const Color.fromARGB(
                    //                       255, 217, 220, 60),
                    //                 ),
                    //               ),
                    //               RotateAnimatedText(
                    //                 'trusted\n  brand'.toUpperCase(),
                    //                 duration:
                    //                     const Duration(milliseconds: 4000),
                    //                 textStyle: GoogleFonts.poppins(
                    //                   fontSize: 40.0,
                    //                   fontWeight: FontWeight.bold,
                    //                   color: const Color.fromARGB(
                    //                       255, 217, 220, 60),
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
                Container(
                    width: width,
                    height: height / 1.1,
                    color: Colors.white,
                    child: Column(
                      children: [
                        const Gap(35),
                        Text(
                          'What are we offering'.toUpperCase(),
                          style: GoogleFonts.quicksand(
                            color: colorTwo,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        const Gap(25),
                        Container(
                          color: Colors.white,
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
                                          child: Image.network(
                                            imageUrls[index],
                                            fit: BoxFit.cover,
                                            alignment: Alignment(
                                                -pageOffSet.abs() + index, 0),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 40,
                                        child: Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: Text(
                                            textindex[index],
                                            style: GoogleFonts.oswald(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 1,
                                        child: Padding(
                                            padding: const EdgeInsets.all(15),
                                            child: Text(
                                              descriptionCarosal[index],
                                              style: GoogleFonts.roboto(),
                                            )),
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Gap(15),
                        Image.asset(
                          'assets/image/hex-logo-new.png',
                          width: 100,
                          height: 100,
                        ),
                        const Gap(25),
                        Text(
                          'Renowed Manufactures Of',
                          style: GoogleFonts.raleway(
                              fontSize: 25, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'World Class Electrical',
                          style: GoogleFonts.raleway(
                              fontSize: 25, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'And Brass Components',
                          style: GoogleFonts.raleway(
                              fontSize: 25, fontWeight: FontWeight.w500),
                        )
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
          ),
        );
      }
      //    Material(
      //       // color: Colors.black,
      //       child: NotificationListener<ScrollNotification>(
      //     onNotification: updateOffsetAccordingToScroll,
      //     child: ScrollConfiguration(
      //         behavior: NoScrollGlow(),
      //         child: Stack(
      //           children: <Widget>[
      //             Positioned(
      //                 bottom:200,
      //                 child: FadeInImage.memoryNetwork(
      //                   placeholder: kTransparentImage,
      //                   image: kHeroImage,
      //                          height: height,
      //                   width: width,
      //                   fit: BoxFit.fitWidth,
      //                 )),
      //             // Positioned(
      //             //   top: -.25 * offset,
      //             //   child: SizedBox(
      //             //     // color: Colors.yellow,
      //             //     height: 600,
      //             //     width: width,
      //             //     child: Align(
      //             //       alignment: const Alignment(0, 0),
      //             //       child: Padding(
      //             //         padding: EdgeInsets.symmetric(horizontal: 40),
      //             //         child: Column(
      //             //           mainAxisAlignment: MainAxisAlignment.center,
      //             //           crossAxisAlignment: CrossAxisAlignment.center,
      //             //           children: [
      //             //             SizedBox(
      //             //               height: MediaQuery.of(context).size.height *
      //             //                   0.10,
      //             //             ),
      //             //             // Gap(45),
      //             //             Text(
      //             //               "EXPERIENCE THE NEW DELTA PREMIUM PRODUCTS",
      //             //               style: GoogleFonts.abrilFatface(
      //             //                 textStyle: const TextStyle(
      //             //                   color: Colors.white,
      //             //                   fontSize: 25,
      //             //                   // shadows: <Shadow>[
      //             //                   // Shadow(
      //             //                   //   offset: Offset(2.0, 2.0),
      //             //                   //   blurRadius: 3.0,
      //             //                   //   color: Colors.grey.withOpacity(0.5),
      //             //                   // )
      //             //                   // ],
      //             //                 ),
      //             //               ),
      //             //             ),
      //             //             // Text(
      //             //             //   "DELTA PREMIUM PRODUCTS",
      //             //             //   style: GoogleFonts.abrilFatface(
      //             //             //     textStyle: const TextStyle(
      //             //             //       color: Colors.white,
      //             //             //       fontSize: 25,
      //             //             //       shadows: <Shadow>[
      //             //             //         // Shadow(
      //             //             //         //   offset: Offset(2.0, 2.0),
      //             //             //         //   blurRadius: 3.0,
      //             //             //         //   color: Colors.grey.withOpacity(0.5),
      //             //             //         // )
      //             //             //       ],
      //             //             //     ),
      //             //             //   ),
      //             //             // ),
      //             //             const Text(
      //             //               "\nTested Products | Efficient Service | Trusted Brand\n",
      //             //               style: TextStyle(
      //             //                 fontSize: 20,
      //             //                 fontWeight: FontWeight.w400,
      //             //                 color: Colors.white,
      //             //               ),
      //             //             ),
      //             //             SizedBox(
      //             //               height: height / 3.5,
      //             //               width: width / 1,
      //             //               // color: Colors.white,
      //             //               child:
      //             //                   //  AnimatedTextKit(
      //             //                   //               animatedTexts: [
      //             //                   //                 RotateAnimatedText('AWESOME',
      //             //                   //                     textStyle: TextStyle(
      //             //                   //                         fontSize: 30,
      //             //                   //                         color: Colors.white,
      //             //                   //                         backgroundColor: Colors.blue)),
      //             //                   //                 RotateAnimatedText('OPTIMISTIC',
      //             //                   //                     textStyle: TextStyle(
      //             //                   //                         letterSpacing: 3,
      //             //                   //                         fontSize: 30,
      //             //                   //                         fontWeight: FontWeight.bold,
      //             //                   //                         color: Colors.orange)),
      //             //                   //                 RotateAnimatedText(
      //             //                   //                   'DIFFERENT',
      //             //                   //                   textStyle: TextStyle(
      //             //                   //                     fontSize: 30,
      //             //                   //                     decoration: TextDecoration.underline,
      //             //                   //                   ),
      //             //                   //                 ),
      //             //                   //               ],
      //             //                   //               isRepeatingAnimation: true,
      //             //                   //               totalRepeatCount: 10,
      //             //                   //               pause: Duration(milliseconds: 1000),
      //             //                   //             ),
      //             //                   Center(
      //             //                 child: AnimatedTextKit(
      //             //                   totalRepeatCount: 40,
      //             //                   animatedTexts: [
      //             //                     RotateAnimatedText(
      //             //                         'Trans Delta Trading'
      //             //                             .toUpperCase(),
      //             //                         textStyle: const TextStyle(
      //             //                             letterSpacing: 3,
      //             //                             // fontSize: 30,
      //             //                             fontWeight: FontWeight.bold,
      //             //                             color: Colors.orange)),
      //             //                     FadeAnimatedText(
      //             //                       'Powering Progress: Your Source for Premium Electrical Solutions',
      //             //                       textStyle: const TextStyle(
      //             //                           color: Color.fromARGB(
      //             //                               255, 243, 149, 35),
      //             //                           // fontSize: 25.0,
      //             //                           fontWeight: FontWeight.bold),
      //             //                     ),
      //             //                     ScaleAnimatedText(
      //             //                       'We are introducing our products',
      //             //                       duration: const Duration(
      //             //                           milliseconds: 4000),
      //             //                       textStyle: const TextStyle(
      //             //                         color: Colors.white,
      //             //                         // fontSize: 50.0
      //             //                       ),
      //             //                     ),
      //             //                   ],
      //             //                 ),
      //             //               ),
      //             //             ),
      //             //             // const SizedBox(height: 20),
      //             //           ],
      //             //         ),
      //             //       ),
      //             //     ),
      //             //   ),
      //             // ),
      //             SingleChildScrollView(
      //               child: Column(
      //                 children: [
      //                   Container(
      //                     color: Colors.transparent,
      //                     height: 500
      //                   ),
      // Container(
      //     width: width,
      //     color: Colors.white,
      //     child: Column(
      //       children: [
      //         Gap(35),
      //         Text(
      //           'What are we offering'.toUpperCase(),
      //           style: GoogleFonts.quicksand(
      //             color: const Color.fromARGB(
      //                 255, 156, 155, 155),
      //             fontSize: 18,
      //             fontWeight: FontWeight.bold,
      //           ),
      //         ),
      //         Text(
      //           'Our Products'.toUpperCase(),
      //           style: const TextStyle(
      //             color: Color.fromARGB(255, 4, 4, 4),
      //             fontSize: 22,
      //             fontWeight: FontWeight.bold,
      //           ),
      //         ),
      //         Gap(35),
      //         SizedBox(
      //           height: 450,
      //           child: PageView.builder(
      //             controller: pageController,
      //             itemCount: imageUrls.length,
      //             itemBuilder: (context, index) {
      //               debugPrint("{-pageOffSet.abs() + index}");
      //               return GestureDetector(
      //                 onTap: () {
      //                   _navigateToPage(context, index);
      //                 },
      //                 child: Padding(
      //                   padding: const EdgeInsets.all(6.0),
      //                   child: Stack(
      //                     children: [
      //                       ClipRRect(
      //                         borderRadius:
      //                             BorderRadius.circular(30),
      //                         child: SizedBox(
      //                           height: 350,
      //                           child: Image.asset(
      //                             imageUrls[index],
      //                             fit: BoxFit.cover,
      //                             alignment: Alignment(
      //                                 -pageOffSet.abs() +
      //                                     index,
      //                                 0),
      //                           ),
      //                         ),
      //                       ),
      //                       Positioned(
      //                         bottom: 20,
      //                         child: Padding(
      //                           padding:
      //                               const EdgeInsets.all(15),
      //                           child: Text(
      //                             textindex[index],
      //                             style: const TextStyle(
      //                               color: Color.fromARGB(
      //                                   255, 137, 137, 137),
      //                               fontSize: 22,
      //                               fontWeight:
      //                                   FontWeight.bold,
      //                             ),
      //                           ),
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               );
      //             },
      //           ),
      //         ),
      //       ],
      //     )),
      // Container(
      //     color: Colors.white,
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         const Gap(15),
      //         Image.asset('assets/image/hex-logo-new.png'),
      //         const Gap(15),
      //         const Padding(
      //           padding: EdgeInsets.only(left: 15),
      //           child: Text(
      //             "RENOWNED MANUFACTURERS OF WORLD CLASS ELECTRICAL AND BRASS COMPONENTS",
      //             style: TextStyle(
      //                 fontSize: 25,
      //                 fontWeight: FontWeight.w700),
      //           ),
      //         )
      //         // Text(
      //         //   "\nRENOWNED MANUFACTURERS OF WORLD\nCLASS ELECTRICAL AND BRASS COMPONENTS",
      //         //   style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
      //         // )
      //       ],
      //     )),
      // Container(
      //     width: double.infinity,
      //     color: Colors.white,
      //     child: Image.network(
      //         "https://www.lkea.in/assets/images/about/2.jpg")),
      // Container(
      //     width: double.infinity,
      //     child: MediaQuery.of(context).size.width >= 700
      //         ? const deskBottomSheett()
      //         : const mobiledeskBottomSheett())
      //                 ],
      //               ),
      //             )
      //           ],
      //         )),
      //   ));
      // }
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
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) {
    return child;
  }
}

const kHeroImage =
    'https://deltabuckets.s3.ap-south-1.amazonaws.com/carousel+images/landing_page+images/White+Minimal+Furniture+Website+Desktop+Prototype+(1).png';

// Product container code of landing Page

class ProductContainer extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
   final VoidCallback? onPressed;


  const ProductContainer({
    required this.title,
    required this.subtitle,
    required this.imagePath,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height / 1.6,
      width: width / 3.5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: colorOne),
      child: Stack(children: [
        SizedBox(
            child: Image.network(
          imagePath,
          height: height,
          width: width,
          fit: BoxFit.cover,
        )),
        // Positioned(
        //   top: 10,
        //   left: 10,
        //   child: Image.asset(
        //     'assets/image/hex_logo.png',
        //     width: 25,
        //     height: 25,
        //     fit: BoxFit.cover,
        //   ),
        // ),
        Positioned(
            bottom: 90,
            left: 15,
            child: Text(
              title.toUpperCase(),
              style: GoogleFonts.oswald(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )),
            Positioned(
            bottom: 70,
            left: 15,
            child: Text(
              subtitle.toUpperCase(),
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            )),
        Positioned(
          bottom: 20,
          left: 15,
          child: ElevatedButton(
            onPressed: onPressed,
            child: Text(
              'Quote'.toUpperCase(),
              style: GoogleFonts.roboto(color: Colors.black, fontSize: 15),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              minimumSize: MaterialStateProperty.all(const Size(120, 50)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}

class CustomOutlineButton extends StatefulWidget {
  final String text;
  final Function() onTap;
  final double? width;
  final Color? textColor;
  const CustomOutlineButton({
    Key? key,
    this.width,
    this.textColor,
    required this.text,
    required this.onTap,
  }) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _CustomOutlineButtonState createState() => _CustomOutlineButtonState();
}

class _CustomOutlineButtonState extends State<CustomOutlineButton> {
  double _animatedWidth = 0.0;
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (!isHover)
          Container(
            height: 52,
            width: widget.width ?? 177,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 52,
          width: _animatedWidth,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30), color: colorOne),
        ),
        InkWell(
          onHover: (value) {
            setState(() {
              isHover = !isHover;
              _animatedWidth = value ? widget.width ?? 177 : 0.0;
            });
          },
          onTap: () {
            setState(() => _animatedWidth = 250);
            widget.onTap();
          },
          child: SizedBox(
            height: 52,
            width: widget.width ?? 177,
            child: Center(
              child: Text(
                widget.text.toUpperCase(),
                style: TextStyle(
                  color: isHover ? colorOne : widget.textColor ?? Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
