import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomFAB extends StatelessWidget {
  launchWhatsApp() async {
    final url = 'https://wa.me/7293256185';  // Replace with your WhatsApp URL

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
    return FloatingActionButton(
      onPressed: launchWhatsApp,
      tooltip: 'Open WhatsApp',
      
                    child: FaIcon(FontAwesomeIcons.whatsapp),
      backgroundColor: Color.fromARGB(255, 16, 229, 23));
      }}
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:url_launcher/url_launcher.dart';

// class CustomFAB extends StatelessWidget {
//   _launchWhatsApp() async {
//     final url = 'https://wa.me/7293256185';  // Replace with your WhatsApp URL

//     // ignore: deprecated_member_use
//     if (await canLaunch(url)) {
//       // ignore: deprecated_member_use
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FloatingActionButton(
//       onPressed: _launchWhatsApp,
//       tooltip: 'Open WhatsApp',
      
//                     child: FaIcon(FontAwesomeIcons.whatsapp),
//       backgroundColor: Color.fromARGB(255, 16, 229, 23));
//       }}