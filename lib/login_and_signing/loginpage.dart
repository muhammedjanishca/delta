import 'package:firebase_hex/login_and_signing/authentication.dart';
import 'package:firebase_hex/login_and_signing/forgott_password.dart';
import 'package:firebase_hex/login_and_signing/signup_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final emailTextController = TextEditingController();

  final passwordTextController = TextEditingController();

  // bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationHelper>(builder: (context, value, child) {
      return AlertDialog(
        title: Text('Login Page'),
        content: Container(
          height: 400,
          width: 500,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: TextFormField(
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
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: TextFormField(
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
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.1,
                    height: 56,
                    child: TextButton(
                      onPressed: () async {
                        if (emailTextController.text.isEmpty ||
                            passwordTextController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("All fields are required")));
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
                                  borderRadius: BorderRadius.circular(1))),
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.black)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 19.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pop(); // Dismiss the current alert dialog

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ForgotPasswordPage(); // Your custom dialog widget
                        },
                      );
                    },
                    child: Text(
                      "Forgot Password?",
                      style: GoogleFonts.inter(
                        color: Color.fromARGB(255, 76, 138, 131),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 19.0),
                    child: Row(
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
                                    builder: (context) => SignUpPage()));
                          },
                          child: Text(
                            "Sign Up",
                            style: GoogleFonts.inter(
                              color: Color.fromARGB(255, 76, 138, 131),
                              fontSize: 16,
                              //  decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      );
    });
  }
}
