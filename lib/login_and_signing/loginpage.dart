import 'package:firebase_hex/login_and_signing/authentication.dart';
import 'package:firebase_hex/login_and_signing/forgott_password.dart';
import 'package:firebase_hex/login_and_signing/signup_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  final List<String> sliderImages = [
    'assets/image/Illustration1.png',
    'assets/image/Illustration2.png',
    'assets/image/Illustration3.png',
  ];

  final List<String> sliderHeadings = [
    'Gain total control \nof your money',
    'Know where your \nmoney goes',
    'Planning ahead'
  ];
  final List<String> sliderDescription = [
    'Become your own money manager \nand make every cent count',
    'Track your transaction easily,\nwith categories and financial report',
    'Setup your budget for each category \nso you in control'
  ];
  // bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationHelper>(builder: (context, value, child) {
      return Scaffold(
          body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
        child: Container(
        child: Row(
          children: [
            Expanded(
            flex: 3,
            child: Container(
              height: 750,
              width: 300,
              child: CarouselSlider.builder(
                  enableAutoSlider: true,
                  unlimitedMode: true,
                  slideBuilder: (index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(sliderImages[index],height: 500,),
                        // SizedBox(
                          // width: MediaQuery.of(context).size.width / 1.2,
                           Column(
                            children: [
                              Text(
                                sliderHeadings[index],
                                style: GoogleFonts.inter(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w700),
                                textAlign: TextAlign.center,
                              ),
                              Text(sliderDescription[index],
                                  style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey),
                                  textAlign: TextAlign.center),
                            ],
                          ),
                        // )
                      ],
                    );
                  },
                  slideTransform: CubeTransform(),
                  slideIndicator: CircularSlideIndicator(
                    currentIndicatorColor: Colors.deepPurple,
                    indicatorBackgroundColor: Colors.black12,
                    padding: EdgeInsets.only(bottom: 32),
                  ),
                  itemCount: 3),
            ),
          ),
          
            
              Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 80, vertical: 100),
                    child: Column(
                      children: [
                        Text(
                          'Hello ! Welcome Back.',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 65,
                        ),
                        Text(
                          'Login with your data that you entered during your registration.  ',
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 45,
                        ),
                        TextFormField(
                          controller: emailTextController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide:
                                      BorderSide(color: Colors.black12)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide:
                                      BorderSide(color: Colors.black12)),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide:
                                      BorderSide(color: Colors.black12)),
                              hintText: "Email"),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 45,
                        ),
                        TextFormField(
                          obscureText: !value.showPassword,
                          controller: passwordTextController,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  padding: EdgeInsets.only(right: 16),
                                  onPressed: () {
                                    value.changeShowPassword();
                                  },
                                  icon: Icon(
                                    value.showPassword
                                        ? CupertinoIcons.eye_slash_fill
                                        : Icons.remove_red_eye_outlined,
                                    color: Colors.black38,
                                    size: 26,
                                  )),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide:
                                      BorderSide(color: Colors.black12)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide:
                                      BorderSide(color: Colors.black12)),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide:
                                      BorderSide(color: Colors.black12)),
                              hintText: "Password"),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 45,
                        ),
                        TextButton(
                          onPressed: () async {
                            if (emailTextController.text.isEmpty ||
                                passwordTextController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("All fields are required")));
                            } else {
                              value.changeIsLoading();
                              await AuthenticationHelper().logIn(
                                  emailTextController.text,
                                  passwordTextController.text,
                                  context);
                              value.changeIsLoading();
                            }
                          },
                          child: value.isLoading
                              ? SizedBox(
                                  width: 25,
                                  height: 25,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ))
                              : Text(
                                  "Login",
                                  style: GoogleFonts.inter(
                                    color: Color(0xFFFBFBFB),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                          style: ButtonStyle(
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16))),
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.deepPurple)),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 45,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ForgotPasswordPage(),
                                ));
                          },
                          child: Text(
                            "Forgot Password?",
                            style: GoogleFonts.inter(
                              color: Colors.deepPurple,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Dont'? have an account yet? ",
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignUpPage(),
                                    ));
                              },
                              child: Text(
                                "Sing Up",
                                style: GoogleFonts.inter(
                                  color: Colors.deepPurple,
                                  fontSize: 16,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ));
    });
  }
}
      






// import 'package:firebase_hex/login_and_signing/authentication.dart';
// import 'package:firebase_hex/login_and_signing/forgott_password.dart';
// import 'package:firebase_hex/login_and_signing/signup_page.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';

// class LoginPage extends StatelessWidget {
//   LoginPage({super.key});

//   final emailTextController = TextEditingController();

//   final passwordTextController = TextEditingController();

//   // bool isLoading = false;
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AuthenticationHelper>(builder: (context, value, child) {
//       return Scaffold(
       
//         body: Padding(
//           padding: const EdgeInsets.only(left: 10, right: 10, top: 56),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(top: 24.0),
//                   child: TextFormField(
//                     controller: emailTextController,
//                     decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(16),
//                             borderSide: BorderSide(color: Colors.black12)),
//                         enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(16),
//                             borderSide: BorderSide(color: Colors.black12)),
//                         disabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(16),
//                             borderSide: BorderSide(color: Colors.black12)),
//                         hintText: "Email"),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 24.0),
//                   child: TextFormField(
//                     obscureText: !value.showPassword,
//                     controller: passwordTextController,
//                     decoration: InputDecoration(
//                         suffixIcon: IconButton(
//                             padding: EdgeInsets.only(right: 16),
//                             onPressed: () {
//                               value.changeShowPassword();
//                             },
//                             icon: Icon(
//                               value.showPassword
//                                   ? CupertinoIcons.eye_slash_fill
//                                   : Icons.remove_red_eye_outlined,
//                               color: Colors.black38,
//                               size: 26,
//                             )),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(16),
//                             borderSide: BorderSide(color: Colors.black12)),
//                         enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(16),
//                             borderSide: BorderSide(color: Colors.black12)),
//                         disabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(16),
//                             borderSide: BorderSide(color: Colors.black12)),
//                         hintText: "Password"),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 24.0),
//                   child: SizedBox(
//                     width: MediaQuery.of(context).size.width / 1.1,
//                     height: 56,
//                     child: TextButton(
//                       onPressed: () async {
//                         if (emailTextController.text.isEmpty ||
//                             passwordTextController.text.isEmpty) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                   content: Text("All fields are required")));
//                         } else {
//                           value.changeIsLoading();
//                           await AuthenticationHelper().logIn(
//                               emailTextController.text,
//                               passwordTextController.text,
//                               context);
//                           value.changeIsLoading();
//                         }
//                       },
//                       child: value.isLoading
//                           ? SizedBox(
//                               width: 25,
//                               height: 25,
//                               child: CircularProgressIndicator(
//                                 color: Colors.white,
//                                 strokeWidth: 2,
//                               ))
//                           : Text(
//                               "Login",
//                               style: GoogleFonts.inter(
//                                 color: Color(0xFFFBFBFB),
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                       style: ButtonStyle(
//                           shape: MaterialStatePropertyAll(
//                               RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(16))),
//                           backgroundColor:
//                               MaterialStatePropertyAll(Colors.deepPurple)),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 19.0),
//                   child: InkWell(
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => ForgotPasswordPage(),
//                           ));
//                     },
//                     child: Text(
//                       "Forgot Password?",
//                       style: GoogleFonts.inter(
//                         color: Colors.deepPurple,
//                         fontSize: 18,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                     padding: const EdgeInsets.only(top: 19.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           "Dont'? have an account yet? ",
//                           style: GoogleFonts.inter(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         InkWell(
//                           onTap: () {
//                             Navigator.pushReplacement(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => SignUpPage(),
//                                 ));
//                           },
//                           child: Text(
//                             "Sing Up",
//                             style: GoogleFonts.inter(
//                               color: Colors.deepPurple,
//                               fontSize: 16,
//                               decoration: TextDecoration.underline,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ))
//               ],
//             ),
//           ),
//         ),
//       );
//     });
//   }
// }
