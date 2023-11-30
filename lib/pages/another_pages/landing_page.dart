import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

class DesktopLanding extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    // MediaQueryData queryDataa = MediaQuery.of(context);
    MediaQueryData queryData = MediaQuery.of(context);
    Widget industrialCableText = queryData.size.width >= 950
        ? Padding(
            padding: EdgeInsets.only(left: 50),
            child: Text(
              'Industrial Cable Management System for your Electrical Projects!',
              style: GoogleFonts.abel(
                textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          )
        : SizedBox();

    Widget industrialCableTextt = queryData.size.width >= 950
        ? SizedBox()
        : Padding(
            padding: EdgeInsets.only(left: 50),
            child: Text(
              '\nIndustrial Cable Management System for your Electrical Projects!\n',
              style: GoogleFonts.abel(
                textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          );
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
                "https://knowhow.distrelec.com/wp-content/uploads/2021/11/iStock-1477511739.jpg",
                // 'https://i0.wp.com/www.compliancesigns.com/blog/wp-content/uploads/2023/05/5-Electrical-Safety-Tips.jpg?fit=1200%2C630&ssl=1',
                width: 200,
                height: 200,
                // color: Colors.amber,
                fit: BoxFit.cover,
              ),
            ),
            BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 00, sigmaY: 0.0),
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
                              fontSize: 35,
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(2.0, 2.0),
                                  blurRadius: 3.0,
                                  color: Colors.grey.withOpacity(0.5),
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
                      // ElevatedButton(
                        
                      //   onPressed: () async {
                      //     context
                      //         .read<AddressProvider>()
                      //         .isUserDataAvailable(context);
                      //   },
                       
                      //   child: Text(
                      //     'CHECKOUT',
                      //     style: TextStyle(color: Colors.white),
                      //   ),
                      //   style: ButtonStyle(
                      //     backgroundColor: MaterialStateProperty.all(
                      //         const Color.fromARGB(255, 238, 131, 38)),
                      //     minimumSize: MaterialStateProperty.all(Size(150, 50)),
                      //   ),
                      // ),
                      SizedBox(
                        height: 320,
                      ),
                      industrialCableText,
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                )),
            Positioned(
              right: MediaQuery.of(context).size.width * 0.1,
              top: 30,
              child: Container(
                width: 450,
                height: 850,
                child: Swiper(
                  itemWidth: 400,
                  itemHeight: 360,
                  loop: true,
                  duration: 1200,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Container(
                      // color: Colors.white,
                      // decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 2)),
                      child: Column(
                        children: [
                          Image.asset(imagepath[index]),
                          Text(headingss[index],
                              style: GoogleFonts.barlow(
                                textStyle: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 238, 131, 38),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700),
                              )),
                          Text(
                            descriptionn[index],
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: imagepath.length,
                  layout: SwiperLayout.STACK,
                ),
              ),
            ),
          ],
        ),
        industrialCableTextt,
        Padding(
          padding: const EdgeInsets.only(left: 50, bottom: 40),
          child: Text(
            '          Delta Cable Management Systems are designed to efficiently organize and secure electrical and electronic\ncables in various settings, be it a facility, residence, or office. Industrial cable wholesale sellers in Saudi Arabia\nprioritize crafting cables that promote tidy workspaces, minimize trip hazards, prevent short circuits, and ultimately\nelevate electrical safety and functionality within your environment',
            style: GoogleFonts.abel(fontSize: 20, fontWeight: FontWeight.w300),
          ),
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
                child: Image.network("https://www.lkea.in/assets/images/about/2.jpg",
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

class MobileLanding extends StatelessWidget {
  const MobileLanding({super.key});

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
                                "https://knowhow.distrelec.com/wp-content/uploads/2021/11/iStock-1477511739.jpg",

                // 'https://i0.wp.com/www.compliancesigns.com/blog/wp-content/uploads/2023/05/5-Electrical-Safety-Tips.jpg?fit=1200%2C630&ssl=1',
                // 'https://electrek.co/wp-content/uploads/sites/3/2021/05/bird-three-header-scooter.jpg?quality=82&strip=all',
                width: 200,
                height: 200,
                // color: Colors.amber,
                fit: BoxFit.cover,
              ),
            ),
            BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 00, sigmaY: 0.0),
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
                                  color: Colors.grey.withOpacity(0.5),
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
                      // ElevatedButton(
                      //   onPressed: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => const Delivarypage()),
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
                      SizedBox(
                        height: 320,
                      ),
                      SizedBox(
                        height: 280,
                      ),
                    ],
                  ),
                )),
            Positioned(
              right: 30,
              left: 30,
              top: 230,
              child: Container(
                width: 450,
                height: 880,
                // color: Colors.white,
                // color: Colors.transparent,
                child: Swiper(
                  itemWidth: 400,
                  itemHeight: 360,
                  loop: true,
                  duration: 1200,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Container(
                      // color: Colors.white,
                      // decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 2)),
                      child: Column(
                        children: [
                          Image.asset(imagepath[index]),
                          Text(headingss[index],
                              style: GoogleFonts.barlow(
                                textStyle: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 238, 131, 38),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700),
                              )),
                          Text(
                            descriptionn[index],
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: imagepath.length,
                  layout: SwiperLayout.STACK,
                ),
              ),
            ),
          ],
        ),
        // MediaQuery.of(context).size.width >= 700
        //                         ? 15.0
        //                         : 5.0,
        //                   ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 10,
          ),
          child: Text(
            'Industrial Cable Management System for your Electrical Projects!',
            style: GoogleFonts.abel(
                textStyle:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Text(
            '\n      Delta Cable Management Systems are designed to efficiently organize and secure electrical and electronic\ncables in various settings, be it a facility, residence, or office. Industrial cable wholesale sellers in Saudi Arabia\nprioritize crafting cables that promote tidy workspaces, minimize trip hazards, prevent short circuits, and ultimately\nelevate electrical safety and functionality within your environment\n',
            style: GoogleFonts.abel(fontSize: 20, fontWeight: FontWeight.w300),
          ),
        ),
        // Container(
        //   height: 550,
        //   width: double.infinity,
        // child: Row(
        //   children: [
        //     Expanded(
        //         child: Container(
        //       color: Colors.white,
        //     )),
        //     Expanded(
        //         child: Container(
        //       color: Colors.white,
        //     ))
        //   ],
        // ),
        // ),
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
                  child: Text("RENOWNED MANUFACTURERS OF WORLD CLASS ELECTRICAL AND BRASS COMPONENTS",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),),
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
