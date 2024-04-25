import 'package:firebase_hex/widgets/style.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomFAB extends StatelessWidget {
  launchWhatsApp() async {
    final url = 'https://wa.me/+966555432866'; // Replace with your WhatsApp URL

    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 500,),

        SizedBox(
          width: 60,
          height: 60,
          child: InkWell(
             onTap: launchWhatsApp,
            child: Image.network('https://totalpng.com//public/uploads/preview/whatsapp-logo-transparent-background-free-download-11666005954eohih1qecz.png'))),

      ],
    );
  }
}
