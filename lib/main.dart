import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_hex/login_and_signing/authentication.dart';
import 'package:firebase_hex/login_and_signing/signup_page.dart';
import 'package:firebase_hex/login_and_signing/welcome_page.dart';
import 'package:firebase_hex/pages/AccessoriesPage.dart';
import 'package:firebase_hex/pages/abbbar_page.dart';
import 'package:firebase_hex/pages/cart.dart';
import 'package:firebase_hex/pages/connecters.dart';
import 'package:firebase_hex/pages/crimping.dart';
import 'package:firebase_hex/pages/gland.dart';
import 'package:firebase_hex/pages/landing_page.dart';
import 'package:firebase_hex/pages/lugs.dart';
import 'package:firebase_hex/product_details/accessories_product.dart';
import 'package:firebase_hex/product_details/connecters_productd.dart';
import 'package:firebase_hex/product_details/crimpingtool_details.dart';
import 'package:firebase_hex/product_details/gland_productdetails.dart';
import 'package:firebase_hex/product_details/lugs_productdetails.dart';
import 'package:firebase_hex/provider/cart_provider.dart';
import 'package:firebase_hex/provider/data_provider.dart';
import 'package:firebase_hex/provider/thumbnail.dart';
import 'package:firebase_hex/provider/user_input_provider.dart';
import 'package:flutter/material.dart';
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

  runApp( MyApp());
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
    print("++++++++++++++++++++++++++++++");
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthenticationHelper()),
        ChangeNotifierProvider(create: (context) => DataProvider()),
        ChangeNotifierProvider(
            create: (context) => SelectedThumbnailProvider()),
            ChangeNotifierProvider(
            create: (context) => SelectedCodeProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(
          create: (context) => UserInputProvider(),
        )
      ],
      child: MaterialApp(
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
                    child: CircularProgressIndicator(
                      color: Colors.greenAccent,
                    )),
              ));
          if (widget is Scaffold || widget is Navigator) {
            error = Scaffold(body: Center(child: error));
          }
          ErrorWidget.builder = (errorDetails) => error;
          if (widget != null) return widget;
          throw ('widget is null');
        },
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) =>
           AppBarMain(
                body: LandinPage()
              ),
          '/productdetails': (context) => AppBarMain(
                body: ProductDetailsoflugs(),
              ),
          '/cart': (context) => AppBarMain(
                body: CartPage(),
              ),
          '/lugs': (context) => AppBarMain(
                body: LugsPage(),
              ),
          '/glands': (context) => AppBarMain(
                body: GlandPage(),
              ),
               '/signup/signin': (context) =>SignUpPage(),
          '/productdetailsofconnectors': (context) => AppBarMain(
                body: ProductDetailsOfConnectors(),
              ),
          '/productdetailsofglands': (context) => AppBarMain(
                body: ProductDetailsOfGlands(),
              ),
          '/productdetailsofaccessories': (context) => AppBarMain(
                body: ProductDetailsOfAccessories(),
              ),
          '/productdetailsofcrimpingtools': (context) => AppBarMain(
                body: ProductDetailsOfCrimpingTool(),
              ),
          '/Accssories': (context) => AppBarMain(
                body: AccessoriesPage(),
              ),
          '/Connecters': (context) => AppBarMain(body: ConnectersPage()),
          '/CrimpingTools': (context) => AppBarMain(
                body: CrimpingToolPage(),
              ),
              // '/sighn':(context) => SignUpPage()
        },
        initialRoute: '/',
      ),
    );
  }
}

void navigateToProductDetailsofLugs(BuildContext context, int selectedProductIndex) {
  Navigator.of(context)
      .pushNamed('/productdetails', arguments: selectedProductIndex);
}


void navigateToProductDetailsOfConnectors(
    BuildContext context, int selectedProductIndex) {
  Navigator.of(context).pushNamed('/productdetailsofconnectors',
      arguments: selectedProductIndex);
}

void navigateToProductDetailsOfGlands(
    BuildContext context, int selectedProductIndex) {
  Navigator.of(context)
      .pushNamed('/productdetailsofglands', arguments: selectedProductIndex);
}

void navigateToProductDetailsOfAccessories(
    BuildContext context, int selectedProductIndex) {
  Navigator.of(context).pushNamed('/productdetailsofaccessories',
      arguments: selectedProductIndex);
}

void navigateToProductDetailsOfCrimpinTools(
    BuildContext context, int selectedProductIndex) {
  Navigator.of(context).pushNamed('/productdetailsofcrimpingtools',
      arguments: selectedProductIndex);
}