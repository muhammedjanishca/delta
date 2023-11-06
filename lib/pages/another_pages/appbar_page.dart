import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_hex/login_and_signing/signup_page.dart';
import 'package:firebase_hex/pages/product_pages/AccessoriesPage.dart';
import 'package:firebase_hex/pages/product_pages/connecters.dart';
import 'package:firebase_hex/pages/product_pages/crimping.dart';
import 'package:firebase_hex/pages/product_pages/gland.dart';
import 'package:firebase_hex/pages/product_pages/lugs.dart';
import 'package:firebase_hex/provider/cart_provider.dart';
import 'package:firebase_hex/provider/data_provider.dart';
import 'package:firebase_hex/responsive/appbar.dart';
import 'package:firebase_hex/api/search_api.dart';
import 'package:firebase_hex/widgets/style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../login_and_signing/authentication.dart';
import '../../login_and_signing/loginpage.dart';
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
                color: Colors.black,
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
                      child: Text(
                        'DELTA',
                        style: GoogleFonts.oswald(
                          textStyle: TextStyle(
                            color: Color.fromARGB(255, 251, 236, 221),
                            fontSize: 45,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "NATIONAL",
                      style: GoogleFonts.oswald(
                        textStyle: const TextStyle(
                          color: Color.fromARGB(255, 251, 236, 221),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),

                    SizedBox(width: MediaQuery.of(context).size.width / 15),

                    // Spacer(),
                    Expanded(child: _searchBox(context)),
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
                              foregroundColor: MaterialStateProperty.all<
                                  Color>(const Color
                                      .fromARGB(255, 194, 192,
                                  192)), // Change the color to your desired color
                            ),
                            child: Text('SignUp/SignIn'),
                          )
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
                                            color: Colors.white),
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
                            Icons.shopping_cart,
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
                  color: Deltacolor,
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
                          Navigator.pushNamed(context, '/Connecters');
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
                          Navigator.pushNamed(context, '/Accssories');
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
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
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
                child: Text(
                  'DELTA',
                  style: GoogleFonts.oswald(
                    textStyle: TextStyle(
                      color: Color.fromARGB(255, 251, 236, 221),
                      fontSize: 35,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Text(
                "NATIONAL",
                style: GoogleFonts.oswald(
                  textStyle: const TextStyle(
                    color: Color.fromARGB(255, 251, 236, 221),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
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
                    Icons.shopping_cart,
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
          child: _searchBox(context),
        ),
      ],
    );
  }
}

//###### search Box #######

Widget _searchBox(BuildContext context) {
  final productProvider = Provider.of<ProductProvider>(context, listen: false);

  return Container(
    height: MediaQuery.of(context).size.height / 18,
    // width: MediaQuery.of(context).size.width/2,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4),
      color: Color.fromARGB(255, 229, 226, 226), // Background color is white
    ),
    child: Row(
      children: [
        Expanded(
          child: TypeAheadFormField<Map<String, dynamic>>(
            textFieldConfiguration: TextFieldConfiguration(
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'What are you looking for?',
                hintStyle: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                  fontSize: 16,
                ),
                enabledBorder: OutlineInputBorder(),
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                suffixIcon: Icon(Icons.search,
                    color: Color.fromARGB(255, 155, 154, 154)),
              ),
            ),
            suggestionsCallback: (query) async {
              // Only call the fetchData() method if the search query is not empty.
              if (query.isNotEmpty) {
                return await productProvider.fetchData(query);
              } else {
                return [];
              }
            },
            itemBuilder: (context, suggestion) {
              return SizedBox(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(suggestion['thumbnail']),
                  ),
                  title: Text(suggestion['product_name']),
                ),
              );
            },
            onSuggestionSelected: (suggestion) {
              // Handle search submission here
            },
          ),
        ),
      ],
    ),
  );
}

Widget _productList(BuildContext context) {
  final productProvider = Provider.of<ProductProvider>(context, listen: false);

  return Expanded(
    child: ListView.builder(
      itemCount: productProvider.products.length,
      itemBuilder: (context, index) {
        final product = productProvider.products[index];
        return ListTile(
          title: Text(product['product_name']),
          leading: Image.network(product['thumbnail']),
        );
      },
    ),
  );
}
