 import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class AnimattedText extends StatelessWidget {
  const AnimattedText({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:Container(
child: AnimatedTextKit( 
                animatedTexts: [ 
                  RotateAnimatedText('AWESOME', 
                      textStyle: TextStyle( 
                          fontSize: 30, 
                          color: Colors.white, 
                          backgroundColor: Colors.blue)), 
                  RotateAnimatedText('OPTIMISTIC', 
                      textStyle: TextStyle( 
                          letterSpacing: 3, 
                          fontSize: 30, 
                          fontWeight: FontWeight.bold, 
                          color: Colors.orange)), 
                  RotateAnimatedText( 
                    'DIFFERENT', 
                    textStyle: TextStyle( 
                      fontSize: 30, 
                      decoration: TextDecoration.underline, 
                    ), 
                  ), 
                ], 
                isRepeatingAnimation: true, 
                totalRepeatCount: 10, 
                pause: Duration(milliseconds: 1000), 
              ),
      )
    );
  }
}
 // Row(
                              //   children: [
                              //     InkWell(
                              //       onTap: () {
                              //         Navigator.push(
                              //           context,
                              //           MaterialPageRoute(
                              //               builder: (context) =>
                              //                   ContactUsPage()),
                              //         );
                              //       },
                              //       child: FittedBox(
                              //         child: Container(
                              //           child: Center(
                              //               child: Text(
                              //             "ABOUT US",
                              //             style: GoogleFonts.firaSans(
                              //                 fontWeight: FontWeight.w600),
                              //           )),
                              //           width:
                              //               MediaQuery.of(context).size.width /
                              //                   13,
                              //           height:
                              //               MediaQuery.of(context).size.height /
                              //                   16,
                              //           decoration: BoxDecoration(
                              //             color: const Color.fromRGBO(
                              //                 249, 156, 6, 1.0),
                              //             // borderRadius: BorderRadius.circular(20),
                              //             boxShadow: [
                              //               BoxShadow(
                              //                   color: Colors.white,
                              //                   offset: Offset(8, 8),
                              //                   blurRadius: 1),
                              //             ],
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //     Gap(15),
                              //     InkWell(
                              //       onTap: () {
                              //         Navigator.push(
                              //           context,
                              //           MaterialPageRoute(
                              //               builder: (context) =>
                              //                   ContactUsPage()),
                              //         );
                              //       },
                              //       child: FittedBox(
                              //         child: Container(
                              //           child: Center(
                              //               child: Text(
                              //             "CONTACT US",
                              //             style: GoogleFonts.firaSans(
                              //                 fontWeight: FontWeight.w500,
                              //                 color: Color.fromRGBO(
                              //                     249, 156, 6, 1.0)),
                              //           )),
                              //           width:
                              //               MediaQuery.of(context).size.width /
                              //                   12,
                              //           height:
                              //               MediaQuery.of(context).size.height /
                              //                   16,
                              //           decoration: BoxDecoration(
                              //             color: Colors.white,
                              //             // borderRadius: BorderRadius.circular(20),
                              //             boxShadow: [
                              //               BoxShadow(
                              //                   color: Color.fromRGBO(
                              //                       249, 156, 6, 1.0),
                              //                   // blurRadius: 4,
                              //                   offset: Offset(8, 8),
                              //                   blurRadius: 1),
                              //             ],
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //     //       ElevatedButton(onPressed: (){
                              //     //     Navigator.push(
                              //     //       context,
                              //     //       MaterialPageRoute(builder: (context) =>  ContactUsPage()),
                              //     //     );
                              //     // }, child: Text("asdfghjk")),
                              //   ],
                              // ),





// Transform.translate(
                              //   offset: Offset(0.0, -offset * 0.5),
                              // child: Column(
                              //                     mainAxisAlignment: MainAxisAlignment.center,

                              //   children: [
                              //      Text(
                              // 'Parallax Content',
                              // style: TextStyle(
                              //   fontSize: 24.0,
                              //   fontWeight: FontWeight.bold,
                              // ),
                              //                   ),
                              //                   SizedBox(height: 16.0),
                              //                   Text(
                              // 'Your content goes here...',
                              // style: TextStyle(fontSize: 16.0),
                              //                   ),

                              //   ],
                              // ),
                              // ),