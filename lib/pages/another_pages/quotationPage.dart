import 'dart:convert';
import 'package:firebase_hex/widgets/pdfservies.dart';
// import 'package:firebase_hex/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

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
      backgroundColor: Color.fromARGB(255, 232, 230, 230),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 232,230, 230),
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
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Center(
                  child: Container(
                    color: Colors.white,
                    // decoration: BoxDecoration(
                    //   border: Border.symmetric(vertical: BorderSide(width: .4,color: Colors.black))
                    // ),
                    width: MediaQuery.of(context).size.width / 1.9,
                    // width: MediaQuery.of(context).size.width * 0.6,
                  //  padding: EdgeInsets.only(top: 20.0),
                    child: Center(
                        child: Column(
                      children: [
                        Container(
                          color: Colors.white,
                          height: MediaQuery.of(context).size.height / 4,
                          child: MyClipPath(),
                        ),
                        Container(
                            // decoration: BoxDecoration(
                            //     border: Border.symmetric(
                            //   vertical: BorderSide(
                            //       // width: 0.2,
                            //       color: Color.fromARGB(255, 121, 121, 121)),
                            //   // width: 2.5,
                            //   // color: Color.fromARGB(255, 194, 193, 193)
                            // )),
                            child: _buildQuotationTable()),
                        SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Container(
                            height: MediaQuery.of(context).size.height / 7,
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
                            child: MyClipPat(),
                          ),
                        ),
                        // cont(
                        //   height: MediaQuery.of(context).size.height / 15,
                        // )
                      ],
                    )),
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
      child: Row(
        children: [
          Container(
            // color: Color.fromARGB(255, 169, 53, 125),
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
                      (states) =>  Color.fromARGB(255, 91, 166, 157),
                    ),
                    dataRowMaxHeight: 60,
                    headingRowHeight: 60,
                    horizontalMargin: 10,
                    columns: [
                      DataColumn(
                        label: Text(
                          '            Description',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white // Adjust the font size as needed
                            // You can also apply other text styles like fontWeight, color, etc. here
                          ),
                        ),
                        tooltip: 'Product Description',
                      ),
                        DataColumn(
                        label: Text(
                          'Code',
                          style: TextStyle(
                            fontSize: 15,
                             color: Colors.white // Adjust the font size as needed
                            // You can also apply other text styles like fontWeight, color, etc. here
                          ),
                        ),
                        tooltip: 'Product Description',
                      ),
                        DataColumn(
                        label: Text(
                          'Quantity',
                          style: TextStyle(
                            fontSize: 15,
                             color: Colors.white // Adjust the font size as needed
                            // You can also apply other text styles like fontWeight, color, etc. here
                          ),
                        ),
                        tooltip: 'Product Quantity',
                      ),
                        DataColumn(
                        label: Text(
                          'Unit',
                          style: TextStyle(
                            fontSize: 15,
                             color: Colors.white // Adjust the font size as needed
                            // You can also apply other text styles like fontWeight, color, etc. here
                          ),
                        ),
                        tooltip: 'Unit',
                      ),
                        DataColumn(
                        label: Text(
                          'Price',
                          style: TextStyle(
                            fontSize: 15,
                             color: Colors.white // Adjust the font size as needed
                            // You can also apply other text styles like fontWeight, color, etc. here
                          ),
                        ),
                        tooltip: 'Price per Unit',
                      ),
                        DataColumn(
                        label: Text(
                          'Total Amount',
                          style: TextStyle(
                            fontSize: 15,
                             color: Colors.white // Adjust the font size as needed
                            // You can also apply other text styles like fontWeight, color, etc. here
                          ),
                        ),
                        tooltip: 'Total Amount',
                      ),
                      // DataColumn(
                      //   label: _buildTableCell(
                      //     'Description',
                      //   ),
                      //   tooltip: 'Product Description',
                      // ),
                      // DataColumn(
                      //   label: _buildTableCell('code '),
                      //   tooltip: 'Product Description',
                      // ),
                      // DataColumn(
                      //   label: _buildTableCell('Quantity'),
                      //   tooltip: 'Product Quantity',
                      // ),
                      // DataColumn(
                      //   label: _buildTableCell('Unit'),
                      //   tooltip: 'Unit',
                      // ),
                      // DataColumn(
                      //   label: _buildTableCell('Price'),
                      //   tooltip: 'Price per Unit',
                      // ),
                      // DataColumn(
                      //   label: _buildTableCell('Total Amount'),
                      //   tooltip: 'Total Amount',
                      // ),
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

                // SizedBox(
                //   height: 30,
                // ),
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
                      width:20,
                      height: 10,),
                    SizedBox(
                      // color: const Color.fromARGB(255, 128, 118, 91),
                      width: 500,
                      height:200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // _buildTableCell("janish"),
                        Text("TERM AND CONDITIONS",
                        style: TextStyle(fontWeight: FontWeight.w500,fontSize:15),),
                        Gap(5),
                        Text("Payment	      : 30 Dyas",style: TextStyle(fontWeight: FontWeight.w300,fontSize:14),),
                        Text("Delivery	       : 03 Days",style: TextStyle(fontWeight: FontWeight.w300,fontSize:14),),
                        Text("Validity		        : 07 Days",style: TextStyle(fontWeight: FontWeight.w300,fontSize:14),),
                        Text("We hope our offer will meet your entire satisfaction and look forward\nto receive your valued order soon.Should you require any further\ninformation on our products, please feel free to contact us. We assure\nour prompt and professional service at all the time we remain.",
                        style: TextStyle(fontWeight: FontWeight.w300,fontSize:14),)
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 264,
                      height: 200,
                      // color: Color.fromARGB(255, 31, 135, 86),
                      // decoration:
                      // BoxDecoration(
                      //     borderRadius: BorderRadius.circular(15),
                      //     border: Border.all(width: 1)),
                      child: Column(
                        children: [
                          // ListTile(
                          //   title:  _buildTableCell('Total Amount:',
                          //         fontWeight: FontWeight.bold),
                          //         trailing:  _buildTableCell(
                          //         '\$${totalPrice.toStringAsFixed(2)}',
                          //         fontWeight: FontWeight.bold) ,
                          // ),
//                           ListTile(
//                             title:   _buildTableCell('NET BEFORE VAT:',
//                                   fontWeight: FontWeight.bold),
//                                   trailing:  _buildTableCell(
//                                   '\$${totalPrice.toStringAsFixed(2)}',
//                                   fontWeight: FontWeight.bold)
//                           ),
//                           ListTile(
//                             title:  _buildTableCell('VAT:',
//                                   fontWeight: FontWeight.bold),
//                                   trailing:
//                               _buildTableCell('\$${vat.toStringAsFixed(2)}',
//                                   fontWeight: FontWeight.bold)
// ,
//                           ),
//                           ListTile(
//                             title:  _buildTableCell('Total WITH VAT:',
//                                   fontWeight: FontWeight.bold),
//                                   trailing:
//                               _buildTableCell(
//                                   '\$${totalPriceWithVAT.toStringAsFixed(2)}',
//                                   fontWeight: FontWeight.bold),
//                           )
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     _buildTableCell('Total Amount',
                          //         fontWeight: FontWeight.bold),
                          //     _buildTableCell(
                          //         ' \$${totalPrice.toStringAsFixed(2)}',
                          //         fontWeight: FontWeight.bold)
                          //   ],
                          // ),
                          // Divider(
                          //   indent: 20,
                          //   endIndent: 20,
                          //   color: Color.fromARGB(255, 186, 185, 185),
                          // ),
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
                //*********________END_______********* */
              ],
            ),
          ),
        ],
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
                  SizedBox(height: 20,),
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
                      Text("DELTA",style: GoogleFonts.oswald(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 35,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),),
             
                      Text(
                        "\nNATIONAL",
                        style: GoogleFonts.oswald(
                          textStyle: TextStyle(
color: Colors.black,                            fontSize: 10,
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
