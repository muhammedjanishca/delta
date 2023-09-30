import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_hex/login_and_signing/authentication.dart';
import 'package:firebase_hex/login_and_signing/loginpage.dart';
import 'package:firebase_hex/responsive/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../provider/Text_color.dart';
import 'email_otp.dart';
import 'mail_verification.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSignUp(
        mobileSignUp: mobilesignup(), desktopSignUp: DeskSignUp());
  }
}

// ignore: must_be_immutable
class DeskSignUp extends StatelessWidget {
  DeskSignUp({super.key});

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final nameTextController = TextEditingController();
  final mobileNumTextController = TextEditingController(text: "+91");
  final otpTextController = TextEditingController();

  String? verificationId;
  EmailOTP emailOtpAuth = EmailOTP();

  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      'assets/image/Illustration1.png',
      'assets/image/Illustration2.png',
      'assets/image/Illustration3.png',
    ];

    final List<String> imagecap1 = [
      'Gain total control \nof your money',
      'Know where your \nmoney goes',
      'Planning ahead'
    ];
    final List<String> imagecap2 = [
      'Become your own money manager \nand make every cent count',
      'Track your transaction easily,\nwith categories and financial report',
      'Setup your budget for each category \nso you in control'
    ];
    return Consumer<AuthenticationHelper>(builder: (context, value, child) {
      return Scaffold(
        body: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 80,
            ),
            child: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: TextButton(
                              onPressed: () {
                                // Add navigation functionality here to pop the current route
                                Navigator.of(context).pop();
                              },
                              child: Consumer<TextProvider>(
                                builder: (context, textProvider, child) {
                                  return Text(
                                    '<<HOME>>',
                                    style: TextStyle(
                                        color: textProvider.textColor),
                                  );
                                },
                              ),
                            ),
                          ),
                          Container(
                            // height: 300,
                            height: MediaQuery.of(context).size.height / 01,
                            // width: ,
                            child: CarouselSlider.builder(
                              enableAutoSlider: true,
                              autoSliderTransitionCurve: Curves.bounceOut,
                              unlimitedMode: true,
                              itemCount: 3,
                              scrollDirection: Axis.horizontal,
                              slideIndicator: CircularSlideIndicator(
                                  indicatorRadius: 0,
                                  itemSpacing: 20,
                                  alignment: Alignment.bottomCenter,
                                  padding: const EdgeInsets.only(top: 30)),
                              slideBuilder: (index) {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 76),
                                      child: SizedBox(
                                        height: 312,
                                        width: 312,
                                        child: Image.asset(
                                          images[index],
                                          scale: 2,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 41),
                                      child: Text(imagecap1[index],
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.inter(
                                              fontSize: 32,
                                              fontWeight: FontWeight.w700,
                                              color: const Color(0xFF212224))),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 17),
                                      child: Text(
                                        imagecap2[index],
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.inter(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xFF90909F)),
                                      ),
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 70, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Create your account',
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 65,
                              ),
                              Text(
                                'Enter the fields below to get started',
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 45,
                              ),
                              SizedBox(
                                // width: MediaQuery.of(context).size.width / 1.1,
                                height: 50,
                                child: TextButton(
                                  onPressed: () async {
                                    value.changeIsLoadingGIn();
                                    await value.signInWithGoogle(context);
                                    value.changeIsLoadingGIn();
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: value.isLoadingGIn
                                        ? [
                                            SizedBox(
                                                width: 25,
                                                height: 25,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Color.fromARGB(
                                                      255, 76, 138, 131),
                                                  strokeWidth: 2,
                                                ))
                                          ]
                                        : [
                                            Image.asset(
                                                'assets/image/google.png'),
                                            Text(
                                              " Sign Up with Google",
                                              style: GoogleFonts.inter(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                  ),
                                  style: ButtonStyle(
                                      shape: MaterialStatePropertyAll(
                                          RoundedRectangleBorder(
                                              side: BorderSide(
                                                  width: 0.50,
                                                  color: Colors.black26),
                                              borderRadius:
                                                  BorderRadius.circular(1))),
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.white)),
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 45,
                              ),
                              Text(
                                'Or with',
                                style: GoogleFonts.inter(
                                  color: Color(0xFF90909F),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  height: 1.29,
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 45,
                              ),
                              TextFormField(
                                controller: nameTextController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(1),
                                        borderSide:
                                            BorderSide(color: Colors.black12)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(1),
                                        borderSide:
                                            BorderSide(color: Colors.black12)),
                                    disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(1),
                                        borderSide:
                                            BorderSide(color: Colors.black12)),
                                    hintText: "Name"),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 45,
                              ),
                              TextFormField(
                                controller: emailTextController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(1),
                                        borderSide:
                                            BorderSide(color: Colors.black12)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(1),
                                        borderSide:
                                            BorderSide(color: Colors.black12)),
                                    disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(1),
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
                                        borderRadius: BorderRadius.circular(1),
                                        borderSide:
                                            BorderSide(color: Colors.black12)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(1),
                                        borderSide:
                                            BorderSide(color: Colors.black12)),
                                    disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(1),
                                        borderSide:
                                            BorderSide(color: Colors.black12)),
                                    hintText: "Password"),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 45,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Checkbox(
                                      focusColor:
                                          Color.fromARGB(255, 76, 138, 131),
                                      overlayColor: MaterialStatePropertyAll(
                                        Color.fromARGB(255, 76, 138, 131),
                                      ),
                                      value: value.isChecked,
                                      onChanged: (value1) {
                                        value.changeIsChecked();
                                      }),
                                  Text(
                                    "By signing up, you agree to the Terms of Service and Privacy Policy",
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      // fontWeight: FontWeight.w500,
                                      // height: 1.29,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 45,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.1,
                                height: 50,
                                child: TextButton(
                                  onPressed: () async {
                                    if (nameTextController.text.isEmpty ||
                                        emailTextController.text.isEmpty ||
                                        passwordTextController.text.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "All fields are required")));
                                    } else {
                                      value.changeIsLoading();

                                      String otpId = await emailOtpAuth
                                          .sendOtp(emailTextController.text);
                                      //  await AuthenticationHelper().signUp(
                                      //      emailTextController.text,
                                      //      passwordTextController.text,
                                      //      nameTextController.text,
                                      //      context);

                                      value.changeIsLoading();

                                      // Navigator.of(context).push(MaterialPageRoute(
                                      //     builder: (context) =>
                                      //         MailVerificationPgae(
                                      //             name: nameTextController.text,
                                      //             email: emailTextController.text,
                                      //             password:
                                      //                 passwordTextController.text,
                                      //             otpId: otpId)));
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MailVerificationPgae(
                                                      name: nameTextController
                                                          .text,
                                                      email: emailTextController
                                                          .text,
                                                      password:
                                                          passwordTextController
                                                              .text,
                                                      otpId: otpId)));
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
                                          "Sign Up",
                                          style: GoogleFonts.inter(
                                            color: Color(0xFFFBFBFB),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                  style: ButtonStyle(
                                      shape: MaterialStatePropertyAll(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(1))),
                                      backgroundColor: MaterialStatePropertyAll(
                                        Color.fromARGB(255, 76, 138, 131),
                                      )),
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 45,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.1,
                                height: 56,
                                child: TextButton(
                                  onPressed: () async {
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      builder: (context) {
                                        return Consumer<AuthenticationHelper>(
                                            builder: (context, value, child) {
                                          {
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: MediaQuery.of(context)
                                                      .viewInsets
                                                      .bottom,
                                                  top: 20.0,
                                                  right: 20,
                                                  left: 20),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      "Continue with Mobile OTP",
                                                      style: GoogleFonts.inter(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  Text(
                                                      "Please enter your mobile number , we will send you an OTP to your mobile number."),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      TextFormField(
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        controller:
                                                            mobileNumTextController,
                                                        decoration:
                                                            InputDecoration(
                                                                suffixIcon:
                                                                    TextButton(
                                                                  child: value
                                                                          .isLoadingotpSend
                                                                      ? SizedBox(
                                                                          width:
                                                                              15,
                                                                          height:
                                                                              15,
                                                                          child:
                                                                              CircularProgressIndicator(
                                                                            color:
                                                                                Colors.deepPurple,
                                                                            strokeWidth:
                                                                                2,
                                                                          ))
                                                                      : Text(
                                                                          "Send OTP",
                                                                          style:
                                                                              GoogleFonts.inter(fontWeight: FontWeight.bold),
                                                                        ),
                                                                  onPressed:
                                                                      () async {
                                                                    if (mobileNumTextController.text ==
                                                                            "+91" ||
                                                                        mobileNumTextController
                                                                            .text
                                                                            .isEmpty) {
                                                                      value
                                                                          .changeShowMobError();
                                                                    } else {
                                                                      value
                                                                          .changeShowMobError();
                                                                      value
                                                                          .changeIsLoadingotpSend();
                                                                      await FirebaseAuth.instance.verifyPhoneNumber(
                                                                          phoneNumber: mobileNumTextController.text,
                                                                          verificationCompleted: (PhoneAuthCredential authCredential) async {
                                                                            User?
                                                                                user =
                                                                                FirebaseAuth.instance.currentUser;

                                                                            if (authCredential.smsCode !=
                                                                                null) {
                                                                              try {
                                                                                await user!.linkWithCredential(authCredential);
                                                                              } on FirebaseAuthException catch (e) {
                                                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                                                                                if (e.code == 'provider-already-linked') {
                                                                                  await FirebaseAuth.instance.signInWithCredential(authCredential);
                                                                                }
                                                                              }
                                                                            }
                                                                          },
                                                                          verificationFailed: (FirebaseAuthException exception) {
                                                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(exception.toString())));
                                                                            if (exception.code ==
                                                                                'invalid-phone-number') {
                                                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("The phone number entered is invalid!")));
                                                                            }
                                                                          },
                                                                          codeSent: (String verificationId, int? forceResendingToken) {
                                                                            this.verificationId =
                                                                                verificationId;
                                                                          },
                                                                          codeAutoRetrievalTimeout: (String timeout) {
                                                                            return null;
                                                                          });

                                                                      value
                                                                          .changeIsLoadingotpSend();
                                                                    }
                                                                  },
                                                                ),
                                                                border: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            16),
                                                                    borderSide: BorderSide(
                                                                        color: Colors
                                                                            .black12)),
                                                                enabledBorder: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            16),
                                                                    borderSide: BorderSide(
                                                                        color: Colors
                                                                            .black12)),
                                                                disabledBorder: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            16),
                                                                    borderSide: BorderSide(
                                                                        color: Colors
                                                                            .black12)),
                                                                hintText:
                                                                    "Mobile number"),
                                                      ),
                                                      value.showMobError
                                                          ? Text(
                                                              "Mobile number is required",
                                                              style: GoogleFonts
                                                                  .inter(
                                                                      color: Colors
                                                                          .red,
                                                                      fontSize:
                                                                          12),
                                                            )
                                                          : SizedBox()
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        TextFormField(
                                                          keyboardType:
                                                              TextInputType
                                                                  .phone,
                                                          controller:
                                                              otpTextController,
                                                          decoration: InputDecoration(
                                                              border: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          1),
                                                                  borderSide: BorderSide(
                                                                      color: Colors
                                                                          .black12)),
                                                              enabledBorder: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          1),
                                                                  borderSide: BorderSide(
                                                                      color: Colors
                                                                          .black12)),
                                                              disabledBorder: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          1),
                                                                  borderSide:
                                                                      BorderSide(
                                                                          color: Colors.black12)),
                                                              hintText: "OTP"),
                                                        ),
                                                        value.showOtperror
                                                            ? Text(
                                                                "OTP is required",
                                                                style: GoogleFonts
                                                                    .inter(
                                                                        color: Colors
                                                                            .red,
                                                                        fontSize:
                                                                            12),
                                                              )
                                                            : SizedBox()
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10.0,
                                                            bottom: 10),
                                                    child: SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              1.1,
                                                      height: 56,
                                                      child: TextButton(
                                                        onPressed: () async {
                                                          if (otpTextController
                                                              .text.isEmpty) {
                                                            value
                                                                .changeShowOtperror();
                                                          } else {
                                                            value
                                                                .changeShowOtperror();
                                                            value
                                                                .changeIsLoadingotp();

                                                            try {
                                                              await FirebaseAuth
                                                                  .instance
                                                                  .signInWithCredential(
                                                                      PhoneAuthProvider
                                                                          .credential(
                                                                verificationId:
                                                                    verificationId
                                                                        .toString(),
                                                                smsCode:
                                                                    otpTextController
                                                                        .text,
                                                              ));

                                                              Navigator.pop(
                                                                  context);
                                                              //                                       Navigator.pushReplacement(
                                                              // context,
                                                              // MaterialPageRoute(
                                                              //   builder: (context) => HomePage(),
                                                              // ));
                                                            } catch (e) {
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      SnackBar(
                                                                          content:
                                                                              Text(e.toString())));
                                                            }

                                                            value
                                                                .changeIsLoadingotp();
                                                          }
                                                        },
                                                        child: value
                                                                .isLoadingotp
                                                            ? SizedBox(
                                                                width: 25,
                                                                height: 25,
                                                                child:
                                                                    CircularProgressIndicator(
                                                                  color: Colors
                                                                      .white,
                                                                  strokeWidth:
                                                                      2,
                                                                ))
                                                            : Text(
                                                                "Sign Up",
                                                                style:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  color: Color(
                                                                      0xFFFBFBFB),
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                        style: ButtonStyle(
                                                            shape: MaterialStatePropertyAll(
                                                                RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            1))),
                                                            backgroundColor:
                                                                MaterialStatePropertyAll(
                                                                    const Color
                                                                            .fromARGB(
                                                                        255,
                                                                        171,
                                                                        183,
                                                                        58))),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }
                                        });
                                      },
                                    ).then((_) => {
                                          if (FirebaseAuth
                                                  .instance.currentUser !=
                                              null)
                                            {Navigator.pop(context)}
                                        });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.mobile_friendly,
                                          color: Colors.white),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          "Sign Up with Mobile",
                                          style: GoogleFonts.inter(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  style: ButtonStyle(
                                      shape: MaterialStatePropertyAll(
                                          RoundedRectangleBorder(
                                              side: BorderSide(
                                                  width: 0.50,
                                                  color: Colors.black26),
                                              borderRadius:
                                                  BorderRadius.circular(1))),
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.black)),
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 45,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Alreay have an account? ',
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
                                            builder: (context) => LoginPage(),
                                          ));
                                    },
                                    child: Text(
                                      "Login",
                                      style: GoogleFonts.inter(
                                        color:
                                            Color.fromARGB(255, 76, 138, 131),
                                        fontSize: 16,
                                        // decoration: TextDecoration.underline,
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
            ),
          ),
        ),
      );
    });
  }
}

// ignore: must_be_immutable

// ignore: must_be_immutable
class mobilesignup extends StatelessWidget {
  mobilesignup({super.key});

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final nameTextController = TextEditingController();
  final mobileNumTextController = TextEditingController(text: "+91");
  final otpTextController = TextEditingController();

  String? verificationId;
  EmailOTP emailOtpAuth = EmailOTP();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationHelper>(builder: (context, value, child) {
      return Scaffold(
        body: SizedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  'Create your account',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 65,
                ),
                Text(
                  'Enter the fields below to get started',
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 45,
                ),
                SizedBox(
                  // width: MediaQuery.of(context).size.width / 1.1,
                  height: 50,
                  child: TextButton(
                    onPressed: () async {
                      value.changeIsLoadingGIn();
                      await value.signInWithGoogle(context);
                      value.changeIsLoadingGIn();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: value.isLoadingGIn
                          ? [
                              SizedBox(
                                  width: 25,
                                  height: 25,
                                  child: CircularProgressIndicator(
                                    color: Colors.deepPurple,
                                    strokeWidth: 2,
                                  ))
                            ]
                          : [
                              Image.asset('assets/image/google.png'),
                              Text(
                                " Sign Up with Google",
                                style: GoogleFonts.inter(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                    ),
                    style: ButtonStyle(
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            side:
                                BorderSide(width: 0.50, color: Colors.black26),
                            borderRadius: BorderRadius.circular(16))),
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.white)),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 45,
                ),
                Text(
                  'Or with',
                  style: GoogleFonts.inter(
                    color: Color(0xFF90909F),
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    height: 1.29,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 45,
                ),
                TextFormField(
                  controller: nameTextController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.black12)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.black12)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.black12)),
                      hintText: "Name"),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 45,
                ),
                TextFormField(
                  controller: emailTextController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.black12)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.black12)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.black12)),
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
                          borderSide: BorderSide(color: Colors.black12)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.black12)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.black12)),
                      hintText: "Password"),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 45,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                        focusColor: Colors.deepPurple,
                        overlayColor:
                            MaterialStatePropertyAll(Colors.deepPurple),
                        value: value.isChecked,
                        onChanged: (value1) {
                          value.changeIsChecked();
                        }),
                    Text(
                      "By signing up, you agree to the Terms\n of Service and Privacy Policy",
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        // fontWeight: FontWeight.w500,
                        // height: 1.29,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 45,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.1,
                  height: 50,
                  child: TextButton(
                    onPressed: () async {
                      if (nameTextController.text.isEmpty ||
                          emailTextController.text.isEmpty ||
                          passwordTextController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("All fields are required")));
                      } else {
                        value.changeIsLoading();

                        // String otpId = await emailOtpAuth
                        //     .sendOtp(emailTextController.text);
                        await AuthenticationHelper().signUp(
                            emailTextController.text,
                            passwordTextController.text,
                            nameTextController.text,
                            context);

                        value.changeIsLoading();

                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) =>
                        //         MailVerificationPgae(
                        //             name: nameTextController.text,
                        //             email: emailTextController.text,
                        //             password:
                        //                 passwordTextController.text,
                        //             otpId: otpId)));
                        //  Navigator.pushReplacement(
                        //           context,
                        //           MaterialPageRoute(
                        //               builder: (context) =>
                        //               MailVerificationPgae(
                        //                   name: nameTextController.text,
                        //                   email: emailTextController.text,
                        //                   password: passwordTextController.text,
                        //                   otpId: otpId)

                        //                   ));
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
                            "Sign Up",
                            style: GoogleFonts.inter(
                              color: Color(0xFFFBFBFB),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                    style: ButtonStyle(
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16))),
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.deepPurple)),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 45,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.1,
                  height: 56,
                  child: TextButton(
                    onPressed: () async {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                          return Consumer<AuthenticationHelper>(
                              builder: (context, value, child) {
                            {
                              return Padding(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom,
                                    top: 20.0,
                                    right: 20,
                                    left: 20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Continue with Mobile OTP",
                                        style: GoogleFonts.inter(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                        "Please enter your mobile number , we will send you an OTP to your mobile number."),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextFormField(
                                          keyboardType: TextInputType.number,
                                          controller: mobileNumTextController,
                                          decoration: InputDecoration(
                                              suffixIcon: TextButton(
                                                child: value.isLoadingotpSend
                                                    ? SizedBox(
                                                        width: 15,
                                                        height: 15,
                                                        child:
                                                            CircularProgressIndicator(
                                                          color:
                                                              Colors.deepPurple,
                                                          strokeWidth: 2,
                                                        ))
                                                    : Text(
                                                        "Send OTP",
                                                        style:
                                                            GoogleFonts.inter(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                onPressed: () async {
                                                  if (mobileNumTextController
                                                              .text ==
                                                          "+91" ||
                                                      mobileNumTextController
                                                          .text.isEmpty) {
                                                    value.changeShowMobError();
                                                  } else {
                                                    value.changeShowMobError();
                                                    value
                                                        .changeIsLoadingotpSend();
                                                    await FirebaseAuth.instance
                                                        .verifyPhoneNumber(
                                                            phoneNumber:
                                                                mobileNumTextController
                                                                    .text,
                                                            verificationCompleted:
                                                                (PhoneAuthCredential
                                                                    authCredential) async {
                                                              User? user =
                                                                  FirebaseAuth
                                                                      .instance
                                                                      .currentUser;

                                                              if (authCredential
                                                                      .smsCode !=
                                                                  null) {
                                                                try {
                                                                  await user!
                                                                      .linkWithCredential(
                                                                          authCredential);
                                                                } on FirebaseAuthException catch (e) {
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(SnackBar(
                                                                          content:
                                                                              Text(e.toString())));
                                                                  if (e.code ==
                                                                      'provider-already-linked') {
                                                                    await FirebaseAuth
                                                                        .instance
                                                                        .signInWithCredential(
                                                                            authCredential);
                                                                  }
                                                                }
                                                              }
                                                            },
                                                            verificationFailed:
                                                                (FirebaseAuthException
                                                                    exception) {
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      SnackBar(
                                                                          content:
                                                                              Text(exception.toString())));
                                                              if (exception
                                                                      .code ==
                                                                  'invalid-phone-number') {
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(SnackBar(
                                                                        content:
                                                                            Text("The phone number entered is invalid!")));
                                                              }
                                                            },
                                                            codeSent: (String
                                                                    verificationId,
                                                                int?
                                                                    forceResendingToken) {
                                                              this.verificationId =
                                                                  verificationId;
                                                            },
                                                            codeAutoRetrievalTimeout:
                                                                (String
                                                                    timeout) {
                                                              return null;
                                                            });

                                                    value
                                                        .changeIsLoadingotpSend();
                                                  }
                                                },
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  borderSide: BorderSide(
                                                      color: Colors.black12)),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  borderSide: BorderSide(
                                                      color: Colors.black12)),
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                      borderSide: BorderSide(
                                                          color:
                                                              Colors.black12)),
                                              hintText: "Mobile number"),
                                        ),
                                        value.showMobError
                                            ? Text(
                                                "Mobile number is required",
                                                style: GoogleFonts.inter(
                                                    color: Colors.red,
                                                    fontSize: 12),
                                              )
                                            : SizedBox()
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextFormField(
                                            keyboardType: TextInputType.phone,
                                            controller: otpTextController,
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                    borderSide: BorderSide(
                                                        color: Colors.black12)),
                                                enabledBorder: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                    borderSide: BorderSide(
                                                        color: Colors.black12)),
                                                disabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16),
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .black12)),
                                                hintText: "OTP"),
                                          ),
                                          value.showOtperror
                                              ? Text(
                                                  "OTP is required",
                                                  style: GoogleFonts.inter(
                                                      color: Colors.red,
                                                      fontSize: 12),
                                                )
                                              : SizedBox()
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, bottom: 10),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.1,
                                        height: 56,
                                        child: TextButton(
                                          onPressed: () async {
                                            if (otpTextController
                                                .text.isEmpty) {
                                              value.changeShowOtperror();
                                            } else {
                                              value.changeShowOtperror();
                                              value.changeIsLoadingotp();

                                              try {
                                                await FirebaseAuth.instance
                                                    .signInWithCredential(
                                                        PhoneAuthProvider
                                                            .credential(
                                                  verificationId:
                                                      verificationId.toString(),
                                                  smsCode:
                                                      otpTextController.text,
                                                ));
                                                await FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(FirebaseAuth.instance
                                                        .currentUser?.uid)
                                                    .set({
                                                  'mobile':
                                                      mobileNumTextController
                                                          .text,
                                                  'cartItems': []
                                                });
                                                Navigator.pop(context);
                                                //                                       Navigator.pushReplacement(
                                                // context,
                                                // MaterialPageRoute(
                                                //   builder: (context) => HomePage(),
                                                // ));
                                              } catch (e) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            e.toString())));
                                              }

                                              value.changeIsLoadingotp();
                                            }
                                          },
                                          child: value.isLoadingotp
                                              ? SizedBox(
                                                  width: 25,
                                                  height: 25,
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Colors.white,
                                                    strokeWidth: 2,
                                                  ))
                                              : Text(
                                                  "Sign Up",
                                                  style: GoogleFonts.inter(
                                                    color: Color(0xFFFBFBFB),
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                          style: ButtonStyle(
                                              shape: MaterialStatePropertyAll(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16))),
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      const Color.fromARGB(
                                                          255, 171, 183, 58))),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          });
                        },
                      ).then((_) => {
                            if (FirebaseAuth.instance.currentUser != null)
                              {Navigator.pop(context)}
                          });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.mobile_friendly, color: Colors.white),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "Sign Up with Mobile",
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    style: ButtonStyle(
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            side:
                                BorderSide(width: 0.20, color: Colors.black26),
                            borderRadius: BorderRadius.circular(16))),
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.black)),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 45,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Alreay have an account? ',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(255, 0, 0, 0))),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return LoginPage(); // Your custom dialog widget
                          },
                        );
                      },
                      child: Text(
                        "Login",
                        style: GoogleFonts.inter(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16,
                          // decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
