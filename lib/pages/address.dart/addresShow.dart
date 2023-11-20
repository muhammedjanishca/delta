import 'dart:convert';
import 'package:firebase_hex/pages/address.dart/sideSheetAddress.dart';
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
    return const resAddressShow(
        mobileaddressShow: AddressShowMob(), deskAddressShow: AddressShow());
  }
}

class AddressShow extends StatelessWidget {
  const AddressShow({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final addressprovider = Provider.of<AddressProvider>(context);

    cartProvider.getAddressData();
    var cartItems = cartProvider.fetchedItems;
    var addressItem = addressprovider.fetchedItems;

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

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
                    textStyle: const TextStyle(
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
        body: SizedBox(
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
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const Gap(150),
                                      const Icon(Icons.add),
                                      TextButton(
                                          onPressed: () => SideSheet.right(
                                              body: const TextAddress(),
                                              //  TextAddress(),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3,
                                              context: context),
                                          child: const Text(
                                            "ADD ADDRESS",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ))
                                    ],
                                  ),
                                  ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: cartItems["address"].length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      // Extracting the address data from the JSON string
                                      var addressData = jsonDecode(
                                          cartItems["address"][index]);

                                      // Return a ListTile for each address item
                                      return ListTile(

                                        contentPadding: const EdgeInsets.all(
                                            10),
                                        title: Container(
                                            color: const Color.fromARGB(
                                                255, 161, 191, 203),
                                            height:
                                                150,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child:
                                                      AddressData(addressData),
                                                ),
                                                IconButton(
                                                  icon:
                                                      const Icon(Icons.delete),
                                                  onPressed: () {
                                                    print("yyyyyyyyyyyyyyyyy");
                                                    addressprovider
                                                        .removeAddress(
                                                            index,
                                                            addressItem[
                                                                'address']);
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                IconButton(
                                                  icon:
                                                      const Icon(Icons.add_box),
                                                  onPressed: () {
                                                   
                                                  },
                                                ),
                                              ],
                                            )
                                            //  _buildAddressListItem(
                                            //     addressData, index, () {
                                            //   addressprovider.removeAddress(
                                            //       index, addressItem['address']);
                                            //   Navigator.of(context).pop();
                                            // }),
                                            ),
                                      );
                                    },
                                  )
                                ],
                              )),
                        ],
                      ),
                    ),

                    const Gap(25),
                    Column(
                      children: [
                        Container(
                          width: 0.5,
                          height: 130,
                          color: const Color.fromARGB(255, 122, 122, 122),
                        ),
                        Container(
                          width: 0.5,
                          height: 130,
                          color: const Color.fromARGB(255, 122, 122, 122),
                        ),
                      ],
                    ),
                    SizedBox(
                      // color: Colors.amber,
                      width: width / 2.5,
                      height: height / 2,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [],
                      ),
                    )
                  ],
                ),
              ],
            )));
  }
}

Widget _buildAddressListItem(
    Map<String, dynamic> addressData, int index, Function() delete) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: AddressData(addressData),
      ),
      IconButton(icon: const Icon(Icons.delete), onPressed: delete),
      IconButton(
        icon: const Icon(Icons.add_box),
        onPressed: () {
          // Handle the select button action
          // You can use the index to identify the selected item
          // Perform any other necessary actions
        },
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
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18
            // You can also specify other text styles here, e.g., fontSize, color, etc.
            ),
      ),
      Text(
        "${item['Contact Number']}",
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18
            // You can also specify other text styles here, e.g., fontSize, color, etc.
            ),
      ),
      Text(
        "${item['City']}",
        // "${item['vat']} ,  " "${item['state']}",
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18
            // You can also specify other text styles here, e.g., fontSize, color, etc.
            ),
      ),
      // Text('Selected Emirate: $selectedEmirate'"),
      Text(
        "${item['Street Address']}" "${item['Street Address line 2']}",
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18
            // You can also specify other text styles here, e.g., fontSize, color, etc.
            ),
      ),
    ],
  );
}

class AddressShowMob extends StatelessWidget {
  const AddressShowMob({super.key});

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
                    textStyle: const TextStyle(
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
        body: SizedBox(
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
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const Gap(150),
                                      const Icon(Icons.add),
                                      TextButton(
                                          onPressed: () => SideSheet.right(
                                              body: const TextAddress(),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3,
                                              context: context),
                                          child: const Text(
                                            "ADD ADDRESS",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ))
                                    ],
                                  ),
                                  Container(
                                    color: const Color.fromARGB(
                                        255, 174, 210, 220),
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
                                              child: const Text(
                                                'Deliver to this Address',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        const Color.fromARGB(
                                                            255, 97, 128, 190)),
                                                minimumSize:
                                                    MaterialStateProperty.all(
                                                        const Size(200, 40)),
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
