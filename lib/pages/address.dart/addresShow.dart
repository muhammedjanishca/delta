import 'dart:convert';

import 'package:firebase_hex/pages/address.dart/sideSheetAddress.dart';
import 'package:firebase_hex/pages/another_pages/quotationPage.dart';
import 'package:firebase_hex/provider/address_provider.dart';
import 'package:firebase_hex/provider/cart_provider.dart';
import 'package:firebase_hex/responsive/res_address_show.dart';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:side_sheet/side_sheet.dart';

class AddressShowPage extends StatelessWidget {
  const AddressShowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return resAddressShow(
        mobileaddressShow: AddressShowMob(), deskAddressShow: addressshow());
  }
}

class addressshow extends StatelessWidget {
  addressshow({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getAddressData();
    var cartItems = cartProvider.fetchedItems;
    double subtotal = cartProvider.getTotalPrice();
    double vatRate = 15.0;
    double vat = cartProvider.calculateVAT(subtotal, vatRate);
    double totalPriceWithVAT =
        cartProvider.getTotalPriceWithVAT(subtotal, vatRate);
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leadingWidth: 48,
          title: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/');
                },
                child: Text(
                  "DELTA",
                  style: GoogleFonts.oswald(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 45,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Text(
                "\n NATIONAL",
                style: GoogleFonts.oswald(
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // color: Color.fromARGB(255, 157, 34, 118),

                    SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: Column(children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Gap(150),
                                    Icon(Icons.add),
                                    TextButton(
                                        onPressed: () => SideSheet.right(
                                            body: TextAddress(),
                                            //  TextAddress(),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.3,
                                            context: context),
                                        child: Text(
                                          "ADD ADDRESS",
                                          style: TextStyle(color: Colors.black),
                                        ))
                                  ],
                                ),
                                ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: cartItems["address"].length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      var addressData = jsonDecode(
                                          cartItems["address"][index]);
                                      bool isNotFirstItem = index != 0;
                                      if (isNotFirstItem) {
                                        return GestureDetector(
                                            onTap: () {
                                              context
                                                  .read<AddressProvider>()
                                                  .UpdateSelectindex(
                                                      context, index);
                                            },
                                            child: ListTile(
                                                selectedTileColor: Colors.black,
                                                title: Container(
                                                  height: 150,
                                                  color: const Color.fromARGB(
                                                      255, 136, 191, 200),
                                                  child: AddressData(addressData),
                                                ),
                                                trailing: IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(Icons.delete),
                                                  //   trailing: isNotFirstItem
                                                  //   ? IconButton( icon:  Icon(Icons.delete),
                                                  //   onPressed: (){

                                                  //   },

                                                  // )
                                                  // :null
                                                )));
                                      }
                                      return GestureDetector(
                                        onTap: () {
                                          context
                                              .read<AddressProvider>()
                                              .UpdateSelectindex(
                                                  context, index);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 15, left: 15),
                                          child: Container(
                                            height: 150,
                                            color: Color.fromARGB(
                                                255, 136, 191, 200),
                                            child: _buildAddressListItem(
                                                addressData, index),
                                                
                                          ),
                                        ),
                                      );
                                    })
                              ])),
                        ],
                      ),
                    ),

                    Gap(25),
                    Column(
                      children: [
                        Container(
                          width: 0.5,
                          height: 130,
                          color: Color.fromARGB(255, 122, 122, 122),
                        ),
                        Container(
                          width: 0.5,
                          height: 130,
                          color: const Color.fromARGB(255, 122, 122, 122),
                        ),
                      ],
                    ),
                    Container(
                      // color: Colors.amber,
                      width: _width / 2.5,
                      height: _height / 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(onPressed: (){
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
                          }, child: Text("VIew QUAt"))
                        ],
                      ),
                    )
                  ],
                ),
              ],
            )));
  }
}

Widget _buildAddressListItem(Map<String, dynamic> addressData, int index) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: AddressData(addressData),
      ),
      IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {},
      ),
    ],
  );
}

String _selectedLocation = 'Please choose a location';
AddressData(data) {
  final item = data;
  return Column(
    children: [
      Text(
        "${item['COMPANY NAME']}",
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18
            // You can also specify other text styles here, e.g., fontSize, color, etc.
            ),
      ),
      Text(
        "${item['Contact Number']}",
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18
            // You can also specify other text styles here, e.g., fontSize, color, etc.
            ),
      ),
      Text(
        "${item['City']}",
        // "${item['vat']} ,  " "${item['state']}",
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18
            // You can also specify other text styles here, e.g., fontSize, color, etc.
            ),
      ),
      Text(
        "${item['Street Address']} ,  " "${item['Street Address line 2']}",
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18
            // You can also specify other text styles here, e.g., fontSize, color, etc.
            ),
      ),
    ],
  );
}

class AddressShowMob extends StatelessWidget {
  AddressShowMob({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getAddressData();
    var cartItems = cartProvider.fetchedItems;
    // var removAdd = cartProvider.removeAddress();
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leadingWidth: 48,
          title: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/');
                },
                child: Text(
                  "DELTA",
                  style: GoogleFonts.oswald(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 45,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Text(
                "\n NATIONAL",
                style: GoogleFonts.oswald(
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // color: Color.fromARGB(255, 157, 34, 118),

                    SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Gap(150),
                                      Icon(Icons.add),
                                      TextButton(
                                          onPressed: () => SideSheet.right(
                                              body: TextAddress(),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3,
                                              context: context),
                                          child: Text(
                                            "ADD ADDRESS",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ))
                                    ],
                                  ),
                                  Container(
                                    color: Color.fromARGB(255, 174, 210, 220),
                                    child: Column(
                                      children: [
                                        Column(
                                          children: [
                                            ListView.builder(
                                              scrollDirection: Axis.vertical,
                                              shrinkWrap: true,
                                              itemCount:
                                                  cartItems["address"].length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                // Check if it's not the first item
                                                bool isNotFirstItem =
                                                    index != 0;

                                                // If it's not the first item, add a Divider
                                                if (isNotFirstItem) {
                                                  return Column(
                                                    children: [
                                                      Container(
                                                        width: double.infinity,
                                                        height: 20,
                                                        color: Colors.white,
                                                      ),
                                                      AddressData(jsonDecode(
                                                          cartItems["address"]
                                                              [index])),
                                                    ],
                                                  );
                                                }
                                                // If it's the first item, don't add a Divider
                                                return AddressData(jsonDecode(
                                                    cartItems["address"]
                                                        [index]));
                                              },
                                            ),
                                            // Add your button here
                                            ElevatedButton(
                                              onPressed: ()
                                                  //  async
                                                  {
                                                // await removAdd;
                                              },
                                              child: Text(
                                                'Deliver to this Address',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Color.fromARGB(
                                                            255, 97, 128, 190)),
                                                minimumSize:
                                                    MaterialStateProperty.all(
                                                        Size(200, 40)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )),
                        ],
                      ),
                    ),

                    // Gap(25),
                    // Column(
                    //   children: [
                    //     Container(
                    //       width: 0.5,
                    //       height: 130,
                    //       color: Color.fromARGB(255, 122, 122, 122),
                    //     ),
                    //     Container(
                    //       width: 0.5,
                    //       height: 130,
                    //       color: const Color.fromARGB(255, 122, 122, 122),
                    //     ),
                    //   ],
                    // ),
                    // Container(
                    //   // color: Colors.amber,
                    //   width: _width / 2.5,
                    //   height: _height / 2,
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [],
                    //   ),
                    // )
                  ],
                ),
              ],
            )));
  }
}
