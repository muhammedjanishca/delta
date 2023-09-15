import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_hex/login_and_signing/signup_page.dart';
import 'package:firebase_hex/login_and_signing/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart_provider.dart';
import '../provider/user_input_provider.dart';
import '../quotationPage.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final userInputProvider = Provider.of<UserInputProvider>(context);
    final FirebaseAuth auth = FirebaseAuth.instance;

    final cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getCartData();
    var cartItems = cartProvider.fetchedItems;
 

    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.only(left: 16), // Add left padding here
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 60),
                  Expanded(
                    child: ListView.separated(
                      itemCount: cartItems["cartItems"].length,
                      separatorBuilder: (context, index) =>
                          Divider(height: 88, color: Colors.grey),
                      itemBuilder: (context, index) {
                        final item = jsonDecode(cartItems["cartItems"][index]);

                        // final item = cartProvider.cartItems[index];
                        return ListTile(
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.network(
                                item['imageUrl'],
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(width: 10, height: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '\$${item["productName"]}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '\$${item['productCode']}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                        // toStringAsFixed(2)
                                        'Price: \$${item['price'].toStringAsFixed(2)}'),
                                    Row(
                                      children: [
                                        Text('Quantity:${item['quantity']}'),
                                        Row(
                                          children: [
                                            IconButton(
                                                icon: Icon(Icons.edit),
                                                onPressed: () {
                                                  int newQuantity =
                                                      item['quantity'];
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          title: Text(
                                                              'Edit Quantity'),
                                                          content: TextField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            decoration:
                                                                InputDecoration(
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
                                                              child: Text(
                                                                  'Cancel'),
                                                            ),
                                                            TextButton(
                                                              onPressed: () {
                                                                cartProvider.updateQuantity(
                                                                    item[
                                                                        'productCode'],
                                                                    newQuantity);
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child:
                                                                  Text('Save'),
                                                            ),
                                                          ],
                                                        );
                                                      });
                                                })
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete_outline_rounded),
                                onPressed: () async {
                                  print(cartItems['cartItems'][index]);
                                  cartProvider.removeFromCart(
                                      index, cartItems['cartItems']);
                                  // cartProvider.removeFromCart(item);
                                },
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
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Color.fromARGB(255, 249, 249, 249),
              padding: EdgeInsets.only(
                left: 10,
                right: 200,
                top: 100,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Summary',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  // SizedBox(height: 47),
                  ListTile(
                    title: Text('Subtotal'),
                    trailing: Text(
                        'Total Price: \$${cartProvider.getTotalPrice().toStringAsFixed(2)}'),
                  ),

                  // SizedBox(height: 45),
                  ListTile(
                    title: Text('VAT'),
                    // trailing: Text('\$ ${totalPrice.toStringAsFixed(2)}'),
                  ),

                  // SizedBox(
                  //   height: 20,
                  // ),
                  Divider(
                    height: 1, // Adjust the height of the divider as needed
                    color: const Color.fromARGB(
                        255, 147, 146, 146), // Choose the color of the divider
                    thickness: 1, // Specify the thickness of the divider line
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    title: Text('Total\n'),
                    trailing: Text(
                      'Total Price: \$${cartProvider.getTotalPrice().toStringAsFixed(2)}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Divider(
                    height: 1, // Adjust the height of the divider as needed
                    color: const Color.fromARGB(
                        255, 147, 146, 146), // Choose the color of the divider
                    thickness: 1, // Specify the thickness of the divider line
                  ),

                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => QuotationPage(    totalPrice: cartProvider.getTotalPrice(), cartItems:cartItems["cartItems"]                             )));
                        },
                        child:  Text(
                          'GANERATE QUATATION',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black),
                          minimumSize: MaterialStateProperty.all(Size(150, 50)),
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Navigator.pushNamed(
                          //     context, '/cart');
                        },
                        child: Text(
                          'CHECKOUT',
                          style: TextStyle(color: Colors.black),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          minimumSize: MaterialStateProperty.all(Size(150, 50)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
