import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_hex/login_and_signing/signup_page.dart';
import 'package:firebase_hex/main.dart';
import 'package:firebase_hex/pages/product_pages/AccessoriesPage.dart';
import 'package:firebase_hex/pages/product_pages/connecters.dart';
import 'package:firebase_hex/pages/product_pages/crimping.dart';
import 'package:firebase_hex/pages/product_pages/gland.dart';
import 'package:firebase_hex/pages/product_pages/lugs.dart';
import 'package:firebase_hex/provider/cart_provider.dart';
import 'package:firebase_hex/provider/data_provider.dart';
import 'package:firebase_hex/provider/thumbnail.dart';
import 'package:firebase_hex/responsive/appbar.dart';
import 'package:firebase_hex/search_api.dart';
import 'package:firebase_hex/widgets/search_Bar.dart';
import 'package:firebase_hex/widgets/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../../login_and_signing/authentication.dart';
import '../../login_and_signing/loginpage.dart';
import '../../main.dart';
import '../../widgets/whatsApp.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:badges/badges.dart' as badges;

void _handlePopupSelection(String choice) {
  // Handle the selected menu item here
  switch (choice) {
    case 'Account':
    // Handle Account action
    case 'Logout':
      // Handle Logout action
      break;
    // Handle Login action
    case 'Login':
      break;
  }
}

class AppBarMain extends StatelessWidget {
  final Widget body;

  AppBarMain({
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //--------------- WhatsApp -------------------

      floatingActionButton: CustomFAB(),
      drawer: custmobileDrawer(context),

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(105),
        child: ResponsiveAppBar(
          mobileAppBar: MobileAppBar(
            context,
          ),
          desktopAppBar: DesktopAppBar(context),
        ),
      ),
      // drawer: mobileDrawer(context),
      body: body, // Keep the same body content
    );
  }
}

//------custome AppBar for the desktop-------

class DesktopAppBar extends StatelessWidget {
  final BuildContext context;

  DesktopAppBar(this.context);
  final TextEditingController searchTextController = TextEditingController();

  int cartCount = 0;
  @override
  Widget build(BuildContext context) {
    Provider.of<AuthenticationHelper>(context).getCurrentUser();
    var user = Provider.of<AuthenticationHelper>(context).user;
    if (user != null) {
      Provider.of<CartProvider>(context).getCartData();
      cartCount =
          Provider.of<CartProvider>(context).fetchedItems['cartItems'].length;
    }
    return ChangeNotifierProvider(
      create: (context) => DataProvider(),
      child: PreferredSize(
        preferredSize: Size.fromHeight(105),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                                  color: const Color.fromARGB(255, 169, 167, 162),

                // color: const Color.fromARGB(255, 0, 0, 0),
                height: 64,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width <=
                              950 // You can adjust the threshold value (600 in this example) based on your preferred screen size
                          ? MediaQuery.of(context).size.width /
                              30 // If the screen width is less than 600, set width to half of the screen width
                          : MediaQuery.of(context).size.width /
                              8, // If the screen width is 600 or greater, set width to 1/8 of the screen width
                    ),
                    InkWell(
                      onTap: () {
                        // Navigate to the named route '/your_destination_screen'
                        Navigator.pushNamed(context, '/');
                      },
                     
                      child: Image.asset(
                                  'assets/image/Yellow and Brown Modern Apparel Logo (6).png',
                                  width: 170,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),   
              //         Row(
              //           children: [
              //              Text(
              //   "Trans Delta Trading",
              //   style: GoogleFonts.dosis(
              //     textStyle: TextStyle(
              //       color: Colors.white,
              //       fontSize: 28,
              //       fontWeight: FontWeight.w400,
              //     ),
              //   ),
              // ),
            //              
                //  ],
                //       ),
                         ),
                    SizedBox(width: MediaQuery.of(context).size.width / 15),
                    Expanded(child: searchBox(context)),
                    SizedBox(width: MediaQuery.of(context).size.width / 70),

                    user == null
                        ? TextButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return LoginPage(); // Your custom dialog widget
                                },
                              );
                            },
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white), // Change the color to your desired color
                            ),
                            child: Text('SignUp/SignIn',
                            style: GoogleFonts.barlow(
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700
                            ),),
                            //  Text(
              //   "Trans Delta Trading",
              //   style: GoogleFonts.dosis(
              //     textStyle: TextStyle(
              //       color: Colors.white,
              //       fontSize: 28,
              //       fontWeight: FontWeight.w400,
              //     ),
              //   ),
              // ),
                             ) )
                        : SizedBox(),

                    // user != null
                    //     ? TextButton(
                    //         onPressed: () {
                    //           FirebaseAuth.instance.signOut();
                    //         },
                    //         child: Text('logout'))
                    //     : SizedBox(),
                    SizedBox(width: MediaQuery.of(context).size.width / 70),

                    InkWell(
                      onTap: () {
                        // Show the PopupMenu when the icon is clicked
                        showMenu(
                          context: context,
                          position: RelativeRect.fromLTRB(
                            200,
                            60,
                            180,
                            0,
                          ), // Adjust the position as needed
                          items: [
                            PopupMenuItem<String>(
                              value: 'Account',
                              child: Text('Account'),
                            ),
                            PopupMenuItem<String>(
                              value: 'Login',
                              child: Text('Login'),
                            ),
                            PopupMenuItem<String>(
                              child: user != null
                                  ? TextButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text(
                                                  "Are you sure to logout?"),
                                              // content: Text("This is my message."),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('Cancel')),
                                                TextButton(
                                                    onPressed: () {
                                                      FirebaseAuth.instance
                                                          .signOut();
                                                      // Navigator.pop(context);

                                                      Navigator.pushNamed(
                                                          context, '/');
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
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ))
                                  : SizedBox(),
                            ),
                          ],
                        ).then((value) {
                          // Handle the selected menu item when the menu is dismissed
                          if (value != null) {
                            _handlePopupSelection(value);
                          }
                        });
                      },
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),

                    SizedBox(width: MediaQuery.of(context).size.width / 70),

                    GestureDetector(
                      onTap: () {
                        user != null
                            ? Navigator.pushNamed(context, '/cart')
                            : showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return LoginPage(); // Your custom dialog widget
                                },
                              );
                      },
                      child: badges.Badge(
                          badgeContent: Text(
                            cartCount.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                          child: Icon(
                            Icons.shopping_bag_outlined,
                            color: Colors.white,
                          )),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width <=
                              950 // You can adjust the threshold value (600 in this example) based on your preferred screen size
                          ? MediaQuery.of(context).size.width /
                              30 // If the screen width is less than 600, set width to half of the screen width
                          : MediaQuery.of(context).size.width /
                              8, // If the screen width is 600 or greater, set width to 1/8 of the screen width
                    ),
                  ],
                ),
              ),
              Container(
                height: 41,
                width: double.infinity,
                decoration: BoxDecoration(
                color: Color.fromARGB(255, 238, 131, 38),
               // color: Deltacolor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 50),
                    _buildPopupMenuButton(
                      context,
                      'Cable Terminal Ends',
                      
                      ['Lugs', 'Connectors'],
                      (selectedDataType) async {
                        if (selectedDataType == 'Lugs') {
                          Navigator.pushNamed(context, '/Lugs');
                        } else if (selectedDataType == 'Connectors') {
                          Navigator.pushNamed(context, '/Connectors');
                        }
                        // Add similar conditions for other data types
                      },
                    ),
                    _buildPopupMenuButton(
                      context,
                      'Brass Cable Gland Kits & Accessories',
                      ['Glands', 'Accessories'],
                      (selectedDataType) async {
                        if (selectedDataType == 'Glands') {
                          Navigator.pushNamed(context, '/Glands');
                        } else if (selectedDataType == 'Accessories') {
                          Navigator.pushNamed(context, '/Accessories');
                        }
                        // Add similar conditions for other data types
                      },
                    ),
                    _buildPopupMenuButton(
                      context,
                      'Crimping Tool',
                      ['Crimping Tool'],
                      (selectedDataType) async {
                        if (selectedDataType == 'Crimping Tool') {
                          Navigator.pushNamed(context, '/CrimpingTools');
                        }
                      },
                    ),
                    SizedBox(width: 50),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

//...............CUSTOME DROPDOWN BUTTON................

  Widget _buildPopupMenuButton(
    BuildContext context,
    String title,
    List<String> items,
    Function(String) onChanged,
  ) {
    return PopupMenuButton<String>(
      offset: const Offset(0, 30),
      child: Row(
        children: [
          //  Text(
              //   "Trans Delta Trading",
              //   style: GoogleFonts.dosis(
              //     textStyle: TextStyle(
              //       color: Colors.white,
              //       fontSize: 28,
              //       fontWeight: FontWeight.w400,
              //     ),
              //   ),
              // ),
          Text(
            title,
            style: GoogleFonts.barlow (
 textStyle: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500
            ),)
          ),
          Icon(
            Icons.arrow_drop_down,
            color: Colors.white,
          )
        ],
      ),
      itemBuilder: (context) {
        return items.map((item) {
          return PopupMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList();
      },
      onSelected: (value) {
        onChanged(value);
      },
    );
  }
}

//-----mobile view of the AppBar-------

Widget custmobileDrawer(BuildContext context) {
  return ChangeNotifierProvider(
    create: (context) => DataProvider(),
    child: Theme(
      data: ThemeData(canvasColor: Colors.black
          // Set the background color of the Drawer to black
          ),
      child: Drawer(
        child: ListView(
          children: [
            SizedBox(
              height: 50,
            ),
            ExpansionTile(
              // collapsedBackgroundColor: janishcolor,
              iconColor: Colors.white,
              collapsedIconColor: Colors.white,
              title: Text(
                'Cable Terminal Ends',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 17), // Set the text color to white
              ),
              children: [
                ListTile(
                  hoverColor: Deltacolor,
                  title: Text(
                    'Lugs',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AppBarMain(body: LugsPage()),
                        ));
                  },
                ),
                ListTile(
                  hoverColor: Deltacolor,
                  title: Text(
                    'Connectors',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AppBarMain(body: ConnectersPage()),
                        ));
                  },
                ),
              ],
            ),
            Divider(),
            ExpansionTile(
              // collapsedBackgroundColor: janishcolor,
              iconColor: Colors.white,
              collapsedIconColor: Colors.white,
              title: Text(
                'Brass Cable Gland Kits & Accessories',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 17), // Set the text color to white
              ),
              children: [
                ListTile(
                  hoverColor: Deltacolor,
                  title: Text(
                    'Glands',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AppBarMain(body: GlandPage()),
                        ));
                  },
                ),
                ListTile(
                  hoverColor: Deltacolor,
                  title: Text(
                    'Accessories',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AppBarMain(body: AccessoriesPage()),
                        ));
                  },
                ),
              ],
            ),
            Divider(),
            ExpansionTile(
              iconColor: Colors.white,
              collapsedIconColor: Colors.white,
              title: Text(
                'Crimping Tool',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 17), // Set the text color to white
              ),
              children: [
                ListTile(
                  hoverColor: Deltacolor,
                  title: Text(
                    'Crimping Tool',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AppBarMain(body: CrimpingToolPage()),
                        ));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

class MobileAppBar extends StatelessWidget {
  final BuildContext context;

  MobileAppBar(this.context);

  final TextEditingController searchTextController = TextEditingController();
  var user = FirebaseAuth.instance.currentUser;
  int cartCount = 0;

  @override
  Widget build(BuildContext context) {
    if (user != null) {
      Provider.of<CartProvider>(context).getCartData();
      cartCount =
          Provider.of<CartProvider>(context).fetchedItems['cartItems'].length;
    }

    return Column(
      children: [
        AppBar(
          title: Row(
            children: [
              InkWell(
                onTap: () {
                  // Navigate to the named route '/your_destination_screen'
                  Navigator.pushNamed(context, '/');
                },
                child: Image.asset(
                                  'assets/image/Yellow and Brown Modern Apparel Logo (6).png',
                                  width: 170,
                                  height: 60,
                                  fit: BoxFit.cover,
                                )),
              Spacer(),
              user == null
                  ? TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return LoginPage(); // Your custom dialog widget
                          },
                        );
                      },
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 194, 192, 192)),
                      ),
                      child: Text('SignUp/SignIn'),
                    )
                  : SizedBox(),
              GestureDetector(
                onTap: () {
                  user != null
                      ? Navigator.pushNamed(context, '/cart')
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpPage(),
                          ));
                },
                child: badges.Badge(
                  badgeContent: Text(
                    cartCount.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                  child: Icon(
                            Icons.shopping_bag_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
        ),
        Container(
          color: Deltacolor,
          padding: EdgeInsets.only(bottom: 5, top: 5, left: 55, right: 10),
          height: 49,
          width: double.infinity,
          child: searchBox(context),
        ),
      ],
    );
  }
}


// Widget productList(BuildContext context) {
//   final productProvider = Provider.of<ProductProvider>(context, listen: false);

//   return Expanded(
//     child: ListView.builder(
//       itemCount: productProvider.products.length,
//       itemBuilder: (context, index) {
//         final product = productProvider.products[index];
//         return ListTile(
//           title: Text(product['product_name']),
//           leading: Image.network(product['thumbnail']),
//         );
//       },
//     ),
//   );
// }
