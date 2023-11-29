import 'dart:convert';
import 'package:firebase_hex/pages/address.dart/sideSheetAddress.dart';
import 'package:firebase_hex/pages/another_pages/IRSH.dart';
import 'package:firebase_hex/pages/another_pages/cart.dart';
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
    return ResAddressShow(
        mobileaddressShow: AddressShowMob(), deskAddressShow: AddressShow());
  }
}

enum SingingCharacter { option1, option2 }

class AddressShow extends StatelessWidget {
  AddressShow({super.key});

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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.white,
      appBar:appbar(context, Colors.white),
        body: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                                    // SizedBox(
                                    //   child:  isNotFirstItem =Index !=0,
                                    // ),
                                    // const Gap(150),
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
                                    var addressData =
                                        jsonDecode(cartItems["address"][index]);
                                    bool isSelected = context
                                            .watch<AddressProvider>()
                                            .selectIndex ==
                                        index;

                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          context
                                              .read<AddressProvider>()
                                              .UpdateSelectindex(
                                                  context, index);
                                        },
                                        child: Container(
                                          color: isSelected
                                              ? Color.fromARGB(255, 239, 234,
                                                  90) // Set the color for selected state
                                              : const Color.fromARGB(
                                                  255,
                                                  136,
                                                  191,
                                                  200), // Set the color for unselected state
                                          child: ListTile(
                                            selectedTileColor: Colors.black,
                                            title: AddressData(addressData),
                                            trailing: IconButton(
                                              icon: Icon(Icons.close),
                                              onPressed: () {
                                                if (index != 0) {
                                                         context
                                                      .read<AddressProvider>()
                                                      .deleteAddress(index);
                                                } else {
                                                      print('Cannot delete the address with index 0.');
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                )
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
                    SizedBox(
                      width: width / 2.5,
                      height: height / 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                                      fontSize: 23,
                                      fontWeight: FontWeight.w500),
                                ),
                                // SizedBox(height: 47),
                                ListTile(
                                  title: const Text(
                                    'Subtotal',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  trailing: Text(
                                    '\SAR${cartProvider.getTotalPrice().toStringAsFixed(2)}',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                ListTile(
                                  title: Text('VAT (${vatRate}%)'),
                                  trailing: Text('\SAR${vat.toStringAsFixed(2)}'),
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
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  trailing: Text(
                                    '\SAR${totalPriceWithVAT.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
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
                                                  totalPrice: cartProvider
                                                      .getTotalPrice(),
                                                  cartItems:
                                                      cartItems["cartItems"],
                                                  totalPriceWithVAT:
                                                      cartProvider
                                                          .getTotalPriceWithVAT(
                                                              subtotal,
                                                              vatRate),
                                                  vat:
                                                      cartProvider.calculateVAT(
                                                          subtotal, vatRate),
                                                )));
                                  },
                                  child: const Text(
                                    'GENERATE QUATATION',
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
        "${item['Company Name']}",
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
        "${item['Street Address']}",
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18
            // You can also specify other text styles here, e.g., fontSize, color, etc.
            ),
      ),
      Text(
        "${item['Street Address line 2']}",
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18
            // You can also specify other text styles here, e.g., fontSize, color, etc.
            ),
      ),
      Text(
        "${item['Location']}",
        // "${item['vat']} ,  " "${item['state']}",
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
    double subtotal = cartProvider.getTotalPrice();
    double vatRate = 15.0;
    double vat = cartProvider.calculateVAT(subtotal, vatRate);
    double totalPriceWithVAT =
        cartProvider.getTotalPriceWithVAT(subtotal, vatRate);
    // var removAdd = cartProvider.removeAddress();
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar:appbar(context, Colors.white),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // SizedBox(
                    //   child:  isNotFirstItem =Index !=0,
                    // ),
                    // const Gap(150),
                    Icon(Icons.add),
                    TextButton(
                        onPressed: () => SideSheet.right(
                            body: TextAddress(),
                            //  TextAddress(),
                            width: MediaQuery.of(context).size.width * 0.6,
                            context: context),
                        child: Text(
                          "ADD ADDRESS  ",
                          style: TextStyle(color: Colors.black),
                        ))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: cartItems["address"].length,
                    itemBuilder: (BuildContext context, int index) {
                      var addressData = jsonDecode(cartItems["address"][index]);
                      bool isSelected =
                          context.watch<AddressProvider>().selectIndex == index;

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: GestureDetector(
                          onTap: () {
                            context
                                .read<AddressProvider>()
                                .UpdateSelectindex(context, index);
                          },
                          child: Container(
                            color: isSelected
                                ? Color.fromARGB(255, 184, 230,
                                    86) // Set the color for selected state
                                : const Color.fromARGB(255, 136, 191,
                                    200), // Set the color for unselected state
                            // child: ListTile(
                            //   selectedTileColor: Colors.black,
                            //   title: AddressData(addressData),
                            //   trailing: IconButton(
                            //     icon: Icon(Icons.close),
                            //     onPressed: () {
                            //       // Delete the corresponding list tile
                            //       context
                            //           .read<AddressProvider>()
                            //           .deleteAddress(index);
                            //     },
                            //   ),
                            // ),
                             child: ListTile(
                                            selectedTileColor: Colors.black,
                                            title: AddressData(addressData),
                                            trailing: IconButton(
                                              icon: Icon(Icons.close),
                                              onPressed: () {
                                                if (index != 0) {
                                                         context
                                                      .read<AddressProvider>()
                                                      .deleteAddress(index);
                                                } else {
                                                      print('Cannot delete the address with index 0.');
                                                }
                                              },
                                            ),
                                          ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
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
                                '\SAR${cartProvider.getTotalPrice().toStringAsFixed(2)}',
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ),
                            ListTile(
                              title: Text('VAT (${vatRate}%)'),
                              trailing: Text('\SAR${vat.toStringAsFixed(2)}'),
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
                                '\SAR${totalPriceWithVAT.toStringAsFixed(2)}',
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
              ]),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MobileBottomNavigationBaru(),
    );
  }
}
