import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_hex/provider/address_provider.dart';
import 'package:firebase_hex/widgets/bottom_sheet.dart';
import 'package:firebase_hex/responsive/res_cartpage.dart';
import 'package:firebase_hex/widgets/style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
                      SizedBox(
                        height: 60,
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
                                  color: Deltacolor),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          physics: const ScrollPhysics(),
                          itemCount: cartItems["cartItems"].length,
                          separatorBuilder: (context, index) =>
                              const Divider(height: 88, color: Colors.grey),
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
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        item["productName"] ==
                                                item['productCode']
                                            ? const SizedBox()
                                            : Text(
                                                '${item['productCode']}',
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                        Text(
                                            // toStringAsFixed(2)
                                            'Price: \$${item['price'].toStringAsFixed(2)}'),
                                        Row(
                                          children: [
                                            Text(
                                                'Quantity:${item['quantity']}'),
                                            IconButton(
                                                icon: const Icon(
                                                  Icons.edit,
                                                  color: Colors.black,
                                                ),
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
                                            // Divider(),
                                            // Text("|"),

                                            IconButton(
                                              icon: const Icon(
                                                Icons.delete_rounded,
                                                color: Colors.black,
                                              ),
                                              onPressed: () async {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: const Text(
                                                          'Confirm Removal'),
                                                      content: const Text(
                                                          'Are you sure you want to remove this product?'),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          child:
                                                              const Text('No'),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop(); // Close the dialog
                                                          },
                                                        ),
                                                        TextButton(
                                                          child:
                                                              const Text('Yes'),
                                                          onPressed: () {
                                                            cartProvider
                                                                .removeFromCart(
                                                                    index,
                                                                    cartItems[
                                                                        'cartItems']);
                                                            Navigator.of(
                                                                    context)
                                                                .pop(); // Close the dialog
                                                          },
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
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
                            const Text(
                              'Summary\n',
                              style: TextStyle(
                                  fontSize: 23, fontWeight: FontWeight.w500),
                            ),
                            // SizedBox(height: 47),
                            ListTile(
                              title: const Text(
                                'Subtotal',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w400),
                              ),
                              trailing: Text(
                                '\$${cartProvider.getTotalPrice().toStringAsFixed(2)}',
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ),
                            ListTile(
                              title: Text('VAT (${vatRate}%)'),
                              trailing: Text('\$${vat.toStringAsFixed(2)}'),
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
                              title: const Text(
                                'Total Price (with VAT)',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              trailing: Text(
                                '\$${totalPriceWithVAT.toStringAsFixed(2)}',
                                style: const TextStyle(
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
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => QuotationPage(
                                              totalPrice:
                                                  cartProvider.getTotalPrice(),
                                              cartItems: cartItems["cartItems"],
                                              totalPriceWithVAT: cartProvider
                                                  .getTotalPriceWithVAT(
                                                      subtotal, vatRate),
                                              vat: cartProvider.calculateVAT(
                                                  subtotal, vatRate),
                                            )));
                              },
                              child: const Text(
                                'GANERATE QUATATION',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ButtonStyle(
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15))),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black),
                                minimumSize: MaterialStateProperty.all(
                                    const Size(150, 55)),
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
                height: MediaQuery.of(context).size.height / 1.5,
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
                                color: Deltacolor),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        itemCount: cartItems["cartItems"].length,
                        separatorBuilder: (context, index) =>
                            const Divider(height: 88, color: Colors.grey),
                        itemBuilder: (context, index) {
                          final item =
                              jsonDecode(cartItems["cartItems"][index]);

                          // final item = cartProvider.cartItems[index];
                          return GestureDetector(
                            onTap: () {
                              // if(index)
                              //Navigator.of(context).push(mater)
                            },
                            child: ListTile(
                              title: Row(
                                children: [
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height / 8,
                                    width:
                                        MediaQuery.of(context).size.width / 5,
                                    color: Colors.white,
                                    child: Image.network(
                                      item['imageUrl'],
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 30,
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        5.5,
                                    width:
                                        MediaQuery.of(context).size.width / 1.5,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${item["productName"]}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        item["productName"] ==
                                                item['productCode']
                                            ? const SizedBox()
                                            : Text(
                                                '${item['productCode']}',
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                        Text(
                                            // toStringAsFixed(2)
                                            'Price: \$${item['price'].toStringAsFixed(2)}'),
                                        Row(
                                          children: [
                                            Text(
                                                'Quantity:${item['quantity']}'),
                                            IconButton(
                                                icon: const Icon(
                                                  Icons.edit,
                                                  color: Colors.black,
                                                ),
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
                                            // Divider(),
                                            // Text("|"),

                                            IconButton(
                                              icon: const Icon(
                                                Icons.delete_rounded,
                                                color: Colors.black,
                                              ),
                                              onPressed: () async {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: const Text(
                                                          'Confirm Removal'),
                                                      content: const Text(
                                                          'Are you sure you want to remove this product?'),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          child:
                                                              const Text('No'),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop(); // Close the dialog
                                                          },
                                                        ),
                                                        TextButton(
                                                          child:
                                                              const Text('Yes'),
                                                          onPressed: () {
                                                            cartProvider
                                                                .removeFromCart(
                                                                    index,
                                                                    cartItems[
                                                                        'cartItems']);
                                                            Navigator.of(
                                                                    context)
                                                                .pop(); // Close the dialog
                                                          },
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
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
                          const Text(
                            'Summary\n',
                            style: TextStyle(
                                fontSize: 23, fontWeight: FontWeight.w500),
                          ),
                          // SizedBox(height: 47),
                          ListTile(
                            title: const Text(
                              'Subtotal',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                            trailing: Text(
                              '\$${cartProvider.getTotalPrice().toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ),
                          ListTile(
                            title: Text('VAT (${vatRate}%)'),
                            trailing: Text('\$${vat.toStringAsFixed(2)}'),
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
                            title: const Text(
                              'Total Price (with VAT)',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            trailing: Text(
                              '\$${totalPriceWithVAT.toStringAsFixed(2)}',
                              style: const TextStyle(
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
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                color: Deltacolor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(
                      20), // Adjust the top-left radius as needed
                  topRight: Radius.circular(
                      20), // Adjust the top-right radius as needed
                ),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuotationPage(
                        totalPrice: cartProvider.getTotalPrice(),
                        cartItems: cartItems["cartItems"],
                        totalPriceWithVAT: cartProvider.getTotalPriceWithVAT(
                            subtotal, vatRate),
                        vat: cartProvider.calculateVAT(subtotal, vatRate),
                      ),
                    ),
                  );
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

    return BottomAppBar(
      child: Container(
        color: Colors.black,
        child: Row(
          children: [
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                color: Deltacolor,
              ),
              // child: TextButton(
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => QuotationPage(
              //           totalPrice: cartProvider.getTotalPrice(),
              //           cartItems: cartItems["cartItems"],
              //         ),
              //       ),
              //     );
              //   },
              //   child: Text(
              //     'GENERATE QUOTATION',
              //     style: TextStyle(color: Colors.white),
              //   ),
              // ),
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width / 2,
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              // child: TextButton(
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => QuotationPage(
              //           totalPrice: cartProvider.getTotalPrice(),
              //           cartItems: cartItems["cartItems"],
              //         ),
              //       ),
              //     );
              //   },
              //   child: Text(
              //     'GENERATE QUOTATION',
              //     style: TextStyle(color: Colors.white),
              //   ),
              // ),
            )
          ],
        ),
      ),
    );
  }
}
