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
          .set({'name': name, 'email': email,'cartItems':[]});
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
       await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({'name': user?.displayName, 'email': user?.email,'cartItems':[]});
      Navigator.pop(context);
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

}