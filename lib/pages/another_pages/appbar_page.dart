import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_hex/pages/another_pages/cart.dart';
import 'package:firebase_hex/pages/product_pages/AccessoriesPage.dart';
import 'package:firebase_hex/pages/product_pages/Cjtkc.dart';
import 'package:firebase_hex/pages/product_pages/Sbcpa.dart';
import 'package:firebase_hex/pages/product_pages/conduite.dart';
import 'package:firebase_hex/pages/product_pages/connecters.dart';
import 'package:firebase_hex/pages/product_pages/crimping.dart';
import 'package:firebase_hex/pages/product_pages/elps.dart';
import 'package:firebase_hex/pages/product_pages/elps_accessories.dart';
import 'package:firebase_hex/pages/product_pages/gland.dart';
import 'package:firebase_hex/pages/product_pages/lugs.dart';
import 'package:firebase_hex/pages/product_pages/ssctm.dart';
import 'package:firebase_hex/provider/Refresh.dart';
import 'package:firebase_hex/provider/cart_provider.dart';
import 'package:firebase_hex/provider/data_provider.dart';
import 'package:firebase_hex/responsive/appbar.dart';
import 'package:firebase_hex/widgets/Appbar_widgets.dart';
import 'package:firebase_hex/widgets/search_Bar.dart';
import 'package:firebase_hex/widgets/style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pluto_menu_bar/pluto_menu_bar.dart';
import 'package:provider/provider.dart';
import '../../login_and_signing/authentication.dart';
import '../../login_and_signing/loginpage.dart';
import '../../widgets/whatsApp.dart';
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

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double Width = screenWidth < 950
        ? MediaQuery.of(context).size.width / 4.5
        : MediaQuery.of(context).size.width / 6;

    // Define your mode based on screen width
    PlutoMenuBarMode menuBarMode =
        screenWidth <= 1050 ? PlutoMenuBarMode.tap : PlutoMenuBarMode.hover;
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
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Container(
                  color: colorOne,
                  height: 89,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          // Navigate to the named route '/your_destination_screen'
                          Navigator.pushNamed(context, '/');
                        },
                        child: Image.network(
                          "https://deltabuckets.s3.ap-south-1.amazonaws.com/tdt+logos/TDT+-01.png",
                          width: 290,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      HoverText(),
                      SizedBox(
                        child: Row(
                          children: [
                            LoginAndLogOut(),
                            Gap(15),
                            Container(
                              height: 13,
                              width: .5,
                              color: Colors.black,
                            ),
                            Gap(15),
                            InkWell(
                              onTap: () {
                                user != null
                                    ? (cartCount != 0
                                        ? Navigator.pushNamed(context, '/cart')
                                        : Navigator.pushNamed(
                                            context, '/cartempty'))
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
                                  Text("My Cart",
                                      style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                          color: Colors.black,
                                          // fontSize: 16,
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 45,
                  width: double.infinity,
                  decoration: BoxDecoration(color: colorTwo),
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 7,
                      ),
                      SizedBox(
                        width: Width,
                        child: PlutoMenuBar(
                          mode: menuBarMode,
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
                      )
                    ],
                  ),
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
      data: ThemeData(
        canvasColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.red),
        // Set the background color of the Drawer to black
      ),
      child: Drawer(
        backgroundColor: colorOne,
        child: ListView(
          // Text("Login",
          //                             style: GoogleFonts.poppins(
          //                               textStyle: const TextStyle(
          //                                 color: Colors.black,
          //                                 // fontSize: 16,
          //                               ),
          //                             )),
          children: [
            Gap(25),
            ExpansionTile(
              // collapsedBackgroundColor: Colors.amber,

              iconColor: Colors.black,
              collapsedIconColor: Colors.black,
              title: Text(
                'Cable Terminal Ends',
                style: GoogleFonts.poppins(
                    // fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 15), // Set the text color to white
              ),
              children: [
                ListTile(
                  tileColor: colorTwo, // Set background color for Lugs

                  hoverColor: colorOne,
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
                Divider(
                  color: colorTwo,
                  height: 1,
                ),
                ListTile(
                  tileColor: colorTwo, // Set background color for Lugs
                  hoverColor: colorTwo,
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
            Divider(
              color: colorTwo,
            ),
            ExpansionTile(
              // collapsedBackgroundColor: janishcolor,
              iconColor: Colors.black,
              collapsedIconColor: Colors.black,
              title: Text(
                'Brass Cable Gland Kits & Accessories',
                style: GoogleFonts.poppins(
                    // fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 15), // Set the text color to white
              ),
              children: [
                ListTile(
                  tileColor: colorTwo, // Set background color for Lugs

                  hoverColor: colorOne,

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
                Divider(
                  color: colorTwo,
                  height: 1,
                ),
                ListTile(
                  tileColor: colorTwo, // Set background color for Lugs
                  hoverColor: colorTwo,
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
            Divider(
              color: colorTwo,
            ),
            ExpansionTile(
              iconColor: Colors.black,
              collapsedIconColor: Colors.black,
              title: Text(
                'Crimping Tool',
                style: GoogleFonts.poppins(
                    // fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 15), // Set the text color to white
              ),
              children: [
                ListTile(
                  tileColor: colorTwo, // Set background color for Lugs

                  hoverColor: colorOne,
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
            Divider(
              color: colorTwo,
              height: 1,
            ),
            ExpansionTile(
              // collapsedBackgroundColor: janishcolor,

              iconColor: Colors.black,
              collapsedIconColor: Colors.black,
              title: Text(
                'Earthing & Lightning Protection Systems',
                style: GoogleFonts.poppins(
                    // fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 15), // Set the text color to white
              ),
              children: [
                ListTile(
                  tileColor: colorTwo, // Set background color for Lugs

                  hoverColor: colorTwo,
                  title: Text(
                    'Earthing & Lightning Protection',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AppBarMain(
                              body: RefreshIndicator(
                                  onRefresh: refresh, child: Elps())),
                        ));
                  },
                ),
                Divider(
                  color: colorTwo,
                  height: 1,
                ),
                ListTile(
                  tileColor: colorTwo, // Set background color for Lugs
                  hoverColor: colorTwo,
                  title: Text(
                    'ELPS - Accessories',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AppBarMain(
                              body: RefreshIndicator(
                                  onRefresh: refresh,
                                  child: ElpsAccessories())),
                        ));
                  },
                ),
              ],
            ),
            Divider(
              color: colorTwo,
            ),
            ExpansionTile(
              iconColor: Colors.black,
              collapsedIconColor: Colors.black,
              title: Text(
                'Switch Board / Control Panel Accessories',
                style: GoogleFonts.poppins(
                    // fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 15), // Set the text color to white
              ),
              children: [
                ListTile(
                  tileColor: colorTwo, // Set background color for Lugs

                  hoverColor: colorOne,
                  title: Text(
                    'Switch Board / Control Panel Accessories',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AppBarMain(
                              body: RefreshIndicator(
                                  onRefresh: refresh, child: SbcpaProduct())),
                        ));
                  },
                ),
              ],
            ),
   Divider(
              color: colorTwo,
            ),            ExpansionTile(
              iconColor: Colors.black,
              collapsedIconColor: Colors.black,
              title: Text(
                'Stainless Steel Cable Ties & Markers',
                style: GoogleFonts.poppins(
                    // fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 15), // Set the text color to white
              ),
              children: [
                ListTile(
                  tileColor: colorTwo, // Set background color for Lugs

                  hoverColor: colorOne,
                  title: Text(
                    'Stainless Steel Cable Ties & Markers',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AppBarMain(
                              body: RefreshIndicator(
                                  onRefresh: refresh, child: SsctmProduct())),
                        ));
                  },
                ),
              ],
            ),
            Divider(
              color: colorTwo,
              height: 1,
            ),
            ExpansionTile(
              iconColor: Colors.black,
              collapsedIconColor: Colors.black,
              title: Text(
                'Cable Support Systems',
                style: GoogleFonts.poppins(
                    // fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 15), // Set the text color to white
              ),
              children: [
                ListTile(
                  tileColor: colorTwo, // Set background color for Lugs

                  hoverColor: colorOne,
                  title: Text(
                    'Cable Support Systems',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AppBarMain(
                              body: RefreshIndicator(
                                  onRefresh: refresh, child: ConduitesPage())),
                        ));
                  },
                ),
              ],
            ),
            Divider(
              color: colorTwo,
            ),
            ExpansionTile(
              iconColor: Colors.black,
              collapsedIconColor: Colors.black,
              title: Text(
                'Cable Jointing & Termination Kit Components',
                style: GoogleFonts.poppins(
                    // fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 15), // Set the text color to white
              ),
              children: [
                ListTile(
                  tileColor: colorTwo, // Set background color for Lugs

                  hoverColor: colorOne,
                  title: Text(
                    'Cable Jointing & Termination Kit Components',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AppBarMain(
                              body: RefreshIndicator(
                                  onRefresh: refresh, child: CjtkcPage())),
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
            elevation: 0,
            backgroundColor: colorTwo,
            title: Container(
              // color: Colors.yellow,
              // height: 100,
              child: Row(
                children: [
                  InkWell(
                      onTap: () {
                        // Navigate to the named route '/your_destination_screen'
                        Navigator.pushNamed(context, '/');
                      },
                      child: SizedBox(
                        height: 100,
                        width: 170,
                        child: Image.network(
                          "https://deltabuckets.s3.ap-south-1.amazonaws.com/tdt+logos/TDT+-04.png",
                          // width: 30,
                          // height: 10,
                          // fit: BoxFit.cover,
                        ),
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
                          child: Text("Login",
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  // fontSize: 16,
                                ),
                              )),
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
                            style: GoogleFonts.poppins(color: Colors.white),
                          )),
                  Gap(2),
                  Container(
                    height: 13,
                    width: .5,
                    color: Colors.white,
                  ),
                  Gap(12),
                  GestureDetector(
                    onTap: () {
                      user != null
                          ? (cartCount != 0
                              ? Navigator.pushNamed(context, '/cart')
                              : Navigator.pushNamed(context, '/cartempty'))
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
                          Icons.shopping_cart_outlined,
                          color: Colors.white,
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          color: colorTwo,
          height: 78,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 50,
                child: searchBox(context),
              ),
              // Gap(25)
            ],
          ),
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
