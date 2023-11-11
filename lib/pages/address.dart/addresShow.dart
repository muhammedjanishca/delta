import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_hex/pages/address.dart/addresstyping.dart';
import 'package:firebase_hex/provider/cart_provider.dart';
import 'package:firebase_hex/widgets/jr_appbar.dart';
import 'package:firebase_hex/login_and_signing/authentication.dart';
import 'package:firebase_hex/login_and_signing/loginpage.dart';
import 'package:firebase_hex/responsive/signup.dart';
import 'package:firebase_hex/widgets/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:side_sheet/side_sheet.dart';

// class SignUpPage extends StatelessWidget {
//   const SignUpPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ResponsiveSignUp(
//         mobileSignUp: mobilesignup(),
//         desktopSignUp: addressshow()
//         );
//   }
// }

// ignore: must_be_immutable
class addressshow extends StatelessWidget {
  addressshow({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getAddressData();
    var cartItems = cartProvider.fetchedItems;
    // var removAdd = cartProvider.removeAddress();
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leadingWidth: 48,
          title: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/');
                },
                child: Text(
                  "DELTA",
                  style: GoogleFonts.oswald(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 45,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Text(
                "\n NATIONAL",
                style: GoogleFonts.oswald(
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: _width / 2.5,
                        height: _height / 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                width: MediaQuery.of(context).size.width / 2.5,
                                // height:
                                //     MediaQuery.of(context).size.width / 2.1,
                                child: Column(
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      color: janishcolor,
                                      child: Column(
                                        children: [
                                          ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            itemCount:
                                                cartItems["address"].length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              // Check if it's not the first item
                                              bool isNotFirstItem = index != 0;

                                              // If it's not the first item, add a Divider
                                              if (isNotFirstItem) {
                                                return Column(
                                                  children: [
                                                    Divider(
                                                      color: Colors
                                                          .black, // Set the color of the divider
                                                      thickness:
                                                          1, // Set the thickness of the divider
                                                    ),
                                                    AddressData(jsonDecode(
                                                        cartItems["address"]
                                                            [index])),
                                                  ],
                                                );
                                              }

                                              // If it's the first item, don't add a Divider
                                              return AddressData(jsonDecode(
                                                  cartItems["address"][index]));
                                            },
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              ElevatedButton(
                                                  onPressed: ()
                                                  //  async 
                                                   {
                                                    // await removAdd;
                                                  },
                                                  child: Icon(Icons.delete)),
                                              ElevatedButton(
                                                  onPressed: () => SideSheet.right(
                                                      body: const Text(
                                                          "Width is set to 0.3 of device Screen With"),
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.4,
                                                      context: context),
                                                  child: Text(
                                                      'OPEN SHEET WITH CUSTOM WIDTH')),
                                              // ElevatedButton(
                                              //   onPressed: () {
                                              //     // Your button's action here
                                              //   },
                                              //   style: ButtonStyle(
                                              //     backgroundColor:
                                              //         MaterialStateProperty
                                              //             .all<Color>(Colors
                                              //                 .black), // Change the color to your desired color
                                              //   ),
                                              //   child: Text('Add Address to Quote'),
                                              // ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )),
                          ],
                        ),
                      ),
                      Gap(25),
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
                      SizedBox(
                        width: _width / 2.5,
                        height: _height / 2,
                        child: Padding(
                          padding: EdgeInsets.only(left: 40, right: 25),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 45,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )));
  }
}
// Future<void> removeAddress() async {
//     try {
//       var documentReference = FirebaseFirestore.instance
//           .collection("users")
//           .doc(FirebaseAuth.instance.currentUser!.uid);

//       // Check if the document exists before trying to delete it
//       var documentSnapshot = await documentReference.get();
//       if (documentSnapshot.exists) {
//         // Document exists, proceed with deletion
//         await documentReference.delete();
//         print("Address removed successfully");

//         // Optionally, you can add code here to update your UI or perform any additional actions after deletion.
//       } else {
//         print("No address found to remove");
//       }
//     } catch (e) {
//       print("Error removing address: $e");
//       // Handle the error as needed
//     }
//   }
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

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationHelper>(builder: (context, value, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leadingWidth: 48,
          title: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/');
                },
                child: Text(
                  "DELTA",
                  style: GoogleFonts.oswald(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 35,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Text(
                "\n NATIONAL",
                style: GoogleFonts.oswald(
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SizedBox(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // SizedBox(
                //   height: MediaQuery.of(context).size.height / 32,
                // ),
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
              ],
            ),
          ),
        ),
      );
    });
  }
}
