import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordStatusPage extends StatelessWidget {
  final String email;
  const ForgotPasswordStatusPage({super.key,required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 56),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Image.asset("assets/images/mail.png"),
                Text(
                  'Your email is on the way',
                  style: GoogleFonts.inter(
                    color: Color(0xFF0D0E0F),
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: SizedBox(
                    child: Text(
                      'Check your email $email and follow the instructions to reset your password',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        color: Color(0xFF292B2D),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.1,
              height: 56,
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);},
                child: Text(
                  "Back to Login",
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
          ],
        ),
      ),
    );
  }
}