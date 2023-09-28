import 'package:firebase_hex/login_and_signing/authentication.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

  final emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationHelper>(builder: (context, value, child) {
      return AlertDialog(
        title: AppBar(
          leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: Image.asset(
                "assets/icons/arrow-left.png",
                color: Colors.black,
              )),
          centerTitle: true,
          title: Text(
            "Forgot Password",
            style: GoogleFonts.inter(fontSize: 18, color: Colors.black),
          ),
        ),
        content: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 56),
          child: Container(
            height: 500,
            width: 500,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: 343,
                    child: Text(
                      'Don’t worry. \nEnter your email and we’ll send you a link to reset your password.',
                      style: GoogleFonts.inter(
                        color: Color(0xFF0D0E0F),
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: TextFormField(
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
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.1,
                      height: 56,
                      child: TextButton(
                        onPressed: () async {
                          if (emailTextController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("All fields are required")));
                          } else {
                            value.changeIsLoading();
                            await AuthenticationHelper().resetPassword(
                                emailTextController.text, context);

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
                                "Continue",
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
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
