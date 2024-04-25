import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms and Conditions'),
        backgroundColor: Colors.deepPurple,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('1. General', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(
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
