import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_hex/main.dart';
import 'package:firebase_hex/pages/another_pages/About_Us.dart';
import 'package:firebase_hex/pages/another_pages/appbar_page.dart';
import 'package:firebase_hex/pages/another_pages/contact_us.dart';
import 'package:firebase_hex/pages/product_pages/crimping.dart';
import 'package:firebase_hex/pages/product_pages/gland.dart';
import 'package:firebase_hex/pages/product_pages/lugs.dart';
import 'package:firebase_hex/provider/Refresh.dart';
import 'package:firebase_hex/widgets/bottom_sheet.dart';
import 'package:firebase_hex/responsive/landing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../provider/address_provider.dart';

class LandinPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: ResponsiveLandingPage(
            mobileAppBar: MobileLanding(), desktopAppBar: DesktopLanding()));
  }
}

class DesktopLanding extends StatefulWidget {
  @override
  State<DesktopLanding> createState() => _DesktopLandingState();
}

class _DesktopLandingState extends State<DesktopLanding> {
  PageController pageController = PageController(viewportFraction: 0.6);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  double pageOffSet = 0;
   bool isHovered = false;
   bool iHovered = false;

  List<String> imageUrls = [
    'https://media.istockphoto.com/id/1288385045/photo/snowcapped-k2-peak.jpg?s=2048x2048&w=is&k=20&c=w2Qcpt4yVuD8nfG5pkrxwo0t_aq-fHewpEQX4gRa870=',
    // Add more image URLs for each container
    'data:image/jpeg;base64,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',
    'https://www.shutterstock.com/image-photo/cable-lugs-connecting-electrical-cables-260nw-1863589438.jpg',
    '...',
  ];
   final List<int> numbers = [1, 2, 3, 5, 8, 13, 21, 34, 55];

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
        navigateToPage(context, '/Lugs');
        break;
      case 2:
        navigateToPage(context, '/Lugs');
        break;
      // Add more cases if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    

    // MediaQueryData queryData = MediaQuery.of(context);
    // Widget industrialCableText = queryData.size.width >= 950
    //     ? Padding(
    //         padding: EdgeInsets.only(left: 50),
    //         child: Text(
    //           'Industrial Cable Management System for your Electrical Projects!',
    //           style: GoogleFonts.abel(
    //             textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    //           ),
    //         ),
    //       )
    //     : SizedBox();

    // Widget industrialCableTextt = queryData.size.width >= 950
    //     ? SizedBox()
    //     : Padding(
    //         padding: EdgeInsets.only(left: 50),
    //         child: Text(
    //           '\nIndustrial Cable Management System for your Electrical Projects!\n',
    //           style: GoogleFonts.abel(
    //             textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    //           ),
    //         ),
    //       );
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 1,
                color: Colors.transparent,
                child: Image.asset(
                  "assets/image/landingpage.png",
                  // "https://knowhow.distrelec.com/wp-content/uploads/2021/11/iStock-1477511739.jpg",
                  // 'https://i0.wp.com/www.compliancesigns.com/blog/wp-content/uploads/2023/05/5-Electrical-Safety-Tips.jpg?fit=1200%2C630&ssl=1',
                  width: 200,
                  height: 200,
                  // color: Colors.amber,
                  fit: BoxFit.cover,
                ),
              ),
              BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                  // blur(sigmaX:.0,sigmaY:0.0),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 45, top: 45),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "EXPERIENCE THE NEW\nDELTA PREMIUM PRODUCTS",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                                shadows: <Shadow>[
                                  // Shadow(
                                  //   offset: Offset(2.0, 2.0),
                                  //   blurRadius: 3.0,
                                  //   color: Colors.grey.withOpacity(0.5),
                                  // )
                                ]),
                          ),
                        ),
                        Text(
                          "\nTested Products | Efficient Service | Trusted Brand\n",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                //                           Navigator.push(
                                //   context,
                                //   MaterialPageRoute(builder: (context) =>  AboutUsPage()),
                                // );
                              },
                              child: FittedBox(
                                child: Container(
                                  child: Center(
                                      child: Text(
                                    "ABOUT US",
                                    style: GoogleFonts.firaSans(
                                        fontWeight: FontWeight.w600),
                                  )),
                                  width: MediaQuery.of(context).size.width / 13,
                                  height: MediaQuery.of(context).size.height / 16,
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(249, 156, 6, 1.0),
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
                                      builder: (context) => ContactUsPage()),
                                );
                              },
                              child: FittedBox(
                                child: Container(
                                  child: Center(
                                      child: Text(
                                    "CONTACT US",
                                    style: GoogleFonts.firaSans(
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromRGBO(249, 156, 6, 1.0)),
                                  )),
                                  width: MediaQuery.of(context).size.width / 12,
                                  height: MediaQuery.of(context).size.height / 16,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    // borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color.fromRGBO(249, 156, 6, 1.0),
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
                        // SizedBox(
                        //   height: 320,
                        // ),
                        // // industrialCableText,
                        // SizedBox(
                        //   height: 30,
                        // ),
                      ],
                    ),
                  )),
              // Positioned(
              //   right: MediaQuery.of(context).size.width * 0.1,
              //   top: 30,
              //   child: Container(
              //     width: 450,
              //     height: 850,
              //     child: Swiper(
              //       itemWidth: 400,
              //       itemHeight: 360,
              //       loop: true,
              //       duration: 1200,
              //       scrollDirection: Axis.vertical,
              //       itemBuilder: (context, index) {
              //         return Container(
              //           // color: Colors.white,
              //           // decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 2)),
              //           child: Column(
              //             children: [
              //               Image.asset(imagepath[index]),
              //               Text(headingss[index],
              //                   style: GoogleFonts.barlow(
              //                     textStyle: TextStyle(
              //                         color:
              //                             const Color.fromARGB(255, 238, 131, 38),
              //                         fontSize: 20,
              //                         fontWeight: FontWeight.w700),
              //                   )),
              //               Text(
              //                 descriptionn[index],
              //                 style: TextStyle(
              //                     fontSize: 17, fontWeight: FontWeight.w400),
              //               )
              //             ],
              //           ),
              //         );
              //       },
              //       itemCount: imagepath.length,
              //       layout: SwiperLayout.STACK,
              //     ),
              //   ),
              // ),
            ],
          ),
           SizedBox(
                          height: 50,
                        ),
          // industrialCableTextt,
          // Padding(
          //   padding: const EdgeInsets.only(left: 50, bottom: 40),
          //   child: Text(
          //     '          Delta Cable Management Systems are designed to efficiently organize and secure electrical and electronic\ncables in various settings, be it a facility, residence, or office. Industrial cable wholesale sellers in Saudi Arabia\nprioritize crafting cables that promote tidy workspaces, minimize trip hazards, prevent short circuits, and ultimately\nelevate electrical safety and functionality within your environment',
          //     style: GoogleFonts.abel(fontSize: 20, fontWeight: FontWeight.w300),
          //   ),
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             MouseRegion(
               onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
               child: Stack(
               children: [
                 FittedBox(
                   child: Container(
                     height: 320,
                     width: MediaQuery.of(context).size.width / 2.8,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.all(Radius.circular(10)),
                       gradient: LinearGradient(
                         begin: Alignment.bottomCenter,
                         end: Alignment.topCenter,
                         colors: [
                           Color.fromARGB(255, 192, 191, 191),
                           Color.fromARGB(255, 215, 215, 214),
                           Color.fromARGB(255, 240, 239, 239),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cable Terminal Ends'.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(249, 156, 6, 1.0),
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "\nHEX is renowned for its superior quality\nof brass cable gland kits in the global market.",
                        style: TextStyle(fontSize: 16),
                      ),
                      Gap(15),
                      if (isHovered)
                      Row(
                        children: [
                          ElevatedButton(
                                onPressed: () {
                                },
                                child: Text(
                                  'CONNECTORS',
                                  style: TextStyle(color: Color.fromRGBO(249, 156, 6, 1.0),fontSize: 14),
                                  
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  minimumSize:
                                      MaterialStateProperty.all(Size(120, 50)),
                                ),
                              ),
                          SizedBox(width: 10),
                         ElevatedButton(
                                onPressed: () {
                                },
                                child: Text(
                                  'LUGS',
                                  style: TextStyle(color:Colors.black,fontSize: 15),
                                  
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Color.fromRGBO(249, 156, 6, 1.0),),
                                  minimumSize:
                                      MaterialStateProperty.all(Size(120, 50)),
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
                 onEnter: (_) => setState(() => iHovered = true),
      onExit: (_) => setState(() => iHovered = false),
                 child: Stack(
                 children: [
                   Container(
                     height: 320,
                     width: MediaQuery.of(context).size.width / 2.8,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.all(Radius.circular(10)),
                       gradient: LinearGradient(
                         begin: Alignment.bottomCenter,
                         end: Alignment.topCenter,
                         colors: [
                           Color.fromARGB(255, 192, 191, 191),
                           Color.fromARGB(255, 215, 215, 214),
                           Color.fromARGB(255, 240, 239, 239),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Brass Cable Gland Kits".toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(249, 156, 6, 1.0),
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        '\nHEX is a manufacturer of high-quality\ncable terminal ends & accessories.',
                        style: TextStyle(fontSize: 16),
                      ),
                      Gap(15),
                      if (iHovered)
                      Row(
                        children: [
                          ElevatedButton(
                                onPressed: () {
                                },
                                child: Text(
                                  'ACCESSORIES',
                                  style: TextStyle(color: Color.fromRGBO(249, 156, 6, 1.0),fontSize: 14),
                                  
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  minimumSize:
                                      MaterialStateProperty.all(Size(120, 50)),
                                ),
                              ),
                          SizedBox(width: 10),
                         ElevatedButton(
                                onPressed: () {
                                },
                                child: Text(
                                  'GLANDS',
                                  style: TextStyle(color:Colors.black,fontSize: 15),
                                  
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Color.fromRGBO(249, 156, 6, 1.0),),
                                  minimumSize:
                                      MaterialStateProperty.all(Size(120, 50)),
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
                       width:250,
                       height:250,
                       // fit: BoxFit.cover,
                     ),)
                 ],
               ),
               ),
            ],
          ),
          //  Container(
          //   color: Color.fromARGB(255, 214, 211, 125),
          // padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          // height: MediaQuery.of(context).size.height * 0.55,
          // child: ListView.builder(
          //   scrollDirection: Axis.horizontal,
          //     itemCount: numbers.length, itemBuilder: (context, index) {
          //       return Container(
          //         width: MediaQuery.of(context).size.width * 0.6,
          //         child: Card(
          //           color: Color.fromARGB(255, 217, 229, 90),
          //           child: Container(
          //             child: Center(child: Text(numbers[index].toString(), style: TextStyle(color: Colors.white, fontSize: 36.0),)),
          //           ),
          //         ),
          //       );
          // }),),
          //==================navigation of containers =====================
          //      Container(
          //       color: Colors.black,
          //   height: 300,
    
          //   child: PageView.builder(
          //     controller: pageController,
          //     itemCount: imageUrls.length,
          //     itemBuilder: (context, index) {
          //       debugPrint("{-pageOffSet.abs() + index}");
          //       return GestureDetector(
          //         onTap: () {
          //           _navigateToPage(context, index);
          //         },
          //         child: Padding(
          //           padding: const EdgeInsets.all(0),
          //           child: Stack(
          //             children: [
          //               ClipRRect(
          //                 borderRadius: BorderRadius.circular(30),
          //                 child: SizedBox(
          //                   height: 300,
          //                   child: Image.network(
          //                     imageUrls[index], // Use the image URL from the list
          //                     fit: BoxFit.cover,
          //                     alignment:
          //                     Alignment(-pageOffSet.abs() + index, 0),
          //                   ),
          //                 ),
          //               ),
          //               const Positioned(
          //                 bottom: 20,
          //                 child: Padding(
          //                   padding: EdgeInsets.all(15),
          //                   child: Text(
          //                     'Mountain',
          //                     style: TextStyle(
          //                       color: Color.fromARGB(255, 4, 4, 4),
          //                       fontSize: 22,
          //                       fontWeight: FontWeight.bold,
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/image/hex-logo-new.png'),
                            Text(
                              "\nRENOWNED MANUFACTURERS OF WORLD\nCLASS ELECTRICAL AND BRASS COMPONENTS",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w700),
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
              color: const Color.fromARGB(255, 255, 255, 255),
              height: MediaQuery.of(context).size.height / 1.5,
              child: MediaQuery.of(context).size.width >= 700
                  ? deskBottomSheett()
                  : mobiledeskBottomSheett())
        ],
      ),
    );
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
}

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

class MobileLanding extends StatefulWidget {
  const MobileLanding({super.key});

  @override
  State<MobileLanding> createState() => _MobileLandingState();
}

class _MobileLandingState extends State<MobileLanding> {
  PageController pageController = PageController(viewportFraction: 0.6);
  double pageOffSet = 0;

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
        
      // Add more cases if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 1.5,
              color: Colors.transparent,
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
                filter: ImageFilter.blur(sigmaX: 210, sigmaY: 210.0),

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
                                  color: const Color.fromARGB(255, 13, 13, 13)
                                      .withOpacity(0.5),
                                )
                              ]),
                        ),
                      ),
                      Text(
                        "\nTested Products | Efficient Service | Trusted Brand\n",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                        Row(
                        children: [
                          InkWell(
                            onTap: () {
                              //                           Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) =>  AboutUsPage()),
                              // );
                            },
                            child: FittedBox(
                              child: Container(
                                child: Center(
                                    child: Text(
                                  "ABOUT US",
                                  style: GoogleFonts.firaSans(
                                      fontWeight: FontWeight.w600),
                                )),
                                width: MediaQuery.of(context).size.width / 5,
                                height: MediaQuery.of(context).size.height / 18,
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(249, 156, 6, 1.0),
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
                                    builder: (context) => ContactUsPage()),
                              );
                            },
                            child: FittedBox(
                              child: Container(
                                child: Center(
                                    child: Text(
                                  "CONTACT US",
                                  style: GoogleFonts.firaSans(
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(249, 156, 6, 1.0)),
                                )),
                                width: MediaQuery.of(context).size.width / 5,
                                height: MediaQuery.of(context).size.height / 18,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  // borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color.fromRGBO(249, 156, 6, 1.0),
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
                //++++++++++++++ SWIPER ================
            // Positioned(
            //   right: 30,
            //   left: 30,
            //   top: 300,
            //   child: Container(
            //     width: 450,
            //     height: 880,
            //     // color: Colors.white,
            //     // color: Colors.transparent,
            //     child: Swiper(
            //       itemWidth: 400,
            //       itemHeight: 360,
            //       loop: true,
            //       duration: 1200,
            //       scrollDirection: Axis.vertical,
            //       itemBuilder: (context, index) {
            //         return Container(
            //           // color: Colors.white,
            //           // decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 2)),
            //           child: Column(
            //             children: [
            //               Image.asset(imagepath[index]),
            //               Text(headingss[index],
            //                   style: GoogleFonts.barlow(
            //                     textStyle: TextStyle(
            //                         color:
            //                             const Color.fromARGB(255, 238, 131, 38),
            //                         fontSize: 20,
            //                         fontWeight: FontWeight.w700),
            //                   )),
            //               Text(
            //                 descriptionn[index],
            //                 style: const TextStyle(
            //                     fontSize: 17, fontWeight: FontWeight.w400),
            //               )
            //             ],
            //           ),
            //         );
            //       },
            //       itemCount: imagepath.length,
            //       layout: SwiperLayout.STACK,
            //     ),
            //   ),
            // ),
          ],
        ),
        // MediaQuery.of(context).size.width >= 700
        //                         ? 15.0
        //                         : 5.0,
        //                   ),
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
                  textStyle:
                      const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            ),
            Gap(10),
             Text(
              '     Delta Cable Management Systems are designed to efficiently organize and secure electrical and electronic cables in various settings, be it a facility, residence, or office. Industrial cable wholesale sellers in Saudi Arabia prioritize crafting cables that promote tidy workspaces, minimize trip hazards, prevent short circuits, and ultimately elevate electrical safety and functionality within your environment',
              style: GoogleFonts.abel(fontSize: 20, fontWeight: FontWeight.w300),
            ),
              ]
            ),
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
            Text('Our Products'.toUpperCase(),
             style: TextStyle(
                color: Color.fromARGB(255, 4, 4, 4),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),)
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
                            alignment: Alignment(-pageOffSet.abs() + index, 0),
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
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
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
          child: Image.network("https://www.lkea.in/assets/images/about/2.jpg"),
        ),
        Container(
            color: const Color.fromARGB(255, 255, 255, 255),
            height: 1000,
            // height: MediaQuery.of(context).size.height/1,
            child: MediaQuery.of(context).size.width >= 700
                ? deskBottomSheett()
                : mobiledeskBottomSheett())
      ],
    );
  }
}
