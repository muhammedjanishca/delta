import 'package:firebase_hex/login_and_signing/authentication.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import 'email_otp.dart';

// ignore: must_be_immutable
class MailVerificationPgae extends StatelessWidget {
  final String email;
  final String name;
  final String password;
  final String otpId;
  MailVerificationPgae(
      {super.key,
      required this.name,
      required this.email,
      required this.password,
      required this.otpId});

  String? otpController;

  EmailOTP emailOtpAuth = EmailOTP();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationHelper>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: Image.asset(
                "assets/icons/arrow-left.png",
                color: Colors.black,
              )),
          centerTitle: true,
          title: Text(
            "Verification",
            style: GoogleFonts.inter(fontSize: 18, color: Colors.black),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter your Verification Code',
                style: GoogleFonts.inter(
                  color: Color(0xFF0D0E0F),
                  fontSize: 36,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Pinput(
                  onCompleted: (pin) {
                    otpController = pin;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: SizedBox(
                  child: Text(
                    'We send verification code to your email $email. You can check your inbox.',
                    style: GoogleFonts.inter(
                      color: Color(0xFF292B2D),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: InkWell(
                  onTap: () {},
                  child: Text(
                    "I didn’t received the code? Send again",
                    style: GoogleFonts.inter(
                      color: Colors.deepPurple,
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 46),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 1.1,
                  height: 56,
                  child: TextButton(
                    onPressed: () async {
                      if (otpController != null) {
                        String isOtpCorrect = await emailOtpAuth.verifyOtp(
                            otpId, otpController);
                      
                        if (isOtpCorrect == "success") {
                          value.changeIsLoading();
                          await AuthenticationHelper()
                              .signUp(email, password, name, context);
                          value.changeIsLoading();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Incorrect OTP!")));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Please enter a valid OTP!")));
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
                            "Verify",
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
              ),
            ],
          ),
        ),
      );
    });
  }
}
