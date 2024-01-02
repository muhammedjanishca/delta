import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_hex/login_and_signing/authentication.dart';
import 'package:firebase_hex/login_and_signing/signup_page.dart';
import 'package:firebase_hex/pages/address.dart/color_change_provider.dart';
import 'package:firebase_hex/pages/details_pages/crimping_tool.dart';
import 'package:firebase_hex/pages/product_pages/AccessoriesPage.dart';
import 'package:firebase_hex/pages/another_pages/appbar_page.dart';
import 'package:firebase_hex/pages/another_pages/cart.dart';
import 'package:firebase_hex/pages/product_pages/connecters.dart';
import 'package:firebase_hex/pages/product_pages/crimping.dart';
import 'package:firebase_hex/pages/product_pages/gland.dart';
import 'package:firebase_hex/pages/another_pages/landing_page.dart';
import 'package:firebase_hex/pages/product_pages/lugs.dart';
import 'package:firebase_hex/pages/details_pages/accessories_product.dart';
import 'package:firebase_hex/pages/details_pages/connecters_productd.dart';
import 'package:firebase_hex/pages/details_pages/gland_productdetails.dart';
import 'package:firebase_hex/pages/details_pages/lugs_productdetails.dart';
import 'package:firebase_hex/pages/details_pages/nonpdf_product.dart';
import 'package:firebase_hex/provider/Text_color.dart';
import 'package:firebase_hex/provider/address_provider.dart';
import 'package:firebase_hex/provider/cart_provider.dart';
import 'package:firebase_hex/provider/data_provider.dart';
import 'package:firebase_hex/provider/hover_image_provider.dart';
import 'package:firebase_hex/provider/pdf_provider.dart';
import 'package:firebase_hex/provider/thumbnail.dart';
import 'package:firebase_hex/provider/user_input_provider.dart';
import 'package:firebase_hex/search_api.dart';
import 'package:firebase_hex/widgets/fetch_invoice.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    authDomain: "login-fab91.firebaseapp.com",
    apiKey: "AIzaSyAZX6f4F_fXF9gI5ckltoKmnO34OZAixXs",
    appId: "1:461889425921:web:b9d4481b84a3345161a600",
    messagingSenderId: "461889425921",
    projectId: "login-fab91",
  ));

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthenticationHelper()),
        ChangeNotifierProvider(create: (context) => DataProvider()),
        ChangeNotifierProvider(create: (context) => SelectedThumbnailProvider()),
        ChangeNotifierProvider(create: (context) => SelectedCodeProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => UserInputProvider()),
        ChangeNotifierProvider(create: (context) => SelectedPriceNotifier()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => UserInputProvider()),
     // ChangeNotifierProvider(create: (context) => TextProvider()),
        ChangeNotifierProvider(create: (context) => ImageHoveroProvider()),
        ChangeNotifierProvider(create: (context) => ImageSelection()),
        ChangeNotifierProvider(create: (context) => SelectedKiduProvider()),
        ChangeNotifierProvider(create: (context) => AddressProvider()),
        ChangeNotifierProvider(create: (context) => SelectedKiduProvider()),
        ChangeNotifierProvider(create: (context) => ColorChangingProvider()),
        ChangeNotifierProvider(create: (context) => SelectedPriceProvider()),
      ],
      child: MaterialApp(
        title: "TRANS DELTA TRADING",
        theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 206, 205, 202)
        ),
        //this use using for handle null data
        builder: (context, widget) {
          Widget error = Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              color: Colors.white,
              child: Center(
                child: SizedBox(
                    height: 100,
                    width: 100,
                    child: Center(
                                        child:Lottie.asset("assets/image/BKVtkcmqbx (1).json")

                    )),
              ));
          if (widget is Scaffold || widget is Navigator) {
            error = Scaffold(body: Center(                  child:Lottie.asset("assets/image/BKVtkcmqbx (1).json")
));
          }
          ErrorWidget.builder = (errorDetails) {
            return Center(                  child:Lottie.asset("assets/image/BKVtkcmqbx (1).json")
);
            // Text(errorDetails.toString());
          };
          if (widget != null) return widget;
          throw ('widget is null');
        },
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => AppBarMain(body: LandinPage()),
      
          '/cart': (context) => AppBarMain(
                body: CartPage(),
              ),
          '/Lugs': (context) => AppBarMain(
                body: LugsPage(),
              ),
          '/Glands': (context) => AppBarMain(
                body: GlandPage(),
              ),
          '/signup/signin': (context) => SignUpPage(),
          '/Accessories': (context) => AppBarMain(
                body: AccessoriesPage(),
              ),
          '/Connectors': (context) => AppBarMain(body: ConnectersPage()),
          '/CrimpingTools': (context) => AppBarMain(
                body: CrimpingToolPage(),
              ),
          // '/sighn':(context) => SignUpPage()
        },
        initialRoute: '/',
        onGenerateRoute: (RouteSettings setting) {
          List<String> elements = setting.name!.split('/');
          if (elements[0] == '') {
            switch (elements[1]) {
              case "productdetailsglands":
                return MaterialPageRoute(
                  builder: (BuildContext context) {
                    return AppBarMain(body: ProductDetailsOfGlands());
                  },
                  settings: setting,
                );
              case "productdetailslugs":
                return MaterialPageRoute(
                  builder: (BuildContext context) {
                    return AppBarMain(
                      body: ProductDetailsoflugs(),
                    );
                  },
                  settings: setting,
                );
              case "productdetailsconnectors":
                return MaterialPageRoute(
                  builder: (BuildContext context) {
                    return AppBarMain(
                      body: ProductDetailsOfConnectors(),
                    );
                  },
                  settings: setting,
                );
              case "productdetailsaccessories":
                return MaterialPageRoute(
                  builder: (BuildContext context) {
                    return AppBarMain(
                      body: ProductDetailsOfAccessories(),
                    );
                  },
                  settings: setting,
                );
                case "productdetailscrimpingtools":
                return MaterialPageRoute(
                  builder: (BuildContext context) {
                    return AppBarMain(
                      body: ProductDetailsOfTools(),
                    );
                  },
                  settings: setting,
                );
              case "nopdf":
                return MaterialPageRoute(
                  builder: (BuildContext context) {
                    return AppBarMain(
                      body: Nopdf(),
                    );
                  },
                  settings: setting,
                );
              default:
                return null;
            }
          }
          return null;
        },
      
      ),
    );
  }
}
void navigateToPage(BuildContext context, String route) {
  Navigator.pushNamed(context, route);
}
void navigateToProductDetailsofLugs(
    BuildContext context, int selectedProductIndex,
    {String? productname}) {
  Navigator.pushNamed(context, '/productdetailslugs/$productname');
}

void navigateToProductDetailsOfConnectors(
    BuildContext context, int selectedProductIndex,
    {String? productname}) {
  Navigator.pushNamed(
    context,
    '/productdetailsconnectors/$productname',
  );
}

void navigateToProductDetailsOfGlands(
    BuildContext context, int selectedProductIndex,
    {String? productname}) {
  Navigator.pushNamed(context, '/productdetailsglands/$productname');
}

void navigateToProductDetailsOfAccessories(
    BuildContext context, int selectedProductIndex,
    {String? productname}) {
  Navigator.pushNamed(context, '/productdetailsaccessories/$productname');
}

void noPdfProductPage(BuildContext context, int selectedProductIndex,
    {String? productname}) {
  Navigator.pushNamed(context, '/nopdf/$productname');
}
void navigateToProductDetailsOfTools(BuildContext context, int selectedProductIndex,
    {String? productname}) {
  Navigator.pushNamed(context, '/productdetailscrimpingtools/$productname');
}

void navigateToProductDetailsFromSearch(
  BuildContext context,
  String productname,
  String type,
) {
  String endpoint = "";

  switch (type) {
    case 'lugs':
      endpoint = '/productdetailslugs/$productname';
      break;
    case 'connectors':
      endpoint = '/productdetailsconnectors/$productname';
      break;
    case 'glands':
      endpoint = '/productdetailsglands/$productname';
      break;
    case 'accessories':
      endpoint = '/productdetailsaccessories/$productname';
      break;
    case 'tools':
      endpoint = '/productdetailscrimpingtools/$productname';
      break;
    default:
      return;
  }
  Navigator.pushNamed(context, endpoint);
}
