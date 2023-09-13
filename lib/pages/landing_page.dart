import 'package:firebase_hex/responsive/landing.dart';
import 'package:flutter/material.dart';

class LandinPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: ResponsiveLandingPage(
            mobileAppBar: MobilLanding(), desktopAppBar: DesktopLanding()));
  }
}

class DesktopLanding extends StatelessWidget {
  const DesktopLanding({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 1.5,
            color: Colors.transparent,
            child: Image.network(
              'https://electrek.co/wp-content/uploads/sites/3/2021/05/bird-three-header-scooter.jpg?quality=82&strip=all',
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          // SizedBox(height: 16),
          Padding(
            padding:EdgeInsets.symmetric(horizontal:30 ,vertical: 10),
            child: Text(
              'Industrial Cable Management System for your Electrical Projects!',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              '\nAxis Cable Management Systems are used to organise and secure electrical or electronic cables and wires in a facility, home, or office. The main goal of Industrial Cable Manufacturers in India is to manufacture cables that maintain a clean and organized workspace, reduce trip hazards, eliminate short circuits and enhance your overall electrical safety and functionality',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

class MobilLanding extends StatelessWidget {
  const MobilLanding({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height:MediaQuery.of(context).size.height/2,
          width: double.infinity,
          child: Image.network(
              'https://www.energyvoice.com/wp-content/uploads/sites/4/2013/12/yljtufbpahrwtr3efuzu542u3090380.jpg',
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
        ),
        //  SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:16,vertical: 15),
            child: Text(
              
              'Industrial Cable Management System for your Electrical Projects!',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16,vertical:0),
            child: Text(
              '\nAxis Cable Management Systems are used to organise and secure electrical or electronic cables and wires in a facility, home, or office. The main goal of Industrial Cable Manufacturers in India is to manufacture cables that maintain a clean and organized workspace, reduce trip hazards, eliminate short circuits and enhance your overall electrical safety and functionality',
              style: TextStyle(fontSize: 16),
            ),
          ),
      ],

      ),
    );
  }
}