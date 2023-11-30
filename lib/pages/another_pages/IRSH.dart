import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar custSmallAppBar(BuildContext context, janish) {
  return AppBar(
    backgroundColor: janish,
    elevation: 0,
    leadingWidth: 48,
    title: Row(
      children: [
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/');
          },
          child: Image.asset(
                                  'assets/image/Yellow and Brown Modern Apparel Logo (6).png',
                                  width: 170,
                                  height: 60,
                                  fit: BoxFit.cover,
                                )),
        // Text(
        //     "DELTA",
        //     style: GoogleFonts.oswald(
        //       textStyle: TextStyle(
        //         color: Colors.black,
        //         fontSize: 45,
        //         fontWeight: FontWeight.w700,
        //       ),
        //     ),
        //   ),
        // ),
        // Text(
        //   "TRADING",
        //   style: GoogleFonts.oswald(
        //     textStyle: const TextStyle(
        //       color: Colors.black,
        //       fontSize: 20,
        //       fontWeight: FontWeight.w700,
        //     ),
        //   ),
        // ),
      ],
    ),
  );
}
