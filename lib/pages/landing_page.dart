import 'dart:ui';
import 'package:firebase_hex/pages/bottom_sheet.dart';
import 'package:firebase_hex/responsive/landing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:google_fonts/google_fonts.dart';

class LandinPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: ResponsiveLandingPage(
            mobileAppBar: MobilLanding(), desktopAppBar: DesktopLanding()));
  }
}

class DesktopLanding extends StatelessWidget {
  const DesktopLanding({Key? key}) : super(key: key);

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
                'https://i0.wp.com/www.compliancesigns.com/blog/wp-content/uploads/2023/05/5-Electrical-Safety-Tips.jpg?fit=1200%2C630&ssl=1',
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
                              color: Colors.white,
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
                            color: Colors.white),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Navigator.pushNamed(
                          //     context, '/cart');
                        },
                        child: Text(
                          'CHECKOUT',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 54, 98, 98)),
                          minimumSize: MaterialStateProperty.all(Size(150, 50)),
                        ),
                      ),
                      SizedBox(
                        height: 320,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: Text(
                          'Industrial Cable Management System for your Electrical Projects!',
                          style: GoogleFonts.abel(
                              textStyle: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                )),
            Positioned(
              right: 100,
              top: 30,
              child: Container(
                width: 450,
                height: 900,
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
                              style: GoogleFonts.abrilFatface(
                                textStyle: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 54, 98, 98),
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
        Padding(
          padding: const EdgeInsets.only(left: 50, bottom: 40),
          child: Text(
            '      Delta Cable Management Systems are used to organise and secure electrical or electronic cables and wires  \nin a facility, home, or office. The main goal of Industrial Cable Manufacturers in India\n is to manufacture cables that maintain a clean and organized workspace, reduce trip hazards, eliminate short\ncircuits and enhance your overall electrical safety and functionality',
            style: GoogleFonts.abel(fontSize: 20, fontWeight: FontWeight.w300),
          ),
        ),
        Container(
          height: 550,
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                  child: Container(
                color: Colors.white,
              )),
              Expanded(
                  child: Container(
                color: Colors.white,
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

class MobilLanding extends StatelessWidget {
  const MobilLanding({super.key});

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
                'https://i0.wp.com/www.compliancesigns.com/blog/wp-content/uploads/2023/05/5-Electrical-Safety-Tips.jpg?fit=1200%2C630&ssl=1',
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
                              color: Colors.white,
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
                            color: Colors.white),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Navigator.pushNamed(
                          //     context, '/cart');
                        },
                        child: Text(
                          'CHECKOUT',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 54, 98, 98)),
                          minimumSize: MaterialStateProperty.all(Size(150, 50)),
                        ),
                      ),
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
              top: 230,
              child: Container(
                width: 450,
                height: 900,
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
                              style: GoogleFonts.abrilFatface(
                                textStyle: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 54, 98, 98),
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
         Padding(
                        padding: const EdgeInsets.only(left: 20,right: 10),
                        child: Text(
                          'Industrial Cable Management System for your Electrical Projects!',
                          style: GoogleFonts.abel(
                              textStyle: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold)),
                        ),
                      ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right:20 ),
          child: Text(
            '\n      Delta Cable Management Systems are used to organise and secure electrical or electronic cables and wires  \nin a facility, home, or office. The main goal of Industrial Cable Manufacturers in India\n is to manufacture cables that maintain a clean and organized workspace, reduce trip hazards, eliminate short\ncircuits and enhance your overall electrical safety and functionality\n',
            style: GoogleFonts.abel(fontSize: 20, fontWeight: FontWeight.w300),
          ),
        ),
        Container(
          height: 550,
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                  child: Container(
                color: Colors.white,
              )),
              Expanded(
                  child: Container(
                color: Colors.white,
              ))
            ],
          ),
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
  }}
 // return Container(
    //   color: Colors.black,
    //   child: Column(
    //     children: [
    //       Row(
    //         children: [
    //           Container(
    //             width: MediaQuery.of(context).size.width / 3,
    //             color: Colors.transparent,
    //             child: Expanded(
    //                 child: Padding(
    //               padding: const EdgeInsets.symmetric(vertical: 30),
    //               child: Column(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 crossAxisAlignment: CrossAxisAlignment.end,
    //                 children: [
    //                   Text(
    //                     'Delta',
    //                     style: GoogleFonts.pacifico(
    //                       textStyle: TextStyle(
    //                         color: Color.fromARGB(255, 122, 102, 54),
    //                         fontSize: 35,
    //                       ),
    //                     ),
    //                   ),
    //                   SizedBox(
    //                     height: MediaQuery.of(context).size.height / 30,
    //                   ),
    //                   TextButton(
    //                       onPressed: () {},
    //                       child: Text(
    //                         "About Us\n",
    //                         style: TextStyle(
    //                             fontSize: 15,
    //                             fontWeight: FontWeight.bold,
    //                             color: Colors.white),
    //                       )),
    //                   TextButton(
    //                       onPressed: () {},
    //                       child: Text(
    //                         "Contact Us\n",
    //                         style: TextStyle(
    //                             fontSize: 15,
    //                             fontWeight: FontWeight.bold,
    //                             color: Colors.white),
    //                       )),
    //                   user != null
    //                       ? TextButton(
    //                           onPressed: () {
    //                             FirebaseAuth.instance.signOut();
    //                           },
    //                           child: Text(
    //                             'Logout',
    //                             style: TextStyle(
    //                                 fontSize: 15,
    //                                 fontWeight: FontWeight.bold,
    //                                 color: Colors.white),
    //                           ))
    //                       : SizedBox(),
    //                 ],
    //                 // ),
    //               ),
    //             )),
    //           ),
    //           Container(
    //             width: MediaQuery.of(context).size.width / 1.6,
    //             color: Colors.transparent,
    //             child: Expanded(
    //               // flex: 2,
    //               child: Padding(
    //                 padding: const EdgeInsets.symmetric(
    //                     horizontal: 25, vertical: 40),
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Text(
    //                       'Address\n',
    //                       style: TextStyle(
    //                           color: Colors.white,
    //                           fontWeight: FontWeight.bold,
    //                           fontSize: 20),
    //                     ),
    //                     Text(
    //                       'DELTA NATIONALS Baladiya St,\nAlanwar Center P.O.Box: 101447, jiddah 21311\nTel: 0126652671, jiddah -Soudi Arabia\nE-mail : sales@deltanationals.com',
    //                       style: TextStyle(fontSize: 15, color: Colors.white),
    //                     ),
    //                     SizedBox(
    //                       height: MediaQuery.of(context).size.height / 20,
    //                     ),
    //                     Text(
    //                       'Contact Us\n',
    //                       style: TextStyle(
    //                           color: Colors.white,
    //                           fontWeight: FontWeight.bold,
    //                           fontSize: 20),
    //                     ),
    //                     Text(
    //                       '+91 6238636935',
    //                       style: TextStyle(color: Colors.white, fontSize: 15),
    //                     )
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),

    //       // Expanded(
    //       //     flex: 3,
    //       Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: 15),
    //         child: Container(
    //           color: Colors.black,
    //           child: Padding(
    //             padding: const EdgeInsets.only(right: 0),
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.start,
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 SizedBox(
    //                   height: MediaQuery.of(context).size.height / 20,
    //                 ),
    //                 Text(
    //                   'Write To Us',
    //                   style: TextStyle(
    //                       color: Colors.white,
    //                       fontWeight: FontWeight.bold,
    //                       fontSize: 20),
    //                 ),
    //                 SizedBox(
    //                   height: MediaQuery.of(context).size.height / 20,
    //                 ),
    //                 Row(
    //                   children: [
    //                     SizedBox(
    //                         width: MediaQuery.of(context).size.width / 2.5,
    //                         child: CustTextField('name', name, context)),
    //                     // _TextField("C", name, context),
    //                     SizedBox(
    //                       width: MediaQuery.of(context).size.width / 35,
    //                     ),
    //                     SizedBox(
    //                         width: MediaQuery.of(context).size.width / 2,
    //                         child: CustTextField(
    //                             "Company Name", companyName, context))
    //                     // _TextField("Company Name", companyName, context)
    //                   ],
    //                 ),
    //                 SizedBox(
    //                   height: MediaQuery.of(context).size.height / 25,
    //                 ),
    //                 Row(
    //                   children: [
    //                     SizedBox(
    //                         width: MediaQuery.of(context).size.width / 2.5,
    //                         child: CustTextField("Email", email, context)),
    //                     SizedBox(
    //                       width: MediaQuery.of(context).size.width / 35,
    //                     ),
    //                     SizedBox(
    //                         width: MediaQuery.of(context).size.width / 2,
    //                         child: CustTextField(
    //                             'Phone Number', phoneNumber, context))
    //                   ],
    //                 ),
    //                 SizedBox(
    //                   height: MediaQuery.of(context).size.height / 25,
    //                 ),
    //                 Container(
    //                   width: MediaQuery.of(context).size.width / 1,
    //                   child: Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     mainAxisAlignment: MainAxisAlignment.start,
    //                     children: [
    //                       TextFormField(
    //                         controller: textarea,
    //                         keyboardType: TextInputType.multiline,
    //                         style: TextStyle(color: Colors.white),
    //                         maxLines: 5,
    //                         decoration: InputDecoration(
    //                             hintText: "Message",
    //                             hintStyle: TextStyle(color: Colors.white),
    //                             border: OutlineInputBorder(
    //                               borderSide: BorderSide(
    //                                 color: Colors
    //                                     .white, // Set border color to white
    //                                 width: 2.0,
    //                               ),
    //                             ),
    //                             enabledBorder: OutlineInputBorder(
    //                                 borderSide: BorderSide(
    //                                     color: Colors.white, width: 2))),
    //                       ),
    //                       SizedBox(
    //                         height: MediaQuery.of(context).size.height / 25,
    //                       ),
    //                       ElevatedButton(
    //                         onPressed: () {
    //                           print(textarea.text);
    //                         },
    //                         child: Text(
    //                           'SUBMIT',
    //                           style: TextStyle(color: Colors.black),
    //                         ),
    //                         style: ButtonStyle(
    //                           backgroundColor:
    //                               MaterialStateProperty.all(Colors.white),
    //                           minimumSize:
    //                               MaterialStateProperty.all(Size(150, 50)),
    //                         ),
    //                       ),
    //                       SizedBox(
    //                         height: MediaQuery.of(context).size.height / 25,
    //                       ),
    //                     ],
    //                   ),
    //                 )
    //               ],
    //             ),
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
    // );