// 
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JrAppBar extends StatelessWidget {
  const JrAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leadingWidth: 48,
     title:Row(
       children: [
         InkWell(
          onTap: (){
              Navigator.pushNamed(context, '/');
          },
           child: Text("DELTA",style: GoogleFonts.oswald(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 35,
                              fontWeight: FontWeight.w700,
                            ),
                          ),),
         ),

           Text("\n NATIONAL",style: GoogleFonts.oswald(
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),),
         
 
       ],

     ),
    );
  }
}
