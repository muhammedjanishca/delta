import 'dart:convert';
import 'package:firebase_hex/provider/address_provider.dart';
import 'package:firebase_hex/responsive/quatation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class QuotationPage extends StatelessWidget {
  QuotationPage(
      {required this.cartItems,
      required this.totalPrice,
      required this.vat,
      required this.totalPriceWithVAT});
  final double totalPrice;
  final cartItems;
  final totalPriceWithVAT;
  final vat;
  @override
  Widget build(BuildContext context) {
    return ResQuotation(
      mobileQuatation: QuotationMobilePage(
        cartItems: cartItems,
        totalPrice: totalPrice,
        totalPriceWithVAT: totalPriceWithVAT,
        vat: vat,
      ),
      deskQuatation: QuotationDeskPage(
          cartItems: cartItems,
          totalPrice: totalPrice,
          totalPriceWithVAT: totalPriceWithVAT,
          vat: vat),
    );
  }
}

class QuotationDeskPage extends StatelessWidget {
  // final List<User> cartItems;
  final double totalPrice;
  final cartItems;
  final totalPriceWithVAT;
  final vat; // Update the type if needed

  QuotationDeskPage(
      {required this.cartItems,
      required this.totalPrice,
      required this.vat,
      required this.totalPriceWithVAT});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 232, 230, 230),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 232, 230, 230),
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
                    fontSize: 35,
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
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: 800,
            // width: MediaQuery.of(context).size.width/2,
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: MyClipPath(),
                ),
                Container(
                  child: _buildQuotationTable(),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white,
                        const Color.fromARGB(255, 76, 138, 131),
                        const Color.fromARGB(255, 76, 138, 131)
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: MyClipPat(),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 76, 138, 131),
        onPressed: () async {
          context.read<AddressProvider>().get_current_address(cartItems, context);
          // Call your backend API to increment the invoice number
          final response = await http.post(
            Uri.parse('https://deltabackend.com/invoice_number'),
          );

          if (response.statusCode == 200) {
            // If the increment was successful, perform other actions
            // You can also update the UI or display a message here
            print('Invoice number incremented successfully');
          } else {
            // Handle errors appropriately
            print('Failed to increment invoice number');
          }

          // Perform other actions if needed
        },
        child: const Icon(Icons.print),
      ),
    );
  }

  Widget _buildQuotationTable() {
    return Row(
      children: [
        Container(
          child: Column(
            children: [
              Container(
                width: 800,
                color: const Color.fromARGB(255, 192, 173, 114),
                child: DataTable(
                  columnSpacing: 10.0,
                  dividerThickness: 2,
                  headingRowColor: MaterialStateColor.resolveWith(
                    (states) => Color.fromARGB(255, 91, 166, 157),
                  ),
                  dataRowMaxHeight: 60,
                  headingRowHeight: 60,
                  horizontalMargin: 10,
                  columns: [
                    DataColumn(
                      label: Text(
                        '                               DESCRIPTION',
                        style: TextStyle(
                            fontSize: 15,
                            color:
                                Colors.white // Adjust the font size as needed
                            // You can also apply other text styles like fontWeight, color, etc. here
                            ),
                      ),
                      tooltip: 'PRODUCT DESCRIPTION',
                    ),
                    DataColumn(
                      label: Text(
                        'CODE',
                        style: TextStyle(
                            fontSize: 15,
                            color:
                                Colors.white // Adjust the font size as needed
                            // You can also apply other text styles like fontWeight, color, etc. here
                            ),
                      ),
                      tooltip: 'Product Description',
                    ),
                    DataColumn(
                      label: Text(
                        'QTY',
                        style: TextStyle(
                            fontSize: 15,
                            color:
                                Colors.white // Adjust the font size as needed
                            // You can also apply other text styles like fontWeight, color, etc. here
                            ),
                      ),
                      tooltip: 'Product Quantity',
                    ),
                    DataColumn(
                      label: Text(
                        'UNIT',
                        style: TextStyle(
                            fontSize: 15,
                            color:
                                Colors.white // Adjust the font size as needed
                            // You can also apply other text styles like fontWeight, color, etc. here
                            ),
                      ),
                      tooltip: 'Unit',
                    ),
                    DataColumn(
                      label: Text(
                        'PRICE',
                        style: TextStyle(
                            fontSize: 15,
                            color:
                                Colors.white // Adjust the font size as needed
                            // You can also apply other text styles like fontWeight, color, etc. here
                            ),
                      ),
                      tooltip: 'Price per Unit',
                    ),
                    DataColumn(
                      label: Text(
                        'AMOUNT',
                        style: TextStyle(
                            fontSize: 15,
                            color:
                                Colors.white // Adjust the font size as needed
                            // You can also apply other text styles like fontWeight, color, etc. here
                            ),
                      ),
                      tooltip: 'Total Amount',
                    ),
                  ],
                  rows: [
                    for (var i = 0; i < cartItems.length; i++)
                      DataRow(
                        color: MaterialStateColor.resolveWith((states) =>
                            i % 2 == 0 ? Colors.white : Colors.transparent),
                        cells: [
                          // DataCell(_buildTableCell('${i + 1}')),
                          DataCell(_buildTableCell(
                              jsonDecode(cartItems[i])['productName'])),
                          DataCell(_buildTableCell(
                              jsonDecode(cartItems[i])['productCode'])),

                          DataCell(_buildTableCell(
                              '${jsonDecode(cartItems[i])['quantity']}')),
                          DataCell(_buildTableCell('unit')),
                          DataCell(
                            _buildTableCell(
                                '\$${jsonDecode(cartItems[i])['price']}',
                                fontWeight: FontWeight.bold),
                          ),
                          DataCell(_buildTableCell(
                              '\$${(jsonDecode(cartItems[i])['price'] * jsonDecode(cartItems[i])['quantity']).toStringAsFixed(2)}')),
                        ],
                      ),
                  ],
                ),
              ),
              Divider(
                indent: 10,
                endIndent: 20,
                color: const Color.fromARGB(255, 108, 106, 106),
              ),
              //*****_______GANERATE QUATATION TOTAL AMOUNT CONTAINER____********
              Row(
                children: [
                  Container(
                    // color: Colors.amber,
                    width: 20,
                    height: 10,
                  ),
                  SizedBox(
                    // color: const Color.fromARGB(255, 128, 118, 91),
                    width: 500,
                    height: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // _buildTableCell("janish"),
                        Text(
                          "TERM AND CONDITIONS",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15),
                        ),
                        Gap(5),
                        Text(
                          "Payment	      : 30 Dyas",
                          style: TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 14),
                        ),
                        Text(
                          "Delivery	       : 03 Days",
                          style: TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 14),
                        ),
                        Text(
                          "Validity		        : 07 Days",
                          style: TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 14),
                        ),
                        Text(
                          "We hope our offer will meet your entire satisfaction and look forward\nto receive your valued order soon.Should you require any further\ninformation on our products, please feel free to contact us. We assure\nour prompt and professional service at all the time we remain.",
                          style: TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 14),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 264,
                    height: 200,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildTableCell(' Net before VAT',
                                fontWeight: FontWeight.bold),
                            _buildTableCell(
                                '\$${totalPrice.toStringAsFixed(2)}',
                                fontWeight: FontWeight.bold)
                          ],
                        ),
                        Divider(
                          indent: 20,
                          endIndent: 20,
                          color: Color.fromARGB(255, 186, 185, 185),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildTableCell('VAT ',
                                fontWeight: FontWeight.bold),
                            _buildTableCell(
                                '              \$${vat.toStringAsFixed(2)}',
                                fontWeight: FontWeight.bold)
                          ],
                        ),
                        Container(
                          color: Colors.amber,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildTableCell('Total Amount',
                                  fontWeight: FontWeight.bold),
                              _buildTableCell(
                                  '\$${totalPriceWithVAT.toStringAsFixed(2)}',
                                  fontWeight: FontWeight.bold)
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTableCell(String text,
      {FontWeight fontWeight = FontWeight.normal}) {
    return Container(
      padding: const EdgeInsets.all(8),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: fontWeight,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class QuotationMobilePage extends StatelessWidget {
  // final List<User> cartItems;
  final double totalPrice;
  final cartItems;
  final totalPriceWithVAT;
  final vat; // Update the type if needed

  QuotationMobilePage(
      {required this.cartItems,
      required this.totalPrice,
      required this.vat,
      required this.totalPriceWithVAT});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 232, 230, 230),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 232, 230, 230),
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
                    fontSize: 35,
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
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: 500,
            // width: MediaQuery.of(context).size.width/2,
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: MyClipPath(),
                ),
                Container(
                  color: Colors.amber,
                  child: _buildQuotationTable(),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white,
                        const Color.fromARGB(255, 76, 138, 131),
                        const Color.fromARGB(255, 76, 138, 131)
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: MyClipPat(),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 76, 138, 131),
        onPressed: () async {
          context.read<AddressProvider>().get_current_address(cartItems, context);
          // Call your backend API to increment the invoice number
          final response = await http.post(
            Uri.parse('https://deltabackend.com/invoice_number'),
          );

          if (response.statusCode == 200) {
            // If the increment was successful, perform other actions
            // You can also update the UI or display a message here
            print('Invoice number incremented successfully');
          } else {
            // Handle errors appropriately
            print('Failed to increment invoice number');
          }
          // Perform other actions if needed
        },
        child: const Icon(Icons.print),
      ),
    );
  }

  Widget _buildQuotationTable() {
    return Row(
      children: [
        Container(
          color: Colors.black,
          child: Column(
            children: [
              Container(
                width: 500,
                color: const Color.fromARGB(255, 192, 173, 114),
                child: DataTable(
                  columnSpacing: 10.0,
                  dividerThickness: 2,
                  headingRowColor: MaterialStateColor.resolveWith(
                    (states) => Color.fromARGB(255, 91, 166, 157),
                  ),
                  dataRowMaxHeight: 60,
                  headingRowHeight: 60,
                  horizontalMargin: 10,
                  columns: [
                    DataColumn(
                      label: Text(
                        'DESCRIPTION',
                        style: TextStyle(
                            fontSize: 15,
                            color:
                                Colors.white // Adjust the font size as needed
                            // You can also apply other text styles like fontWeight, color, etc. here
                            ),
                      ),
                      tooltip: 'PRODUCT DESCRIPTION',
                    ),
                    DataColumn(
                      label: Text(
                        'CODE',
                        style: TextStyle(
                            fontSize: 15,
                            color:
                                Colors.white // Adjust the font size as needed
                            // You can also apply other text styles like fontWeight, color, etc. here
                            ),
                      ),
                      tooltip: 'Product Description',
                    ),
                    DataColumn(
                      label: Text(
                        'QTY',
                        style: TextStyle(
                            fontSize: 15,
                            color:
                                Colors.white // Adjust the font size as needed
                            // You can also apply other text styles like fontWeight, color, etc. here
                            ),
                      ),
                      tooltip: 'Product Quantity',
                    ),
                    DataColumn(
                      label: Text(
                        'UNIT',
                        style: TextStyle(
                            fontSize: 15,
                            color:
                                Colors.white // Adjust the font size as needed
                            // You can also apply other text styles like fontWeight, color, etc. here
                            ),
                      ),
                      tooltip: 'Unit',
                    ),
                    DataColumn(
                      label: Text(
                        'PRICE',
                        style: TextStyle(
                            fontSize: 15,
                            color:
                                Colors.white // Adjust the font size as needed
                            // You can also apply other text styles like fontWeight, color, etc. here
                            ),
                      ),
                      tooltip: 'Price per Unit',
                    ),
                    DataColumn(
                      label: Text(
                        'AMOUNT',
                        style: TextStyle(
                            fontSize: 15,
                            color:
                                Colors.white // Adjust the font size as needed
                            // You can also apply other text styles like fontWeight, color, etc. here
                            ),
                      ),
                      tooltip: 'Total Amount',
                    ),
                  ],
                  rows: [
                    for (var i = 0; i < cartItems.length; i++)
                      DataRow(
                        color: MaterialStateColor.resolveWith((states) =>
                            i % 2 == 0 ? Colors.white : Colors.transparent),
                        cells: [
                          // DataCell(_buildTableCell('${i + 1}')),
                          DataCell(_buildTableCell(
                              jsonDecode(cartItems[i])['productName'])),
                          DataCell(_buildTableCell(
                              jsonDecode(cartItems[i])['productCode'])),

                          DataCell(_buildTableCell(
                              '${jsonDecode(cartItems[i])['quantity']}')),
                          DataCell(_buildTableCell('unit')),
                          DataCell(
                            _buildTableCell(
                                '\$${jsonDecode(cartItems[i])['price']}',
                                fontWeight: FontWeight.bold),
                          ),
                          DataCell(_buildTableCell(
                              '\$${(jsonDecode(cartItems[i])['price'] * jsonDecode(cartItems[i])['quantity']).toStringAsFixed(2)}')),
                        ],
                      ),
                  ],
                ),
              ),
              Divider(
                indent: 10,
                endIndent: 20,
                color: const Color.fromARGB(255, 108, 106, 106),
              ),
              //*****_______GANERATE QUATATION TOTAL AMOUNT CONTAINER____********
              Row(
                children: [
                  Container(
                    // color: Colors.amber,
                    width: 20,
                    height: 10,
                  ),
                  SizedBox(
                    // color: const Color.fromARGB(255, 128, 118, 91),
                    width: 500,
                    height: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // _buildTableCell("janish"),
                        Text(
                          "TERM AND CONDITIONS",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15),
                        ),
                        Gap(5),
                        Text(
                          "Payment	      : 30 Dyas",
                          style: TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 14),
                        ),
                        Text(
                          "Delivery	       : 03 Days",
                          style: TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 14),
                        ),
                        Text(
                          "Validity		        : 07 Days",
                          style: TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 14),
                        ),
                        Text(
                          "We hope our offer will meet your entire satisfaction and look forward\nto receive your valued order soon.Should you require any further\ninformation on our products, please feel free to contact us. We assure\nour prompt and professional service at all the time we remain.",
                          style: TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 14),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 264,
                    height: 200,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildTableCell(' Net before VAT',
                                fontWeight: FontWeight.bold),
                            _buildTableCell(
                                '\$${totalPrice.toStringAsFixed(2)}',
                                fontWeight: FontWeight.bold)
                          ],
                        ),
                        Divider(
                          indent: 20,
                          endIndent: 20,
                          color: Color.fromARGB(255, 186, 185, 185),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildTableCell('VAT ',
                                fontWeight: FontWeight.bold),
                            _buildTableCell(
                                '              \$${vat.toStringAsFixed(2)}',
                                fontWeight: FontWeight.bold)
                          ],
                        ),
                        Container(
                          color: Colors.amber,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildTableCell('Total Amount',
                                  fontWeight: FontWeight.bold),
                              _buildTableCell(
                                  '\$${totalPriceWithVAT.toStringAsFixed(2)}',
                                  fontWeight: FontWeight.bold)
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTableCell(String text,
      {FontWeight fontWeight = FontWeight.normal}) {
    return Container(
      padding: const EdgeInsets.all(8),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: fontWeight,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class MyClipPath extends StatelessWidget {
  final Color backgroundColor = Color.fromARGB(255, 76, 138, 131);
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BottomWaveClipper(),
      child: Container(
        height: 150,
        width: double.infinity,
        color: backgroundColor,
        child: Row(
          children: [
            Gap(15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text("Abdullah Shaher Alsulami Est.",
                    style: GoogleFonts.oswald(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    )),
                // Gap(1),
                Row(
                  children: [
                    Text(
                      "DELTA",
                      style: GoogleFonts.oswald(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 35,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Text(
                      "\nNATIONAL",
                      style: GoogleFonts.oswald(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  'TRADING & CONTRACTING, ELECRICAL & MAECHANICAL SUPPLIES',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 10),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height - 40);
    path.quadraticBezierTo(
        size.width / 4, size.height - 80, size.width / 2, size.height - 40);
    path.quadraticBezierTo(size.width - (size.width / 4), size.height,
        size.width, size.height - 40);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class MyClipPat extends StatelessWidget {
  final Color backgroundColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BottomWaveClipper(),
      child: Container(
        color: backgroundColor,
        // child: Text("cvbnm"),
      ),
    );
  }
}
