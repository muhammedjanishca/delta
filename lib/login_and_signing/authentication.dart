import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';

import 'forgott_passoword_status.dart';

class AuthenticationHelper extends ChangeNotifier {
  bool showPassword = false;
  bool isLoadingGIn = false;
  bool isLoading = false;
  bool isChecked = false;
  bool isLoadingotp = false;
  bool isLoadingotpSend = false;
  bool showOtperror = false;
  bool showMobError = false;
  var user;
  void changeShowPassword() {
    showPassword = !showPassword;
    notifyListeners();
  }

  void changeIsLoadingGIn() {
    isLoadingGIn = !isLoadingGIn;
    notifyListeners();
  }

  void changeIsChecked() {
    isChecked = !isChecked;
    notifyListeners();
  }

  void changeIsLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  void changeIsLoadingotp() {
    isLoadingotp = !isLoadingotp;
    notifyListeners();
  }

  void changeIsLoadingotpSend() {
    isLoadingotpSend = !isLoadingotpSend;
    notifyListeners();
  }

  void changeShowOtperror() {
    showOtperror = !showOtperror;
    notifyListeners();
  }

  void changeShowMobError() {
    showMobError = !showMobError;
    notifyListeners();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signUp(
      String email, String password, String name, BuildContext context) async {
    try {
      UserCredential userCred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _auth.currentUser!.updateDisplayName(name);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCred.user!.uid)
          .set({'name': name, 'email': email, 'cartItems': []});
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("The password provided is too weak.")));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("The account already exists for that email.")));
      } else if (e.code == 'invalid-email') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("The entered email is invalid")));
      }
    }
    notifyListeners();
  }

  Future<void> logIn(
      String email, String password, BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("No user found for that email.")));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Incorrect password.")));
      }
    }
    notifyListeners();
  }

  Future<void> resetPassword(String email, context) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ForgotPasswordStatusPage(email: email),
          ));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("The password provided is too weak.")));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("The account already exists for that email.")));
      } else if (e.code == 'invalid-email') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("The entered email is invalid")));
      } else if (e.code == "user-not-found") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("The entered email is not registered with us")));
      }
    }
    notifyListeners();
  }

  Future<void> signInWithGoogle(context) async {
    try {
      await Firebase.initializeApp();
      User? user;
      // FirebaseAuth auth = FirebaseAuth.instance;
      GoogleAuthProvider authProvider = GoogleAuthProvider();
      // final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      // final GoogleSignInAuthentication? googleAuth =
      // await googleUser?.authentication;
      // final credential = GoogleAuthProvider.credential(
      //   accessToken: googleAuth?.accessToken,
      //   idToken: googleAuth?.idToken);
      // await FirebaseAuth.instance.signInWithCredential(credential);
      final UserCredential userCredential =
          await _auth.signInWithPopup(authProvider);
      user = userCredential.user;
      var fetchedItems = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();
             print(fetchedItems.exists);
      !fetchedItems.exists
          ? await FirebaseFirestore.instance
              .collection('users')
              .doc(userCredential.user!.uid)
              .set({
              'name': user?.displayName,
              'email': user?.email,
              'cartItems': []
            })
          : null;
      Navigator.pop(context);
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Future<void> verifyOTP(verificationId, context, otpTextController) async {
    try {
      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
        verificationId: verificationId.toString(),
        smsCode: otpTextController.text,
      ));

      var fetchedItems = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();
      print(fetchedItems.exists);
     !fetchedItems.exists
          ? await FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .set({
              'mobile': FirebaseAuth.instance.currentUser?.phoneNumber,
              'cartItems': []
            })
          : null;
  
      Navigator.pop(context);
      //                                       Navigator.pushReplacement(
      // context,
      // MaterialPageRoute(
      //   builder: (context) => HomePage(),
      // ));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    notifyListeners();
  }

  getCurrentUser() {
    user = FirebaseAuth.instance.currentUser;
    notifyListeners();
  }
}


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