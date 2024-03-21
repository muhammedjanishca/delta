import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_hex/provider/Refresh.dart';
import 'package:firebase_hex/provider/address_provider.dart';
import 'package:firebase_hex/widgets/bottom_sheet.dart';
import 'package:firebase_hex/responsive/res_cartpage.dart';
import 'package:firebase_hex/widgets/style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../login_and_signing/authentication.dart';
import '../../provider/cart_provider.dart';
import '../../provider/user_input_provider.dart';
import 'quotationPage.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveCart(
      desktopCart: DeskCart(),
      mobileCart: const Mobilecart(),
    );
  }
}

//***************** DESKTOP CART PAGE **************

class DeskCart extends StatefulWidget {
  @override
  State<DeskCart> createState() => _DeskCartState();
}

class _DeskCartState extends State<DeskCart> {
  int addresscount = 0;
  Color textColor = Colors.black;
  int enterCounter = 0;
  int exitCounter = 0;
  double x = 0.0;
  double y = 0.0;
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

  @override
  Widget build(BuildContext context) {
    var userr = Provider.of<AuthenticationHelper>(context).getCurrentUser();
    if (userr != null) {
      Provider.of<AddressProvider>(context)
          .get_current_address(addresscount, context);
    }
//         var user = Provider.of<AddressProvider>(context).isUserDataAvailable(context);
//  if (user != null) {
//       Provider.of<AddressProvider>(context).get_current_address(addresscount, context);
//       addresscount =
//           Provider.of<AddressProvider>(context).selectIndex;
//     }
    final userInputProvider = Provider.of<UserInputProvider>(context);
    final FirebaseAuth auth = FirebaseAuth.instance;
    final cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getCartData();
    var cartItems = cartProvider.fetchedItems;
    double subtotal = cartProvider.getTotalPrice();
    double vatRate = 15.0;
    double vat = cartProvider.calculateVAT(subtotal, vatRate);
    double totalPriceWithVAT =
        cartProvider.getTotalPriceWithVAT(subtotal, vatRate);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 10,
                ),
                SizedBox(
                  height: 700,
                  width: MediaQuery.of(context).size.width / 2,
                  child: Column(
                    children: [
                      userr != null
                          ? Container(
                              height: 30,
                              color: Colors.amber,
                            )
                          : SizedBox(
                              height: 60,
                              child: Row(
                                children: [
                                  TextButton(
                                      onPressed: () {},
                                      child: const Text(
                                        "HOME>>",
                                        style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 54, 98, 98),
                                            fontSize: 17,
                                            fontWeight: FontWeight.w300),
                                      )),
                                  Text(
                                    "CART",
                                    style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: colorProductName),
                                  )
                                ],
                              ),
                            ),
                      Expanded(
                        child: ListView.separated(
                          physics: const ScrollPhysics(),
                          itemCount: cartItems["cartItems"].length,
                          separatorBuilder: (context, index) =>
                              const Divider(color: Colors.grey),
                          itemBuilder: (context, index) {
                            final item =
                                jsonDecode(cartItems["cartItems"][index]);

                            // final item = cartProvider.cartItems[index];
                            return ListTile(
                              title: Row(
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height / 6,
                                    width:
                                        MediaQuery.of(context).size.width / 12,
                                    color: Colors.white,
                                    child: Image.network(
                                      item['imageUrl'],
                                      // width: 10,
                                      // height: 10,
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 30,
                                  ),
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 5,
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${item["productName"]}',
                                          style: GoogleFonts.poppins(),
                                        ),
                                        Gap(5),
                                        item["productName"] ==
                                                item['productCode']
                                            ? const SizedBox()
                                            : Text(
                                                '${item['productCode']} ${item['price'].toStringAsFixed(2)}',
                                                style: GoogleFonts.poppins(
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                        // Text(
                                        //     // toStringAsFixed(2)
                                        //     'Price  :  \SAR ${item['price'].toStringAsFixed(2)}',
                                        //     style: GoogleFonts.poppins(),),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                           Container(
                                            child: Row(children: [
                                               Text(
                                              'Quantity : ${item['quantity']}',
                                              style: GoogleFonts.poppins(),
                                            ),
                                            TextButton(
                                                child: Text("Edit",style:GoogleFonts.poppins(color: Colors.black87),), 
                                                onPressed: () {
                                                  int newQuantity =
                                                      item['quantity'];
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          title: const Text(
                                                              'Edit Quantity'),
                                                          content: TextField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            decoration:
                                                                const InputDecoration(
                                                                    labelText:
                                                                        'Quantity'),
                                                            onChanged: (value) {
                                                              newQuantity = int
                                                                      .tryParse(
                                                                          value) ??
                                                                  newQuantity;
                                                            },
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const Text(
                                                                  'Cancel'),
                                                            ),
                                                            TextButton(
                                                              onPressed: () {
                                                                cartProvider
                                                                    .updateQuantity(
                                                                        index,
                                                                        newQuantity);
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const Text(
                                                                  'Save'),
                                                            ),
                                                          ],
                                                        );
                                                      });
                                                }),
                                            ],),
                                           ),
                                              
                                            IconButton(
                                              icon: const Icon(
                                                Icons.delete_outline_outlined,
                                                color: Colors.black54,
                                              ),
                                              onPressed: () {
                                                cartProvider.removeFromCart(
                                                    index,
                                                    cartItems['cartItems']);
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 500,
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 50,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            // SizedBox(
                            //   height: MediaQuery.of(context).size.height / 6,
                            // ),
                            Text(
                              'Summary\n',
                              style: GoogleFonts.roboto(
                                  fontSize: 23, fontWeight: FontWeight.w500),
                            ),
                            // SizedBox(height: 47),
                            ListTile(
                              title: Text(
                                'Subtotal',
                                style: GoogleFonts.poppins(
                                    fontSize: 18, fontWeight: FontWeight.w400),
                              ),
                              trailing: Text(
                                '\SAR ${cartProvider.getTotalPrice().toStringAsFixed(2)}',
                                style: GoogleFonts.poppins(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                'VAT (${vatRate}%)',
                                style: GoogleFonts.poppins(fontSize: 14),
                              ),
                              trailing: Text(
                                '\SAR ${vat.toStringAsFixed(2)}',
                                style: GoogleFonts.poppins(),
                              ),
                            ),
                            const Divider(
                              height:
                                  1, // Adjust the height of the divider as needed
                              color: Color.fromARGB(255, 147, 146,
                                  146), // Choose the color of the divider
                              thickness:
                                  1, // Specify the thickness of the divider line
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ListTile(
                              title: Text(
                                'Total Price (with VAT)',
                                style: GoogleFonts.poppins(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              trailing: Text(
                                '\SAR ${totalPriceWithVAT.toStringAsFixed(2)}',
                                style: GoogleFonts.poppins(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Divider(
                              height:
                                  1, // Adjust the height of the divider as needed
                              color: Color.fromARGB(255, 147, 146,
                                  146), // Choose the color of the divider
                              thickness:
                                  1, // Specify the thickness of the divider line
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            MouseRegion(
                              onEnter: incrementEnter,
                              onHover: updateLocation,
                              onExit: incrementExit,
                              child: ElevatedButton(
                                onPressed: () async {
                                  context
                                      .read<AddressProvider>()
                                      .isUserDataAvailable(context);
                                },
                                child: Text(
                                  'GENERATE QUATATION',
                                  style:
                                      GoogleFonts.roboto(color: Colors.white),
                                ),
                                style: ButtonStyle(
                                  shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15))),
                                  backgroundColor:
                                      MaterialStateProperty.all(textColor),
                                  minimumSize: MaterialStateProperty.all(
                                      const Size(150, 55)),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 22,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
                color: const Color.fromARGB(255, 255, 255, 255),
                width: double.infinity,
                // height: MediaQuery.of(context).size.height / 1.5,
                child: MediaQuery.of(context).size.width >= 700
                    ? const deskBottomSheett()
                    : const mobiledeskBottomSheett())
          ],
        ),
      ),
    );
  }
}

//************************* Mobile ********************

class Mobilecart extends StatefulWidget {
  const Mobilecart({super.key});

  @override
  State<Mobilecart> createState() => _MobilecartState();
}

class _MobilecartState extends State<Mobilecart> {
  @override
  Widget build(BuildContext context) {
    final userInputProvider = Provider.of<UserInputProvider>(context);
    final FirebaseAuth auth = FirebaseAuth.instance;
    final cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getCartData();
    var cartItems = cartProvider.fetchedItems;
    double subtotal = cartProvider.getTotalPrice();
    double vatRate = 15.0;
    double vat = cartProvider.calculateVAT(subtotal, vatRate);
    double totalPriceWithVAT =
        cartProvider.getTotalPriceWithVAT(subtotal, vatRate);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 650,
                padding:
                    const EdgeInsets.only(left: 16), // Add left padding here
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                      child: Row(
                        children: [
                          TextButton(
                              onPressed: () {},
                              child: const Text(
                                "HOME>>",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 54, 98, 98),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w300),
                              )),
                          Text(
                            "CART",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(249, 156, 6, 1.0),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        physics: const ScrollPhysics(),
                        itemCount: cartItems["cartItems"].length,
                        separatorBuilder: (context, index) =>
                            const Divider(color: Colors.grey),
                        itemBuilder: (context, index) {
                          final item =
                              jsonDecode(cartItems["cartItems"][index]);

                          // final item = cartProvider.cartItems[index];
                          return GestureDetector(
                            onTap: () {
                              // if(index)
                              // Navigator.of(context).push(mater)
                            },
                            child: ListTile(
                              title: FittedBox(
                                child: Row(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              8,
                                      width:
                                          MediaQuery.of(context).size.width / 5,
                                      color: Colors.white,
                                      child: Image.network(
                                        item['imageUrl'],
                                        fit: BoxFit.scaleDown,
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          30,
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              5.5,
                                      width: MediaQuery.of(context).size.width /
                                          1.5,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${item["productName"]}',
                                            style: GoogleFonts.poppins(),
                                          ),
                                          item["productName"] ==
                                                  item['productCode']
                                              ? const SizedBox()
                                              : Text(
                                                '${item['productCode']} ${item['price'].toStringAsFixed(2)}',
                                                style: GoogleFonts.poppins(
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                          // Text(
                                          //   // toStringAsFixed(2)
                                          //   'Price: \SAR ${item['price'].toStringAsFixed(2)}',
                                          //   style: GoogleFonts.poppins(),
                                          // ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                child: Row(
                                                  children: [
                                                     Text(
                                                'Quantity : ${item['quantity']}',
                                                style: GoogleFonts.poppins(),
                                              ),
                                              TextButton(
                                                  child: Text("Edit",style:GoogleFonts.poppins(color: Colors.black87),), 
                                                  onPressed: () {
                                                    int newQuantity =
                                                        item['quantity'];
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            title: const Text(
                                                                'Edit Quantity'),
                                                            content: TextField(
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              decoration:
                                                                  const InputDecoration(
                                                                      labelText:
                                                                          'Quantity'),
                                                              onChanged:
                                                                  (value) {
                                                                newQuantity = int
                                                                        .tryParse(
                                                                            value) ??
                                                                    newQuantity;
                                                              },
                                                            ),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: const Text(
                                                                    'Cancel'),
                                                              ),
                                                              TextButton(
                                                                onPressed: () {
                                                                  cartProvider
                                                                      .updateQuantity(
                                                                          index,
                                                                          newQuantity);
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child:
                                                                    const Text(
                                                                        'Save'),
                                                              ),
                                                            ],
                                                          );
                                                        });
                                                  }),
                                                  ],
                                                ),
                                              ),
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.delete_outline_outlined,
                                                  color: Colors.black54,
                                                ),
                                                onPressed: () {
                                                  cartProvider.removeFromCart(
                                                      index,
                                                      cartItems['cartItems']);
                                                },
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // flex: 2,
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          // Divider(),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 20,
                          ),
                          Text(
                            'Summary\n',
                            style: GoogleFonts.roboto(
                                fontSize: 23, fontWeight: FontWeight.w500),
                          ),
                          // SizedBox(height: 47),
                          ListTile(
                            title: Text(
                              'Subtotal',
                              style: GoogleFonts.poppins(
                                  fontSize: 15, fontWeight: FontWeight.w400),
                            ),
                            trailing: Text(
                              '\SAR ${cartProvider.getTotalPrice().toStringAsFixed(2)}',
                              style: GoogleFonts.poppins(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              'VAT (${vatRate}%)',
                              style: GoogleFonts.poppins(fontSize: 14),
                            ),
                            trailing: Text(
                              '\SAR ${vat.toStringAsFixed(2)}',
                              style: GoogleFonts.poppins(fontSize: 14),
                            ),
                          ),
                          const Divider(
                            height:
                                1, // Adjust the height of the divider as needed
                            color: Color.fromARGB(255, 147, 146,
                                146), // Choose the color of the divider
                            thickness:
                                1, // Specify the thickness of the divider line
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ListTile(
                            title: Text(
                              'Total Price (with VAT)',
                              style: GoogleFonts.poppins(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                            trailing: Text(
                              '\SAR ${totalPriceWithVAT.toStringAsFixed(2)}',
                              style: GoogleFonts.poppins(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Divider(
                            height:
                                1, // Adjust the height of the divider as needed
                            color: Color.fromARGB(255, 147, 146,
                                146), // Choose the color of the divider
                            thickness:
                                1, // Specify the thickness of the divider line
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 22,
                    ),
                  ],
                ),
              ),

              Container(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  // height: MediaQuery.of(context).size.height / 1,
                  height: 980,
                  child: MediaQuery.of(context).size.width >= 700
                      ? const deskBottomSheett()
                      : const mobiledeskBottomSheett()),
              //  Footer(child: Container(height: 50,
              //                color: Colors.pink,)),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    // cartProvider.getCartData();
    var cartItems = cartProvider.fetchedItems;
    double subtotal = cartProvider.getTotalPrice();
    double vatRate = 15.0;
    double vat = cartProvider.calculateVAT(subtotal, vatRate);
    double totalPriceWithVAT =
        cartProvider.getTotalPriceWithVAT(subtotal, vatRate);
    return BottomAppBar(
      child: Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                color: Color.fromRGBO(249, 156, 6, 1.0),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(
                      20), // Adjust the top-left radius as needed
                  topRight: Radius.circular(
                      20), // Adjust the top-right radius as needed
                ),
              ),
              child: TextButton(
                onPressed: () async {
                  context.read<AddressProvider>().isUserDataAvailable(context);
                },
                child: const Text(
                  'GENERATE QUOTATION',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MobileBottomNavigationBaru extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    // cartProvider.getCartData();
    var cartItems = cartProvider.fetchedItems;
    double subtotal = cartProvider.getTotalPrice();
    double vatRate = 15.0;
    double vat = cartProvider.calculateVAT(subtotal, vatRate);
    double totalPriceWithVAT =
        cartProvider.getTotalPriceWithVAT(subtotal, vatRate);
    return BottomAppBar(
      child: Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                color: Color.fromRGBO(249, 156, 6, 1.0),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(
                      20), // Adjust the top-left radius as needed
                  topRight: Radius.circular(
                      20), // Adjust the top-right radius as needed
                ),
              ),
              child: TextButton(
                onPressed: () {
                  // Retrieve the selected address
                  final addressProvider =
                      Provider.of<AddressProvider>(context, listen: false);
                  var selectedAddress = jsonDecode(addressProvider
                      .arrayFromFirestore[addressProvider.selectIndex]);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => QuotationPage(
                                totalPrice: cartProvider.getTotalPrice(),
                                cartItems: cartItems["cartItems"],
                                totalPriceWithVAT: cartProvider
                                    .getTotalPriceWithVAT(subtotal, vatRate),
                                vat: cartProvider.calculateVAT(
                                    subtotal, vatRate),
                                selectedAddress: selectedAddress,
                              )));
                },
                child: const Text(
                  'GENERATE QUOTATION',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
