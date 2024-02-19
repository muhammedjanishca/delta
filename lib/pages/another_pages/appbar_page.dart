import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_hex/pages/product_pages/AccessoriesPage.dart';
import 'package:firebase_hex/pages/product_pages/connecters.dart';
import 'package:firebase_hex/pages/product_pages/crimping.dart';
import 'package:firebase_hex/pages/product_pages/gland.dart';
import 'package:firebase_hex/pages/product_pages/lugs.dart';
import 'package:firebase_hex/provider/Refresh.dart';
import 'package:firebase_hex/provider/cart_provider.dart';
import 'package:firebase_hex/provider/data_provider.dart';
import 'package:firebase_hex/responsive/appbar.dart';
import 'package:firebase_hex/widgets/search_Bar.dart';
import 'package:firebase_hex/widgets/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pluto_menu_bar/pluto_menu_bar.dart';
import 'package:provider/provider.dart';
import '../../login_and_signing/authentication.dart';
import '../../login_and_signing/loginpage.dart';
import '../../main.dart';
import '../../provider/thumbnail.dart';
import '../../search_api.dart';
import '../../widgets/hover_text.dart';
import '../../widgets/whatsApp.dart';
import 'package:badges/badges.dart' as badges;

import 'contact_us.dart';

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
        preferredSize: Size.fromHeight(134),
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

class DesktopAppBar extends StatefulWidget {
  final BuildContext context;

  DesktopAppBar(this.context);

  @override
  State<DesktopAppBar> createState() => _DesktopAppBarState();
}

class _DesktopAppBarState extends State<DesktopAppBar> {
  final TextEditingController searchTextController = TextEditingController();

  late final List<PlutoMenuItem> whiteHoverMenus;

  int cartCount = 0;
  @override
  void initState() {
    super.initState();

    whiteHoverMenus = makeMenus(context);
  }

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

  List<PlutoMenuItem> makeMenus(BuildContext context) {
    return [
      PlutoMenuItem(
        title: '   ALL CATEGORIES                          ',
        icon: Icons.menu,
        children: [
          PlutoMenuItem(
            title: 'Cable Terminal Ends',
            // icon: Icons.group,
            onTap: () {},
            children: [
              PlutoMenuItem(
                title: 'Lugs',
                onTap: () {
                  Navigator.pushNamed(context, '/cable-terminal-ends/lugs/');
                },
              ),
              PlutoMenuItem(
                title: 'Connectors',
                onTap: () {
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
                  Navigator.pushNamed(context,
                      '/brass-cable-gland-kits-accessories/brass-cable-glands/');
                },
              ),
              PlutoMenuItem(
                title: 'Accessories',
                onTap: () {
                  Navigator.pushNamed(context,
                      '/brass-cable-gland-kits-accessories/brass-cable-gland-accessories/');
                },
              ),
            ],
          ),
          PlutoMenuItem(
            title: 'Crimping Tools',
            onTap: () {
              Navigator.pushNamed(context, '/crimping-tools/');
            },
          ),
          PlutoMenuItem(
            title: 'Earthing & Lightning Protection Systems',
            // icon: Icons.group,
            onTap: () {},

            children: [
              PlutoMenuItem(
                title: 'Earthing & Lightning Protection',
                onTap: () {
                  Navigator.pushNamed(context,
                      '/earthing-lightning-protection-systems/earthing-lightning-protection/');
                },
              ),
              PlutoMenuItem(
                title: 'ELPS - Accessories',
                onTap: () {
                  Navigator.pushNamed(context,
                      '/earthing-lightning-protection-systems/earthing-lightning-protection-accessories/');
                },
              ),
            ],
          ),
          PlutoMenuItem(
            title: 'Switch Board / Control Panel Accessories',
            onTap: () {
              Navigator.pushNamed(
                  context, '/switch-board-control-panel-accessories/');
            },
          ),
          PlutoMenuItem(
            title: 'Stainless Steel Cable Ties & Markers',
            onTap: () {
              Navigator.pushNamed(
                  context, '/Stainless Steel Cable Ties & Markers');
            },
            // children: [
            //   PlutoMenuItem(
            //     title: 'Roller Ball Type Stainless Steel Cable Ties',
            //     onTap: () {},
            //   ),
            //   PlutoMenuItem(
            //     title: 'Releasable Type Stainless Steel Cable Ties',
            //     onTap: () {},
            //   ),
            // ],
          ),
          PlutoMenuItem(
            title: 'Cable Support Systems',
            onTap: () {
              Navigator.pushNamed(context, '/cable-support-systems/');
            },
          ),
          PlutoMenuItem(
            title: 'Cable Jointing & Termination Kit Components',
            onTap: () {
              Navigator.pushNamed(
                  context, '/cable-jointing-and-termination-kit-components/');
            },
          ),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    final selectedThumbnailProvider =
        Provider.of<SelectedThumbnailProvider>(context);
    Provider.of<AuthenticationHelper>(context).getCurrentUser();
    var user = Provider.of<AuthenticationHelper>(context).user;
    if (user != null) {
      Provider.of<CartProvider>(context).getCartData();
      cartCount =
          Provider.of<CartProvider>(context).fetchedItems['cartItems'].length;
    }
    return ChangeNotifierProvider(
      create: (context) => DataProvider(),
      child: SafeArea(
        child: PreferredSize(
          preferredSize: Size.fromHeight(105),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Container(
                  color: colorOne,
                  // rgb(242, 239, 228)
                  // color: const Color.fromARGB(255, 70, 62, 62),

                  // color: const Color.fromARGB(255, 0, 0, 0),
                  //color: Color.fromARGB(255, 206, 205, 202),janish
                  height: 89,
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
                        child:
                         Image.network(
                          "https://deltabuckets.s3.ap-south-1.amazonaws.com/tdt+logos/TDT+-01.png",
                          width: 290,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                        // child: Image.asset(
                        //   'assets/image/Yellow and Brown Modern Apparel Logo (6).png',
                        //   width: 170,
                        //   height: 60,
                        //   fit: BoxFit.cover,
                        // ),
                      ),

                      SizedBox(
                        width: MediaQuery.of(context).size.width <=
                                1500 // You can adjust the threshold value (600 in this example) based on your preferred screen size
                            ? MediaQuery.of(context).size.width /
                                80 // If the screen width is less than 600, set width to half of the screen width
                            : MediaQuery.of(context).size.width /
                                10, // If the screen width is 600 or greater, set width to 1/8 of the screen width
                      ),
                      Container(
                        width: MediaQuery.of(context).size.height/3,
                        child: FittedBox(
                          child: Row(
                            children: [
                              MouseRegion(
                                onEnter: incrementEnter,
                                onHover: updateLocation,
                                onExit: incrementExit,
                                child: InkWell(
                                  child: Text(
                                    'Home',
                                    style: GoogleFonts.poppins(color: textColor),
                                  ),
                                  onTap: () {
                                    Navigator.pushNamed(context, '/');
                                  },
                                ),
                              ),
                              Gap(35),
                              MouseRegion(
                                onEnter: incrementEnterr,
                                onHover: updateLocationn,
                                onExit: incrementExitt,
                                child: InkWell(
                                  child: Text(
                                    'About Us',
                                    style: GoogleFonts.poppins(color: textColorr),
                                  ),
                                  onTap: () {
                                    Navigator.pushNamed(context, '/');
                                  },
                                ),
                              ),
                              Gap(35),
                              MouseRegion(
                                onEnter: incrementEnterrr,
                                onHover: updateLocationnn,
                                onExit: incrementExittt,
                                child: InkWell(
                                  child: Text(
                                    'Contact Us',
                                    style: GoogleFonts.poppins(color: textColorrr),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ContactUsPage()),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                      SizedBox(width: MediaQuery.of(context).size.width / 5),

                      user == null
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

                                  // TextButton(
                                  //     onPressed: () {
                                  // showDialog(
                                  //   context: context,
                                  //   builder: (BuildContext context) {
                                  //     return LoginPage(); // Your custom dialog widget
                                  //         },
                                  //       );
                                  //     },
                                  //     style: ButtonStyle(
                                  //       foregroundColor:
                                  //           MaterialStateProperty.all<Color>(Colors
                                  //               .white), // Change the color to your desired color
                                  //     ),
                                  //     child: Text(
                                  //       'Login',
                                  // style: GoogleFonts.poppins(
                                  //   textStyle: const TextStyle(
                                  //       color: Colors.black,
                                  //       // fontSize: 16,
                                  //       ),
                                  //       ),
                                  //     )),
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
                              )),
                      Gap(15),

                      Container(
                        height: 13,
                        width: .5,
                        color: Colors.black,
                      ),

                      // user != null
                      //     ? TextButton(
                      //         onPressed: () {
                      //           FirebaseAuth.instance.signOut();
                      //         },
                      //         child: Text('logout'))
                      //     : SizedBox(),
                      Gap(15),
                      InkWell(
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
                        child: Row(
                          children: [
                            badges.Badge(
                                badgeContent: Text(
                                  cartCount.toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                                child: Icon(
                                  Icons.shopping_cart_outlined,
                                  color: Colors.black26,
                                )),
                            Gap(10),
                            Text("My cart",
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    color: Colors.black,
                                    // fontSize: 16,
                                  ),
                                )),
                          ],
                        ),
                      ),

                      // SizedBox(width: MediaQuery.of(context).size.width / 70),

                      SizedBox(
                        width: MediaQuery.of(context).size.width <=
                                1550 // You can adjust the threshold value (600 in this example) based on your preferred screen size
                            ? MediaQuery.of(context).size.width /
                                58 // If the screen width is less than 600, set width to half of the screen width
                            : MediaQuery.of(context).size.width /
                                10, // If the screen width is 600 or greater, set width to 1/8 of the screen width
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 45,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: colorTwo
                    //  Color.fromRGBO(233, 119, 19, 0.922),
                    // color: Deltacolor,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 7,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 6,
                        child: PlutoMenuBar(
                          mode: PlutoMenuBarMode.hover,
                          menus: whiteHoverMenus,
                          backgroundColor: Colors.white,
                          itemStyle: PlutoMenuItemStyle(
                              // activatedColor: Colors.yellow,
                              // indicatorColor: Colors.black,
                              iconSize: 20,
                              iconScale: 50,
                              textStyle:
                                  GoogleFonts.poppins(color: Colors.black)),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 9.4,
                      ),

                      SizedBox(
                        height: 37,
                        width: MediaQuery.of(context).size.width / 3,
                        child: searchBox(context),
                        //  SearchBar(
                        //   hintText: 'Search here ...',
                        // ),
                      )
                      // SizedBox(
                      //     height: 38,
                      //     // height: MediaQuery.of(context).size.width/2,
                      //     width: MediaQuery.of(context).size.width / 3,
                      //     child: TypeAheadFormField<Map<String, dynamic>>(
                      //       textFieldConfiguration: TextFieldConfiguration(
                      //         decoration: InputDecoration(
                      //           hintText: 'Search here...',
                      //           hintStyle: TextStyle(
                      //             color: Colors.black.withOpacity(0.5),
                      //             fontSize: 16,
                      //           ),
                      //           fillColor: Color.fromARGB(255, 191, 191, 190),
                      //           filled: true,
                      //           prefixIcon: Icon(
                      //             Icons.search,
                      //             color: Color.fromARGB(221, 101, 101, 101),
                      //           ),
                      //           // suffixIcon: ElevatedButton(
                      //           //     onPressed: () {},
                      //           //     child: Text("Search"))
                      //         ),
                      //       ),
                      //       suggestionsCallback: (query) async {
                      //         // Only call the fetchData() method if the search query is not empty.
                      //         if (query.isNotEmpty) {
                      //           return await productProvider.fetchData(query);
                      //         } else {
                      //           return [];
                      //         }
                      //       },
                      //       itemBuilder: (context, suggestion) {
                      //         return SizedBox(
                      //           child: ListTile(
                      //             leading: CircleAvatar(
                      //               backgroundImage:
                      //                   NetworkImage(suggestion['thumbnail']),
                      //             ),
                      //             title: Text(suggestion['product_name']),
                      //           ),
                      //         );
                      //       },
                      //       onSuggestionSelected: (suggestion) {
                      //         final productName = suggestion['product_name'];
                      //         final type = suggestion['type'];
                      //         final productNameWithUnderscores =
                      //             productName.replaceAll(" ", "_");
                      //         // final thumbnail = suggestion["thumbnail"];
                      //         selectedThumbnailProvider.setSelectedThumbnail("",
                      //             index: null);
                      //         navigateToProductDetailsFromSearch(
                      //             context, productNameWithUnderscores, type);
                      //       },
                      //     ))
                    ],
                  ),

//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Container(width: 50),
//                       Container(
//                         color: Colors.amber,
// //                         child: _buildPopupMenuButton(
// //   context,
// //   'Cable Terminal Ends',
// //   ['Lugs', 'Connectors','Glands','Accessories','Crimping Tools',],
// //   ['/Lugs', '/Connectors','/Glands','/Accessories','/CrimpingTools'],
// //   (selectedDataType) async {
// //     // You can perform additional actions if needed
// //   },
// // ),
//                       ),
//                       // _buildPopupMenuButton(
//                       //   context,
//                       //   'Brass Cable Gland Kits & Accessories',
//                       //   ['Glands', 'Accessories'],
//                       //   (selectedDataType) async {
//                       //     if (selectedDataType == 'Glands') {
//                       //       Navigator.pushNamed(context, '/Glands');
//                       //     } else if (selectedDataType == 'Accessories') {
//                       //       Navigator.pushNamed(context, '/Accessories');
//                       //     }
//                       //     // Add similar conditions for other data types
//                       //   },
//                       // ),
//                       //  _buildPopupMenuButton(
//                       //   context,
//                       //   'Brass Cable Gland Kits & Accessories',
//                       //   ['Crimping Tool', 'conduits','ELPS Accessories'],
//                       //   (selectedDataType) async {
//                       //     if (selectedDataType == 'Crimping Tool') {
//                       //       Navigator.pushNamed(context, '/CrimpingTools');
//                       //     } else if (selectedDataType == 'conduits') {
//                       //       Navigator.pushNamed(context, '/conduits');
//                       //     }
//                       //   },
//                       // ),
//                       // _buildPopupMenuButton(
//                       //   context,
//                       //   'ELPS Accessories',
//                       //   ['ELPS Accessories'],
//                       //   (selectedDataType) async {
//                       //     if (selectedDataType == 'ELPS Accessories') {
//                       //       Navigator.pushNamed(context, '/ELPS Accessories');
//                       //     }
//                       //   },
//                       // ),
//                       SizedBox(width: 50),
//                     ],
//                   ),
                )
              ],
            ),
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
    List<String> routes,
    Function(String) onChanged,
  ) {
    return PopupMenuButton<String>(
      offset: const Offset(0, 30),
      child: Row(
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
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
        int index = items.indexOf(value);
        if (index != -1 && index < routes.length) {
          Navigator.pushNamed(context, routes[index]);
          onChanged(value);
        }
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
                  hoverColor: Color.fromRGBO(249, 156, 6, 1.0),
                  title: Text(
                    'Lugs',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AppBarMain(
                              body: RefreshIndicator(
                                  onRefresh: refresh, child: LugsPage())),
                        ));
                  },
                ),
                ListTile(
                  hoverColor: Color.fromRGBO(249, 156, 6, 1.0),
                  title: Text(
                    'Connectors',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AppBarMain(
                              body: RefreshIndicator(
                                  onRefresh: refresh, child: ConnectersPage())),
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
                  hoverColor: Color.fromRGBO(249, 156, 6, 1.0),
                  title: Text(
                    'Glands',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AppBarMain(
                              body: RefreshIndicator(
                                  onRefresh: refresh, child: GlandPage())),
                        ));
                  },
                ),
                ListTile(
                  hoverColor: Color.fromRGBO(249, 156, 6, 1.0),
                  title: Text(
                    'Accessories',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AppBarMain(
                              body: RefreshIndicator(
                                  onRefresh: refresh,
                                  child: AccessoriesPage())),
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
                  hoverColor: Color.fromRGBO(249, 156, 6, 1.0),
                  title: Text(
                    'Crimping Tool',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AppBarMain(
                              body: RefreshIndicator(
                                  onRefresh: refresh,
                                  child: CrimpingToolPage())),
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
// hyjyfjf
    return Column(
      children: [
        SafeArea(
          child: AppBar(
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
                        child: Text(
                          'SignUp/SignIn',
                          style: TextStyle(color: Colors.black, fontSize: 11),
                        ),
                      )
                    : SizedBox(),
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
                        color: Colors.black,
                      )),
                ),
              ],
            ),
            backgroundColor: Color.fromARGB(255, 206, 205, 202),
          ),
        ),
        Container(
          color: Color.fromRGBO(249, 156, 6, 1.0),
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
