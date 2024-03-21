import 'package:firebase_hex/pages/another_pages/IRSH.dart';
import 'dart:convert';
import 'package:firebase_hex/provider/address_provider.dart';
import 'package:firebase_hex/responsive/quatation.dart';
import 'package:firebase_hex/widgets/style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../enquiry.dart';

class QuotationPage extends StatelessWidget {
  final double totalPrice;
  final dynamic cartItems; // Make sure this type matches what you're passing
  final double totalPriceWithVAT;
  final double vat;
  final Map<String, dynamic> selectedAddress; // Now properly declared

  QuotationPage({
    required this.cartItems,
    required this.totalPrice,
    required this.vat,
    required this.totalPriceWithVAT,
    required this.selectedAddress, // Added to constructor
  });

  @override
  Widget build(BuildContext context) {
    return ResQuotation(
      mobileQuatation: QuotationMobilePage(
        cartItems: cartItems,
        totalPrice: totalPrice,
        totalPriceWithVAT: totalPriceWithVAT,
        vat: vat,
        selectedAddress: selectedAddress, // Pass the selected address
      ),
      deskQuatation: QuotationDeskPage(
        cartItems: cartItems,
        totalPrice: totalPrice,
        totalPriceWithVAT: totalPriceWithVAT,
        vat: vat,
        selectedAddress: selectedAddress, // Pass the selected address
      ),
    );
  }
}

class QuotationDeskPage extends StatelessWidget {
  final double totalPrice;
  final dynamic cartItems;
  final double totalPriceWithVAT;
  final double vat;
  final Map<String, dynamic> selectedAddress; // Declare the selectedAddress

  QuotationDeskPage({
    required this.cartItems,
    required this.totalPrice,
    required this.vat,
    required this.totalPriceWithVAT,
    required this.selectedAddress, // Include selectedAddress in the constructor
  });

  @override
  Widget build(BuildContext context) {
    // Use selectedAddress to display address details
    final companyName = selectedAddress['Company Name'];
    final contactNumber = selectedAddress['Contact Number'];
    final streetAddress = selectedAddress['Street Address'];
    final streetAddressline2 = selectedAddress['Street Address line 2'];
    final location = selectedAddress['Location'];
    final city = selectedAddress['City'];
    final email = selectedAddress['Email'];
    // Continue with other address fields as needed
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 232, 230, 230),
      appBar:
          custSmallAppBar(context, const Color.fromARGB(255, 232, 230, 230)),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: 800,
            // width: MediaQuery.of(context).size.width/2,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Quotes Details',
                            style: GoogleFonts.poppins(),
                          ),
                          Divider(
                            color: Colors.black54,
                            thickness: 0.5,
                          ),
                          Text(
                            'Requested Customer Details',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,),
                          ),
                          Gap(10),
                          // Display address information
                          SizedBox(
                            // color: colorTwo,
                            child:  Row(
                              children: [
                                Expanded(
                                  child:Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
 Text(
                            'Company Name : $companyName',
                            style: GoogleFonts.poppins(),
                          ),
                           Text(
                            'e-mail : $email',
                            style: GoogleFonts.poppins(),
                          ),
                          
                                    ],
                                  ) ),
                                  Expanded(
                                  child:Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,

                                    children: [
                                       Text(
                            'Mobile : $contactNumber',
                            style: GoogleFonts.poppins(),
                          ),
                            Text(
                            'Location : $location',
                            style: GoogleFonts.poppins(),
                          ),          
                          // Text(
                          //   '$streetAddress',
                          //   style: GoogleFonts.poppins(),
                          // ),
                                    ],
                                  ) )
                              ],
                            ),
                          ),
                         
                         
                         
                          
                          
                          // Text(
                          //   '$city',
                          //   style: GoogleFonts.poppins(),
                          // ),
                          // Continue displaying other address details as needed
                          // Your existing code to display the rest of the quotation page
                        ],
                      ),
                    )
                    // MyClipPath(),
                    ),
                Container(
                  child: _buildQuotationTable(),
                ),
              ],
            ),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Color.fromARGB(255, 76, 138, 131),
      //   onPressed: () async {
      //     context
      //         .read<AddressProvider>()
      //         .get_current_address(cartItems, context);
      //     // Call your backend API to increment the invoice number
      //     final response = await http.post(
      //       Uri.parse('https://deltabackend.com/invoice_number'),
      //     );
      //     if (response.statusCode == 200) {
      //       // If the increment was successful, perform other actions
      //       // You can also update the UI or display a message here
      //       print('Invoice number incremented successfully');
      //     } else {
      //       // Handle errors appropriately
      //       print('Failed to increment invoice number');
      //     }
      //     // Perform other actions if needed
      //   },
      //   child: const Icon(Icons.print),
      // ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 76, 138, 131),
        onPressed: () async {
          context
              .read<AddressProvider>()
              .get_current_address(cartItems, context);
          // Call your backend API to increment the invoice number
          final response = await http.post(
            Uri.parse('https://deltabackend.com/invoice_number'),
          );

          if (response.statusCode == 200) {
            // If the increment was successful, show an alert dialog with Yes and No options
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Success'),
                  content: Text(
                      'Some Product Might not have prices it is better to enquire the details about products more...'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        // Add your actions when 'Yes' is pressed
                        Navigator.of(context).pop();
                      },
                      child: Text('No'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return EnquireBox();
                          },
                        );
                      },
                      child: Text('Enquire Now'),
                    ),
                  ],
                );
              },
            );
          } else {
            // Handle errors and show an error alert dialog with OK button
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Error'),
                  content: Text('Failed to increment invoice number.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the alert dialog
                      },
                      child: Text('OK'),
                    ),
                  ],
                );
              },
            );
          }
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
                // color: const Color.fromARGB(255, 192, 173, 114),
                child: DataTable(
                  headingTextStyle:
                      GoogleFonts.poppins(color: Colors.black, fontSize: 14),
                  columnSpacing: 10.0,
                  dividerThickness: 0.5,
                  headingRowColor:
                      MaterialStateColor.resolveWith((states) => colorOne),
                  dataRowMaxHeight: 60,
                  headingRowHeight: 60,
                  horizontalMargin: 0,
                  columns: const [
                    DataColumn(label: Text(" SI.NO"), tooltip: '   i + 1'),
                    DataColumn(
                      label: Text(
                        '                        Description',
                      ),
                      tooltip: 'PRODUCT DESCRIPTION',
                    ),
                    DataColumn(
                      label: Text(
                        '     Code',
                      ),
                      tooltip: 'Product Code',
                    ),
                    DataColumn(
                      label: Text(
                        ' Qty',
                      ),
                      tooltip: 'Product Quantity',
                    ),
                    DataColumn(
                      label: Text(
                        '  Unit',
                      ),
                      tooltip: 'Unit',
                    ),
                    DataColumn(
                      label: Text(
                        '    Price',
                      ),
                      tooltip: 'Price per Unit',
                    ),
                    DataColumn(
                      label: Text(
                        '  Amount',
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
                          DataCell(_buildTableCell('${i + 1}')),
                          DataCell(_buildTableCell(
                              jsonDecode(cartItems[i])['productName'])),
                          DataCell(_buildTableCell(
                              jsonDecode(cartItems[i])['productCode'])),
                          DataCell(_buildTableCell(
                              '${jsonDecode(cartItems[i])['quantity']}')),
                          DataCell(_buildTableCell('unit')),
                          DataCell(
                            _buildTableCell(
                                '\SAR  ${jsonDecode(cartItems[i])['price']}',
                                fontWeight: FontWeight.bold),
                          ),
                          DataCell(_buildTableCell(
                              '\SAR${(jsonDecode(cartItems[i])['price'] * jsonDecode(cartItems[i])['quantity']).toStringAsFixed(2)}')),
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
                    //   // color: const Color.fromARGB(255, 128, 118, 91),
                    width: 500,
                    height: 200,
                  ),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       // _buildTableCell("janish"),
                  //       Text(
                  //         "TERM AND CONDITIONS",
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.w500, fontSize: 15),
                  //       ),
                  //       Gap(5),
                  //       Text(
                  //         "Payment	      : 30 Dyas",
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.w300, fontSize: 14),
                  //       ),
                  //       Text(
                  //         "Delivery	       : 03 Days",
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.w300, fontSize: 14),
                  //       ),
                  //       Text(
                  //         "Validity		        : 07 Days",
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.w300, fontSize: 14),
                  //       ),
                  //       Text(
                  //         "We hope our offer will meet your entire satisfaction and look forward\nto receive your valued order soon.Should you require any further\ninformation on our products, please feel free to contact us. We assure\nour prompt and professional service at all the time we remain.",
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.w300, fontSize: 14),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  SizedBox(
                    width: 264,
                    height: 200,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildTableCell(
                              ' Net before VAT',
                            ),
                            _buildTableCell(
                              '\SAR ${totalPrice.toStringAsFixed(2)}',
                            )
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
                            _buildTableCell(
                              'VAT ',
                            ),
                            _buildTableCell(
                              '              \SAR ${vat.toStringAsFixed(2)}',
                            )
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
                                  '\SAR${totalPriceWithVAT.toStringAsFixed(2)}',
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
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontWeight: fontWeight,
          fontSize: 14,
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
      required this.totalPriceWithVAT,
      required Map<String, dynamic> selectedAddress});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 232, 230, 230),
      appBar: custSmallAppBar(context, Colors.white),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height * 0.2,
              child: MyClipPath(),
            ),
            _buildQuotationTable(),
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
              // child: MyClipPat(),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 76, 138, 131),
        onPressed: () {
          context
              .read<AddressProvider>()
              .get_current_address(cartItems, context);
        },
        child: const Icon(Icons.print),
      ),
    );
  }

  Widget _buildQuotationTable() {
    return Row(
      children: [
        Container(
          // color: Colors.amber,
          width: 500,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 500,
                color: Color.fromARGB(255, 12, 141, 153),
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
                                '\SAR${jsonDecode(cartItems[i])['price']}',
                                fontWeight: FontWeight.bold),
                          ),
                          DataCell(_buildTableCell(
                              '\SAR${(jsonDecode(cartItems[i])['price'] * jsonDecode(cartItems[i])['quantity']).toStringAsFixed(2)}')),
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
                                '\SAR${totalPrice.toStringAsFixed(2)}',
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
                                '              \SAR${vat.toStringAsFixed(2)}',
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
                                  '\SAR${totalPriceWithVAT.toStringAsFixed(2)}',
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
  // final Color backgroundColor = Color.fromARGB(255, 76, 138, 131);
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      // clipper: BottomWaveClipper(),
      child: Container(
        height: 150,
        width: double.infinity,
        // color: ,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(10),
              Text(
                'Quotes Details',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              ),
              Divider(
                thickness: 0.5,
                color: const Color.fromARGB(255, 104, 104, 104),
              ),
              Text(
                'Requested Customer Details',
                style: GoogleFonts.poppins(),
              ),
              Gap(10),
              Row(
                children: [
                  // Text('Name : ',style: GoogleFonts.poppins(),),
                ],
              )
              // Text('Quotes Details',style: GoogleFonts.poppins(),),
            ],
          ),
        ),
      ),
    );
  }
}
