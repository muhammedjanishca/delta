import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class CartEmptyPage extends StatelessWidget {
  const CartEmptyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FittedBox(
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Gap(10),
                  Text(
                    "SHOPPING CART",
                    style: GoogleFonts.poppins(
                        fontSize: 23, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Home  /  Shopping Cart",
                    style: GoogleFonts.poppins(),
                  ),
                  Image.network(
                    'https://deltabuckets.s3.ap-south-1.amazonaws.com/carousel+images/supermarket-shopping-cart-concept-illustration_114360-22408.avif',
                    height: MediaQuery.of(context).size.height / 2.5,
                  ),
                  Gap(20),
                  Text(
                    'Your Cart Is Currently Empty!',
                    style: GoogleFonts.poppins(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Gap(15),
                  Text(
                    'Before proceed to checkout you must add some products to your shopping cart.',
                    style: GoogleFonts.poppins(),
                  ),
                  Text(
                    'you will find a lot of products on our "Shop" page.',
                    style: GoogleFonts.poppins(),
                  ),
                  Gap(10),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/');
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 10,
                          backgroundColor: Color.fromRGBO(214, 0, 27, 1),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                            side: BorderSide(color: Colors.red),
                          )),
                      child: Text(
                        'Return To Shpe',
                        style: GoogleFonts.poppins(),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
