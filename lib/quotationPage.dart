import 'dart:convert';

import 'package:firebase_hex/pdfservies.dart';
// import 'package:firebase_hex/provider/cart_provider.dart';
import 'package:flutter/material.dart';

// import 'package:syncfusion_flutter_pdf/pdf.dart';
// import 'package:intl/intl.dart';

class QuotationPage extends StatelessWidget {
  // final List<User> cartItems;
  final double totalPrice;
  final cartItems;
  final totalPriceWithVAT;
  final vat; // Update the type if needed

  QuotationPage(
      {required this.cartItems,
      required this.totalPrice,
      required this.vat,
      required this.totalPriceWithVAT});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    // Add your navigation logic here to go back
                    Navigator.pop(context);
                  },
                ),
                Text(
                  'Go Back', // Replace with your page title
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      padding: EdgeInsets.only(top: 20.0),
                      child: _buildQuotationTable(),
                    ),
                  ),
                ),
                // Add more widgets to your ListView here
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 76, 138, 131),
        onPressed: () {
          // Add your FloatingActionButton logic here
          PdfService().generateInvoice(cartItems);
        },
        child: const Icon(Icons.print),
      ),
    );
  }

  Widget _buildQuotationTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      
      child: Container(
        // width: double.infinity,
        // decoration: BoxDecoration(
        //   border: Border.all(color: Colors.transparent),
        //   borderRadius: BorderRadius.circular(8),
        // ),

        child: Column(
          children: [
            Container(
              child: DataTable(
                columnSpacing: 10.0,
                dividerThickness: 2,
                headingRowColor: MaterialStateColor.resolveWith(
                  (states) => Color.fromARGB(255, 76, 138, 131),
                ),
                dataRowMaxHeight: 60,
                headingRowHeight: 60,
                horizontalMargin: 10,
                columns: [
                  // DataColumn(
                  //   label: _buildTableCell('SINO'),
                  //   tooltip: 'Serial Number',
                  // ),
                  DataColumn(
                    label: _buildTableCell(
                      'Description',
                    ),
                    tooltip: 'Product Description',
                  ),
                  DataColumn(
                    label: _buildTableCell('code '),
                    tooltip: 'Product Description',
                  ),
                  DataColumn(
                    label: _buildTableCell('Quantity'),
                    tooltip: 'Product Quantity',
                  ),
                  DataColumn(
                    label: _buildTableCell('Unit'),
                    tooltip: 'Unit',
                  ),
                  DataColumn(
                    label: _buildTableCell('Price'),
                    tooltip: 'Price per Unit',
                  ),
                  DataColumn(
                    label: _buildTableCell('Total Amount'),
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
                  // Total Amount Row
                  // DataRow(
                  //   color: MaterialStateColor.resolveWith(
                  //       (states) => const Color.fromARGB(0, 208, 9, 9)),
                  //   cells: [
                  //     DataCell(_buildTableCell('')),
                  //     DataCell(_buildTableCell('')),
                  //     DataCell(_buildTableCell('')),
                  //     DataCell(_buildTableCell('')),
                  //     DataCell(
                  //       _buildTableCell('Total Amount:',
                  //           fontWeight: FontWeight.bold),
                  //     ),
                  //     DataCell(_buildTableCell(
                  //         '\$${totalPrice.toStringAsFixed(2)}',
                  //         fontWeight: FontWeight.bold)),
                  //   ],
                  // ),
                  //  // NET BEFORE VAT Row
                  // DataRow(
                  //   color: MaterialStateColor.resolveWith(
                  //       (states) => const Color.fromARGB(0, 208, 9, 9)),
                  //   cells: [
                  //     DataCell(_buildTableCell('')),
                  //     DataCell(_buildTableCell('')),
                  //     DataCell(_buildTableCell('')),
                  //     DataCell(_buildTableCell('')),
                  //     DataCell(
                  //       _buildTableCell('NET BEFORE VAT:',
                  //           fontWeight: FontWeight.bold),
                  //     ),
                  //     DataCell(_buildTableCell(
                  //         '\$${totalPrice.toStringAsFixed(2)}',
                  //         fontWeight: FontWeight.bold)),
                  //   ],
                  // ),
                  //  // VAT Row
                  // DataRow(
                  //   color: MaterialStateColor.resolveWith(
                  //       (states) => const Color.fromARGB(0, 208, 9, 9)),
                  //   cells: [
                  //     DataCell(_buildTableCell('')),
                  //     DataCell(_buildTableCell('')),
                  //     DataCell(_buildTableCell('')),
                  //     DataCell(_buildTableCell('')),
                  //     DataCell(
                  //       _buildTableCell('VAT:',
                  //           fontWeight: FontWeight.bold),
                  //     ),
                  //     DataCell(_buildTableCell(
                  //         '\$${15}',
                  //         fontWeight: FontWeight.bold)),
                  //   ],
                  // ),
                  //  // Total WITH VAT Row
                  // DataRow(
                  //   color: MaterialStateColor.resolveWith(
                  //       (states) => const Color.fromARGB(0, 208, 9, 9)),
                  //   cells: [
                  //     DataCell(_buildTableCell('')),
                  //     DataCell(_buildTableCell('')),
                  //     DataCell(_buildTableCell('')),
                  //     DataCell(_buildTableCell('')),
                  //     DataCell(
                  //       _buildTableCell('Total WITH VAT:',
                  //           fontWeight: FontWeight.bold),
                  //     ),
                  //     DataCell(_buildTableCell(
                  //         '\$${totalPrice.toStringAsFixed(2)}',
                  //         fontWeight: FontWeight.bold)),
                  //   ],
                  // ),
                ],
              ),
            ),
            //*****_______GANERATE QUATATION TOTAL AMOUNT CONTAINER____********
            Row(
              children: [
                SizedBox(
                  width: 600,
                  height: 200,
                ),
                Container(
                  width: 264,
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 1)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildTableCell('Total Amount:',
                              fontWeight: FontWeight.bold),
                          _buildTableCell('\$${totalPrice.toStringAsFixed(2)}',
                              fontWeight: FontWeight.bold)
                        ],
                      ),
                      Divider(
                        indent: 20,
                        endIndent: 20,
                        color: const Color.fromARGB(255, 108, 106, 106),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildTableCell('NET BEFORE VAT:',
                              fontWeight: FontWeight.bold),
                          _buildTableCell('\$${totalPrice.toStringAsFixed(2)}',
                              fontWeight: FontWeight.bold)
                        ],
                      ),
                      Divider(
                        indent: 20,
                        endIndent: 20,
                        color: const Color.fromARGB(255, 108, 106, 106),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildTableCell('VAT:', fontWeight: FontWeight.bold),
                          _buildTableCell('\$${vat.toStringAsFixed(2)}',
                              fontWeight: FontWeight.bold)
                        ],
                      ),
                      Divider(
                        indent: 20,
                        endIndent: 20,
                        color: const Color.fromARGB(255, 108, 106, 106),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildTableCell('Total WITH VAT:',
                              fontWeight: FontWeight.bold),
                          _buildTableCell(
                              '\$${totalPriceWithVAT.toStringAsFixed(2)}',
                              fontWeight: FontWeight.bold)
                        ],
                      )
                    ],
                  ),
                )
              ],
            )
            //*********________END_______********* */
          ],
        ),
      ),
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
