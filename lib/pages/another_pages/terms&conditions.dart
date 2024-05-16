import 'package:firebase_hex/widgets/style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'IRSH.dart';

class TermsAndConditionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.white,
     appBar: custSmallAppBar(context,Colors.white),
      body:  SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: colorTwo,
              height: MediaQuery.of(context).size.height/4,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Terms & Conditions",style:GoogleFonts.poppins(fontSize: 25,color: Colors.white,fontWeight: FontWeight.w600)),
               Row(
                children: [
                  Text("To learn more about privacy at LinkedIn please visit our",style: GoogleFonts.poppins(color: Colors.white),),
                  TextButton(onPressed: (){},
                   child: Text("Privacy Hub",
                   style:GoogleFonts.poppins(fontWeight: FontWeight.w500,color: Colors.white,decoration: TextDecoration.underline),
                   
                   ))
                ],
               )
                ],
              ),
            ),
            const Text('1. General', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Text(
              'These Terms govern the use of this website and any other contract or agreement that integrates them by reference. Visitors and users are required to accept these Terms to access articles and products provided through our site.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text('2. Product Information', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(
              'All features, content, specifications, products, and prices of products and services described or depicted on this website are subject to change at any time without notice.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text('3. Delivery', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(
              'We deliver electrical products using trusted delivery services. Estimated delivery times are to be used as a guide only and commence from the date of dispatch.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text('4. Returns and Refunds', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(
              'Products can be returned within a specified period, provided they are in their original condition. Refunds are processed based on the original method of payment.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
           
          ],
        ),
      ),
    );
  }
}
