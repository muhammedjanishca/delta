import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_hex/login_and_signing/signup_page.dart';
import 'package:firebase_hex/login_and_signing/welcome_page.dart';
import 'package:firebase_hex/pages/AccessoriesPage.dart';
import 'package:firebase_hex/pages/connecters.dart';
import 'package:firebase_hex/pages/crimping.dart';
import 'package:firebase_hex/pages/gland.dart';
import 'package:firebase_hex/pages/lugs.dart';
import 'package:firebase_hex/provider/data_provider.dart';
import 'package:firebase_hex/responsive/appbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'cart.dart';

class AppBarMain extends StatelessWidget {
  final Widget body;

  AppBarMain({
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DataProvider(),
      child: PreferredSize(
        preferredSize: const Size.fromHeight(105),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                // color: Colors.amber,
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width / 8),
                    // _searchBox(searchTextController), // Add the search box here
                    
                        // child: Image.asset("assets/image/deltalogo.jpg.jpg")
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
                    Expanded(child: _searchBox(searchTextController)),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpPage()),
                        );
                      },
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 99, 98,
                                98)), // Change the color to your desired color
                      ),
                      child: Text('SignUp/SignIn'),
                    ),

                    user != null
                        ? TextButton(
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                            },
                            child: Text('logout'))
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
                          child: Icon(Icons.shopping_cart)),
                                        SizedBox(width: MediaQuery.of(context).size.width / 8),

                  ],
                ),
              ),
              Container(
                height: 45,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(223, 13, 13, 13), // First color
                      Color.fromARGB(223, 0, 0, 0), // Second color
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
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
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
        ),
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

// Widget mobileDrawer(BuildContext context) {
//   return ChangeNotifierProvider(
//     create: (context) => DataProvider(),
//     child: Theme(
//       data: ThemeData(
//         canvasColor:
//             Colors.white, // Set the background color of the Drawer to black
//       ),
//       child: Drawer(
//         child: ListView(
//           children: [
//             SizedBox(
//               height: 50,
//             ),
//             ExpansionTile(
//               title: Text(
//                 'Crimping Tool',
//                 style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white), // Set the text color to white
//               ),
//               children: [
//                 ListTile(
//                   title: Text('Lugs'),
//                   onTap: () async {
//                      final dataProvider =
//                             Provider.of<DataProvider>(context, listen: false);
//                           final Lugsdata = await dataProvider.fetchLugsData();
//                    Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => AppBarMain(
//                                     body: LugsPage(
//                                       data: Lugsdata,
//                                     ),
//                                   ),
//                                 ));
//                   },
//                 ),
//                 ListTile(
//                   title: Text('Connectors'),
//                    onTap: () async {
//                      final dataProvider =
//                             Provider.of<DataProvider>(context, listen: false);
//                           final Connectersdata = await dataProvider.fetchConnectorsData();
//                    Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => AppBarMain(
//                                     body: LugsPage(
//                                       data: Connectersdata,
//                                     ),
//                                   ),
//                                 ));
//                   },
//                 ),
//               ],
//             ),
//             ExpansionTile(
//               title: Text(
//                 'Brass Cable Gland Kits & Accessories',
//                 style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white), // Set the text color to white
//               ),
//               children: [
//                 ListTile(
//                   title: Text('Glands'),
//                   onTap: () async {
//                      final dataProvider =
//                             Provider.of<DataProvider>(context, listen: false);
//                           final Glandsdata = await dataProvider.fetchGlandsData();
//                    Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => AppBarMain(
//                                     body: LugsPage(
//                                       data: Glandsdata,
//                                     ),
//                                   ),
//                                 ));
//                   },
//                 ),
//                 ListTile(
//                   title: Text('Accessories'),
//                   onTap: () async {
//                      final dataProvider =
//                             Provider.of<DataProvider>(context, listen: false);
//                           final Accessoriesdata = await dataProvider.fetchAccssoriesData();
//                    Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => AppBarMain(
//                                     body: LugsPage(
//                                       data: Accessoriesdata,
//                                     ),
//                                   ),
//                                 ));
//                   },
//                 ),
//               ],
//             ),
//             ExpansionTile(
//               title: Text(
//                 'Cable Terminal Ends',
//                 style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white), // Set the text color to white
//               ),
//               children: [
//                 ListTile(
//                   title: Text('Others'),

//                   onTap: () async {
//                      final dataProvider =
//                             Provider.of<DataProvider>(context, listen: false);
//                           final Crimpingtooldata = await dataProvider.fetchCrimpingtoolData();
//                    Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => AppBarMain(
//                                     body: LugsPage(
//                                       data: Crimpingtooldata,
//                                     ),
//                                   ),
//                                 ));
//                   },
//                   // Navigator.push(
//                   //               context,
//                   //               MaterialPageRoute(
//                   //                 builder: (context) => AppBarMain(
//                   //                   body: LugsPage(
//                   //                     data: Crimpingtooldata,
//                   //                   ),
//                   //                 ),
//                   //               ));
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }

class MobileAppBar extends StatelessWidget {
  final BuildContext context;

  MobileAppBar(this.context);

  final TextEditingController searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) => Column(
        children: [
          AppBar(
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
                IconButton(
                  icon:
                      Icon(Icons.shopping_cart), // The icon you want to display
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => CartPage()));
                    // Define the action to be performed when the button is pressed
                    // For example, you can navigate to a shopping cart page here
                    // or perform any other desired action.
                  },
                )
              ],
            ),
            backgroundColor: Color.fromARGB(255, 0, 0, 0),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 90),
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10), // Add padding around the search box
              height: 48, // Set the height of the container
              width: MediaQuery.of(context).size.width * 0.7,
              // color: Colors.amber, // Set the width of the container
              child: _searchBox(searchTextController),
            ),
          ),
        ],
      );
}

//###### search Box #######

Widget _searchBox(TextEditingController searchTextController) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Color.fromARGB(255, 222, 220, 220), // Background color is white
    ),
    child: Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: searchTextController,
            style: TextStyle(color: Colors.black), // Text color is black
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Search...',
              hintStyle: TextStyle(
                color: Colors.black.withOpacity(0.5),
              ), // Hint text color is black with some opacity
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            ),
          ),
        ),
        Container(
          height: 50,
          color: Color.fromARGB(255, 40, 38, 38),
          child: TextButton(
              child: Text(
                'clear',
                style: GoogleFonts.ubuntu(
                    textStyle:
                        TextStyle(color: Color.fromARGB(255, 131, 131, 128))),
              ),
              onPressed: () {
                searchTextController.clear();
              }),
        ),
      ],
    ),
  );
}
