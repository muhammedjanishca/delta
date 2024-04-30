import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
        backgroundColor: Colors.deepPurple,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Introduction', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(
              'Your privacy is critically important to us. We have a few fundamental principles:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text('We don’t ask you for personal information unless we truly need it. (We can’t stand services that ask you for things like your gender or income level for no apparent reason.)',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text('Information We Collect', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(
              'We collect information about you during the checkout process on our store. This information may include, but is not limited to, your name, billing address, shipping address, email address, phone number, credit card/payment details and any other details that might be requested from you for the purpose of processing your orders.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text('Use of Information', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(
              'We use the information collected primarily to process the task for which you visited the website. All reasonable precautions are taken to prevent unauthorized access to this information.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
