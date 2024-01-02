import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_hex/pages/another_pages/IRSH.dart';
import 'package:firebase_hex/login_and_signing/authentication.dart';
import 'package:firebase_hex/login_and_signing/loginpage.dart';
import 'package:firebase_hex/provider/Refresh.dart';
import 'package:firebase_hex/responsive/signup.dart';
import 'package:firebase_hex/widgets/style.dart';
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
        mobileSignUp: MobileSignup(),
        desktopSignUp: DeskSignUp()
        );
  }
}

// ignore: must_be_immutable
class DeskSignUp extends StatelessWidget {
  DeskSignUp({super.key});

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final nameTextController = TextEditingController();
  final mobileNumTextController = TextEditingController(text: "+966");
  final otpTextController = TextEditingController();

  String? verificationId;
  EmailOTP emailOtpAuth = EmailOTP();

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    // final List<String> images = [
    //   'assets/image/Illustration1.png',
    //   'assets/image/Illustration2.png',
    //   'assets/image/Illustration3.png',
    // ];
    // final List<String> imagecap1 = [
    //   'Gain total control \nof your money',
    //   'Know where your \nmoney goes',
    //   'Planning ahead'
    // ];
    // final List<String> imagecap2 = [
    //   'Become your own money manager \nand make every cent count',
    //   'Track your transaction easily,\nwith categories and financial report',
    //   'Setup your budget for each category \nso you in control'
    // ];
    return Consumer<AuthenticationHelper>(builder: (context, value, child) {
      return Scaffold(
          backgroundColor: Colors.white,
        appBar: custSmallAppBar(context,Colors.white),
          body: Container(
              width: double.infinity,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 55, fontWeight: FontWeight.w600),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '\nAlready have an account? ',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          //           Navigator.of(context)
                          // .pop(); // Dismiss the current alert dialog

                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return LoginPage(); // Your custom dialog widget
                            },
                          );
                        },
                        child: Text(
                          "\nLog In",
                          style: GoogleFonts.inter(
                            color: Color.fromARGB(255, 18, 116, 182),
                            fontSize: 16,
                            // decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: _width / 2.5,
                          height: _height / 2,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 45, left: 25),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 45,
                                ),
                                TextFormField(
                                  controller: nameTextController,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(1),
                                          borderSide: BorderSide(
                                              color: Colors.black12)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(1),
                                          borderSide: BorderSide(
                                              color: Colors.black12)),
                                      disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(1),
                                          borderSide: BorderSide(
                                              color: Colors.black12)),
                                      hintText: "Name"),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 45,
                                ),
                                TextFormField(
                                  controller: emailTextController,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(1),
                                          borderSide: BorderSide(
                                              color: Colors.black12)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(1),
                                          borderSide: BorderSide(
                                              color: Colors.black12)),
                                      disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(1),
                                          borderSide: BorderSide(
                                              color: Colors.black12)),
                                      hintText: "Email"),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 45,
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
                                          borderRadius:
                                              BorderRadius.circular(1),
                                          borderSide: BorderSide(
                                              color: Colors.black12)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(1),
                                          borderSide: BorderSide(
                                              color: Colors.black12)),
                                      disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(1),
                                          borderSide: BorderSide(
                                              color: Colors.black12)),
                                      hintText: "Password"),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 45,
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
                                      overflow: TextOverflow.visible,
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        // fontWeight: FontWeight.w500,
                                        // height: 1.29,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 45,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.1,
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
                                                        email:
                                                            emailTextController
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
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                          Color.fromARGB(255, 76, 138, 131),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              width: 0.5,
                              height: 130,
                              color: Color.fromARGB(255, 122, 122, 122),
                            ),
                            Text("or"),
                            Container(
                              width: 0.5,
                              height: 130,
                              color: const Color.fromARGB(255, 122, 122, 122),
                            ),
                          ],
                        ),

                        // const   VerticalDivider(
                        //    thickness: 5,
                        //    width: 20,
                        //    indent: 20,
                        //    endIndent: 20,
                        //    color: Colors.grey,
                        //    ),
                        SizedBox(
                          width: _width / 2.5,
                          height: _height / 2,
                          child: Padding(
                            padding: EdgeInsets.only(left: 40, right: 25),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Colors.white)),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 45,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.1,
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
                                                    bottom:
                                                        MediaQuery.of(context)
                                                            .viewInsets
                                                            .bottom,
                                                    top: 20.0,
                                                    right: 20,
                                                    left: 20),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        "Continue with Mobile OTP",
                                                        style:
                                                            GoogleFonts.inter(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
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
                                                                              color: Colors.deepPurple,
                                                                              strokeWidth: 2,
                                                                            ))
                                                                        : Text(
                                                                            "Send OTP",
                                                                            style:
                                                                                GoogleFonts.inter(fontWeight: FontWeight.bold),
                                                                          ),
                                                                    onPressed:
                                                                        () async {
                                                                      if (mobileNumTextController.text ==
                                                                              "+966" ||
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
                                                                              User? user = FirebaseAuth.instance.currentUser;

                                                                              if (authCredential.smsCode != null) {
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
                                                                              if (exception.code == 'invalid-phone-number') {
                                                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("The phone number entered is invalid!")));
                                                                              }
                                                                            },
                                                                            codeSent: (String verificationId, int? forceResendingToken) {
                                                                              this.verificationId = verificationId;
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
                                                                  style: GoogleFonts.inter(
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
                                                        width: MediaQuery.of(
                                                                    context)
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
                                                              await value.verifyOTP(
                                                                  verificationId,
                                                                  context,
                                                                  otpTextController);
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
                                                                    fontSize:
                                                                        18,
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
                                                                      Color.fromARGB(255, 22, 145, 156))),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Colors.black)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("\nBy proceeding, you agree to the"),
                      TextButton(onPressed: (){},
                      child: Text("\nTerms and Conditions")),
                      Text("\nand"),
                       TextButton(onPressed: (){},
                      child: Text("\nPrivacy Policy")),
                    ],
                  ),

                ],
                
              )
              )
                );
    });
  }
}

// ignore: must_be_immutable

// ignore: must_be_immutable
class MobileSignup extends StatelessWidget {
  MobileSignup({super.key});

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final nameTextController = TextEditingController();
  final mobileNumTextController = TextEditingController(text: "+966");
  final otpTextController = TextEditingController();

  String? verificationId;
  EmailOTP emailOtpAuth = EmailOTP();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationHelper>(builder: (context, value, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar:custSmallAppBar(context, Colors.white),
        body: RefreshIndicator(
          onRefresh: refresh,
          child: SingleChildScrollView(
            child: SizedBox(
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height / 32,
                    // ),
                    Text(
                        "Sign Up",
                        style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '\nAlready have an account? ',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              //           Navigator.of(context)
                              // .pop(); // Dismiss the current alert dialog
          
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return LoginPage(); // Your custom dialog widget
                                },
                              );
                            },
                            child: Text(
                              "\nLog In",
                              style: GoogleFonts.inter(
                                color: Color.fromARGB(255, 18, 116, 182),
                                fontSize: 16,
                                // decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
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
                                        color: Color.fromARGB(255, 76, 138, 131),
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
                                borderRadius: BorderRadius.circular(1))),
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
                              borderRadius: BorderRadius.circular(1),
                              borderSide: BorderSide(color: Colors.black12)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(1),
                              borderSide: BorderSide(color: Colors.black12)),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(1),
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
                              borderRadius: BorderRadius.circular(1),
                              borderSide: BorderSide(color: Colors.black12)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(1),
                              borderSide: BorderSide(color: Colors.black12)),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(1),
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
                              borderRadius: BorderRadius.circular(1),
                              borderSide: BorderSide(color: Colors.black12)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(1),
                              borderSide: BorderSide(color: Colors.black12)),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(1),
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
                            focusColor: Color.fromARGB(255, 76, 138, 131),
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
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("All fields are required")));
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
                                    builder: (context) => MailVerificationPgae(
                                        name: nameTextController.text,
                                        email: emailTextController.text,
                                        password: passwordTextController.text,
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
                            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(1))),
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
                                                              "+966" ||
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
                                                                1),
                                                        borderSide: BorderSide(
                                                            color: Colors.black12)),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                1),
                                                        borderSide: BorderSide(
                                                            color: Colors.black12)),
                                                    disabledBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(1),
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
                                                  await value.verifyOTP(
                                                      verificationId,
                                                      context,
                                                      otpTextController);
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
                                                                  1))),
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
                                    BorderSide(width: 0.50, color: Colors.black26),
                                borderRadius: BorderRadius.circular(1))),
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.black)),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 45,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Text(
                    //       'Alreay have an account? ',
                    //       style: GoogleFonts.inter(
                    //         fontSize: 16,
                    //         fontWeight: FontWeight.w500,
                    //       ),
                    //     ),
                    //     InkWell(
                    //       onTap: () {
                    //         //           Navigator.of(context)
                    //         // .pop(); // Dismiss the current alert dialog
          
                    //         showDialog(
                    //           context: context,
                    //           builder: (BuildContext context) {
                    //             return LoginPage(); // Your custom dialog widget
                    //           },
                    //         );
                    //       },
                    //       child: Text(
                    //         "Login",
                    //         style: GoogleFonts.inter(
                    //           color: Color.fromARGB(255, 76, 138, 131),
                    //           fontSize: 16,
                    //           // decoration: TextDecoration.underline,
                    //           fontWeight: FontWeight.w500,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // )
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
