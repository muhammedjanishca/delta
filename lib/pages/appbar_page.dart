import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_hex/login_and_signing/signup_page.dart';
import 'package:firebase_hex/pages/AccessoriesPage.dart';
import 'package:firebase_hex/pages/connecters.dart';
import 'package:firebase_hex/pages/crimping.dart';
import 'package:firebase_hex/pages/gland.dart';
import 'package:firebase_hex/pages/lugs.dart';
import 'package:firebase_hex/provider/cart_provider.dart';
import 'package:firebase_hex/provider/data_provider.dart';
import 'package:firebase_hex/responsive/appbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../login_and_signing/loginpage.dart';
import '../whatsApp.dart';
import 'cart.dart';
import 'package:badges/badges.dart' as badges;

void _handlePopupSelection(String choice) {
  // Handle the selected menu item here
  switch (choice) {
    case 'Account':
      // Handle Account action
      break;
    case 'Login':
      // Handle Login action
      break;
    case 'Logout':
      // Handle Logout action
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
  var user = FirebaseAuth.instance.currentUser;
  int cartCount = 0;
  @override
  Widget build(BuildContext context) {
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
                    SizedBox(width: MediaQuery.of(context).size.width / 8),
                    // _searchBox(searchTextController), // Add the search box here
                    // child: Image.asset("assets/image/deltalogo.jpg.jpg")
                    Text(
                      'DELTA',
                      style: GoogleFonts.oswald(
                        textStyle: TextStyle(
                            color: Color.fromARGB(255, 251, 236, 221),
                            fontSize: 45,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Spacer(),
                    Expanded(child: _searchBox(searchTextController, context)),
                    SizedBox(width: MediaQuery.of(context).size.width / 70),

                   user==null? TextButton(
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
                            const Color.fromARGB(255, 194, 192,
                                192)), // Change the color to your desired color
                      ),
                      child: Text('SignUp/SignIn'),
                    ):SizedBox(),

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
                              0, 100, 0, 0), // Adjust the position as needed
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
                              value: 'Logout',
                              child: Text('Logout'),
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
                          )),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width / 8),
                  ],
                ),
              ),
              Container(
                height: 41,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 76, 138, 131),
                  // gradient: LinearGradient(
                  //   colors: ,
                  //   // colors: [
                  //   //   Color.fromARGB(223, 13, 13, 13), // First color
                  //   //   Color.fromARGB(223, 0, 0, 0), // Second color
                  //   // ],
                  //   begin: Alignment.topCenter,
                  //   end: Alignment.bottomCenter,
                  // ),
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
                        final dataProvider =
                            Provider.of<DataProvider>(context, listen: false);
                        if (selectedDataType == 'Lugs') {
                          // final connectorsData =
                          //     await dataProvider.fetchConnectorsData();
                          final lugsdata = await dataProvider.fetchLugsData();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AppBarMain(body: LugsPage()),
                              ));
                        } else if (selectedDataType == 'Connectors') {
                          final connectorsData =
                              await dataProvider.fetchConnectorsData();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AppBarMain(body: ConnectersPage()),
                              ));
                        }
                        // Add similar conditions for other data types
                      },
                    ),
                    _buildPopupMenuButton(
                      context,
                      'Brass Cable Gland Kits & Accessories',
                      ['Glands', 'Accessories'],
                      (selectedDataType) async {
                        final dataProvider =
                            Provider.of<DataProvider>(context, listen: false);
                        if (selectedDataType == 'Glands') {
                          // final connectorsData =
                          //     await dataProvider.fetchConnectorsData();
                          final glandsdata =
                              await dataProvider.fetchGlandsData();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AppBarMain(body: GlandPage()),
                              ));
                        } else if (selectedDataType == 'Accessories') {
                          final AccessoriesData =
                              await dataProvider.fetchAccssoriesData();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AppBarMain(body: AccessoriesPage()),
                              ));
                        }
                        // Add similar conditions for other data types
                      },
                    ),
                    _buildPopupMenuButton(
                      context,
                      'Crimping Tool',
                      ['Crimping Tool'],
                      (selectedDataType) async {
                        final dataProvider =
                            Provider.of<DataProvider>(context, listen: false);
                        if (selectedDataType == 'Crimping Tool') {
                          final Crimpingtooldata =
                              await dataProvider.fetchCrimpingtoolData();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AppBarMain(body: CrimpingToolPage()),
                              ));
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
      data: ThemeData(
        canvasColor:
            Color.fromARGB(255, 0, 0, 0), // Set the background color of the Drawer to black
      ),
      child: Drawer(
        child: ListView(
          children: [
            SizedBox(
              height: 50,
            ),
            ExpansionTile(
              title: Text(
                'Crimping Tool',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white), // Set the text color to white
              ),
              children: [
                ListTile(
                  title: Text('Lugs'),
                  onTap: () async {
                    final dataProvider =
                        Provider.of<DataProvider>(context, listen: false);
                    final Lugsdata = await dataProvider.fetchLugsData();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AppBarMain(body: LugsPage()),
                        ));
                  },
                ),
                ListTile(
                  title: Text('Connectors'),
                  onTap: () async {
                    final dataProvider =
                        Provider.of<DataProvider>(context, listen: false);
                    final Connectersdata =
                        await dataProvider.fetchConnectorsData();
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
            ExpansionTile(
              title: Text(
                'Brass Cable Gland Kits & Accessories',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white), // Set the text color to white
              ),
              children: [
                ListTile(
                  title: Text('Glands'),
                  onTap: () async {
                    final dataProvider =
                        Provider.of<DataProvider>(context, listen: false);
                    final Glandsdata = await dataProvider.fetchGlandsData();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AppBarMain(body: GlandPage()),
                        ));
                  },
                ),
                ListTile(
                  title: Text('Accessories'),
                  onTap: () async {
                    final dataProvider =
                        Provider.of<DataProvider>(context, listen: false);
                    final Accessoriesdata =
                        await dataProvider.fetchAccssoriesData();
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
            ExpansionTile(
              title: Text(
                'Cable Terminal Ends',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white), // Set the text color to white
              ),
              children: [
                ListTile(
                  title: Text('Others'),

                  onTap: () async {
                    final dataProvider =
                        Provider.of<DataProvider>(context, listen: false);
                    final Crimpingtooldata =
                        await dataProvider.fetchCrimpingtoolData();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AppBarMain(body: CrimpingToolPage()),
                        ));
                  },
                  // Navigator.push(
                  //               context,
                  //               MaterialPageRoute(
                  //                 builder: (context) => AppBarMain(
                  //                   body: LugsPage(
                  //                     data: Crimpingtooldata,
                  //                   ),
                  //                 ),
                  //               ));
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

  @override
 Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'Delta',
              style: GoogleFonts.pacifico(
                textStyle: TextStyle(
                  color: Color.fromARGB(255, 122, 102, 54),
                  fontSize: 35,
                ),
              ),
            ),
            Spacer(),
             user==null? TextButton(
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
                            const Color.fromARGB(255, 194, 192,
                                192)), // Change the color to your desired color
                      ),
                      child: Text('SignUp/SignIn'),
                    ):SizedBox(),
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CartPage()));
              },
            )
          ],
        ),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
      ),
      drawer:custmobileDrawer(context),
      
      body: Padding(
        padding: const EdgeInsets.only(left: 90),
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10), // Add padding around the search box
          height: 48, // Set the height of the container
          width: MediaQuery.of(context).size.width * 0.7,
          // color: Colors.amber, // Set the width of the container
          child: _searchBox(searchTextController, context),
        ),
      ),
    );

}

//###### search Box #######

Widget _searchBox(TextEditingController searchTextController, context) {
  return Container(
    height: MediaQuery.of(context).size.height / 18,
    // width: MediaQuery.of(context).size.width/0.10,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4),
      color: Colors.white, // Background color is white
    ),
    child: Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: searchTextController,
            style: TextStyle(color: Colors.black), // Text color is black
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'What are you looking for?',
              hintStyle: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                  fontSize: 16), // Hint text color is black with some opacity
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              // prefixIcon: Icon(Icons.search, color: Colors.black), // Search lens icon
              suffixIcon:
                  Icon(Icons.search, color: Color.fromARGB(255, 155, 154, 154)),
              //  IconButton(
              //   icon: Icon(Icons.clear, color: Colors.black),
              //   onPressed: () {
              //     // Clear text field
              //     searchTextController.clear();
              //   },
              // ),
            ),
          ),
        ),
      ],
    ),
  );
}
 