import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_hex/login_and_signing/authentication.dart';
import 'package:firebase_hex/widgets/style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pluto_menu_bar/pluto_menu_bar.dart';
import 'package:provider/provider.dart';
import '../login_and_signing/loginpage.dart';
import '../pages/another_pages/contact_us.dart';
import '../provider/cart_provider.dart';
import 'package:badges/badges.dart' as badges;

Color textColor = Colors.black;
Color textColorr = Colors.black;
Color textColorrr = Colors.black;
int enterCounter = 0;
int exitCounter = 0;
double x = 0.0;
double y = 0.0;
double a = 0.0;
double b = 0.0;
double c = 0.0;
double d = 0.0;

List<PlutoMenuItem> makeMenus(BuildContext context) {
  
  return [
    PlutoMenuItem(
      title: '   ALL CATEGORIES                          ',
      icon: Icons.menu,
      onTap: () {
        // Navigator.popUntil(context, ModalRoute.withName('/')); // Close all routes until root
//  Navigator.pop(context);
      },
      children: [
        PlutoMenuItem(
          title: 'Cable Terminal Ends',
          onTap: () {
           
          },
          children: [
            PlutoMenuItem(
              title: 'Lugs',
              onTap: () {
                Navigator.popUntil(context,
                    ModalRoute.withName('/')); // Close all routes until root
                Navigator.pushNamed(context, '/cable-terminal-ends/lugs/');
              },
            ),
            PlutoMenuItem(
              title: 'Connectors',
              onTap: () {
                Navigator.popUntil(context,
                    ModalRoute.withName('/')); // Close all routes until root
                Navigator.pushNamed(
                    context, '/cable-terminal-ends/connectors/');
              },
            ),
          ],
        ),
        PlutoMenuItem(
          title: 'Brass Cable Gland Kits & Accessories',
          // icon: Icons.group,
          onTap: () {},
          children: [
            PlutoMenuItem(
              title: 'Glands',
              onTap: () {
                Navigator.popUntil(context,
                    ModalRoute.withName('/')); // Close all routes until root
                Navigator.pushNamed(context,
                    '/brass-cable-gland-kits-accessories/brass-cable-glands/');
              },
            ),
            PlutoMenuItem(
              title: 'Accessories',
              onTap: () {
                Navigator.popUntil(context,
                    ModalRoute.withName('/')); // Close all routes until root

                Navigator.pushNamed(context,
                    '/brass-cable-gland-kits-accessories/brass-cable-gland-accessories/');
              },
            ),
          ],
        ),
        PlutoMenuItem(
          title: 'Crimping Tools',
          onTap: () {
            Navigator.popUntil(context,
                ModalRoute.withName('/')); // Close all routes until root

            Navigator.pushNamed(context, '/crimping-tools/');
          },
        ),
        PlutoMenuItem(
          title: 'Earthing & Lightning Protection Systems',
          // icon: Icons.group,
          onTap: () {},

          children: [
            PlutoMenuItem(
              title: 'Earthing & Lightning Protection ',
              onTap: () {
                Navigator.popUntil(context,
                    ModalRoute.withName('/')); // Close all routes until root

                Navigator.pushNamed(context,
                    '/earthing-lightning-protection-systems/earthing-lightning-protection/');
              },
            ),
            PlutoMenuItem(
              title: 'Earthing & Lightning Protection - Accessories',
              onTap: () {
                Navigator.popUntil(context,
                    ModalRoute.withName('/')); // Close all routes until root

                Navigator.pushNamed(context,
                    '/earthing-lightning-protection-systems/earthing-lightning-protection-accessories/');
              },
            ),
          ],
        ),
        PlutoMenuItem(
          title: 'Switch Board / Control Panel Accessories',
          onTap: () {
            Navigator.popUntil(context,
                ModalRoute.withName('/')); // Close all routes until root

            Navigator.pushNamed(
                context, '/switch-board-control-panel-accessories/');
          },
        ),
        PlutoMenuItem(
          title: 'Stainless Steel Cable Ties & Markers',
          onTap: () {
            Navigator.popUntil(context,
                ModalRoute.withName('/')); // Close all routes until root

            Navigator.pushNamed(
                context, '/Stainless Steel Cable Ties & Markers');
          },
        ),
        PlutoMenuItem(
          title: 'Cable Support Systems',
          onTap: () {
            Navigator.popUntil(context,
                ModalRoute.withName('/')); // Close all routes until root

            Navigator.pushNamed(context, '/cable-support-systems/');
          },
        ),
        PlutoMenuItem(
          title: 'Cable Jointing & Termination Kit Components',
          onTap: () {
            Navigator.popUntil(context,
                ModalRoute.withName('/')); // Close all routes until root

            Navigator.pushNamed(
                context, '/cable-jointing-and-termination-kit-components/');
          },
        ),
      ],
    ),
  ];
}


class LoginAndLogOut extends StatelessWidget {
  const LoginAndLogOut({super.key});

  @override
  Widget build(BuildContext context) {
    int cartCount = 0;
      var user = Provider.of<AuthenticationHelper>(context).user;
    if (user != null) {
      Provider.of<CartProvider>(context).getCartData();
      cartCount =
          Provider.of<CartProvider>(context).fetchedItems['cartItems'].length;
    }
    return  user == null
                        ? InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return LoginPage();
                                  });
                            },
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.person_outline,
                                  color: Colors.black26,
                                ),
                                Gap(10),
                                Text("Login",
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                        color: Colors.black,
                                        // fontSize: 16,
                                      ),
                                    )),

                               
                              ],
                            ),
                          )
                        : TextButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Are you sure to logout?"),
                                    // content: Text("This is my message."),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('Cancel')),
                                      TextButton(
                                          onPressed: () {
                                            FirebaseAuth.instance.signOut();
                                            // Navigator.pop(context);

                                            Navigator.pushNamed(context, '/');
                                          },
                                          child: Text('Yes'))
                                    ],
                                  );
                                },
                              );
                              // FirebaseAuth.instance.signOut();
                            },
                            child: Text(
                              'Logout',
                              style: GoogleFonts.poppins(color: Colors.black),
                            ));
  }
}
class HoverText extends StatefulWidget {
  const HoverText({super.key});

  @override
  State<HoverText> createState() => _HoverTextState();
}

class _HoverTextState extends State<HoverText> {
  
  @override
  
//home
  void incrementEnter(PointerEvent details) {
    setState(() {
      enterCounter++;
    });
  }

  void incrementExit(PointerEvent details) {
    setState(() {
      textColor = Colors.black;
      exitCounter++;
    });
  }

  void updateLocation(PointerEvent details) {
    setState(() {
      textColor = Color.fromARGB(255, 237, 84, 74);
      x = details.position.dx;
      y = details.position.dy;
    });
  }

  //about us
  void incrementEnterr(PointerEvent details) {
    setState(() {
      enterCounter++;
    });
  }

  void incrementExitt(PointerEvent details) {
    setState(() {
      textColorr = Colors.black;
      exitCounter++;
    });
  }

  void updateLocationn(PointerEvent details) {
    setState(() {
      textColorr = Color.fromARGB(255, 237, 84, 74);
      a = details.position.dx;
      b = details.position.dy;
    });
  }

  //contact us
  void incrementEnterrr(PointerEvent details) {
    setState(() {
      enterCounter++;
    });
  }

  void incrementExittt(PointerEvent details) {
    setState(() {
      textColorrr = Colors.black;
      exitCounter++;
    });
  }

  void updateLocationnn(PointerEvent details) {
    setState(() {
      textColorrr = Color.fromARGB(255, 237, 84, 74);
      c = details.position.dx;
      d = details.position.dy;
    });
  }
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Calculate font size based on screen width
    double gap = screenWidth < 1050 ? 15 : 50;
    return  SizedBox(
     
                        // width: MediaQuery.of(context).size.height / 2.9,
                        child: Row(
                          children: [
                            MouseRegion(
                              onEnter: incrementEnter,
                              onHover: updateLocation,
                              onExit: incrementExit,
                              child: InkWell(
                                child: Text(
                                  'Home',
                                  style:
                                      GoogleFonts.poppins(color: textColor),
                                ),
                                onTap: () {
                                  Navigator.pushNamed(context, '/');
                                },
                              ),
                            ),
                            Gap(gap),
                            MouseRegion(
                              onEnter: incrementEnterr,
                              onHover: updateLocationn,
                              onExit: incrementExitt,
                              child: InkWell(
                                child: Text(
                                  'About Us',
                                  style:
                                      GoogleFonts.poppins(color: textColorr),
                                ),
                                onTap: () {
                                  Navigator.pushNamed(context, '/');
                                },
                              ),
                            ),
                            Gap(gap),
                            MouseRegion(
                              onEnter: incrementEnterrr,
                              onHover: updateLocationnn,
                              onExit: incrementExittt,
                              child: InkWell(
                                child: Text(
                                  'Contact Us',
                                  style:
                                      GoogleFonts.poppins(color: textColorrr),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ContactUsPage()),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      );
  }
}

// Widget hovertext() {
//   return Container();
// }
