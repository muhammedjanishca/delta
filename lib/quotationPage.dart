import 'dart:convert';

import 'package:firebase_hex/pdfservies.dart';
import 'package:firebase_hex/provider/cart_provider.dart';
import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:intl/intl.dart';


class QuotationPage extends StatelessWidget {
  // final List<User> cartItems;
  final double totalPrice;
 final cartItems; // Update the type if needed

  QuotationPage({required this.cartItems, required this.totalPrice});

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
      scrollDirection: Axis.vertical,
      child: Container(

        // width: double.infinity,
        // decoration: BoxDecoration(
        //   border: Border.all(color: Colors.transparent),
        //   borderRadius: BorderRadius.circular(8),
        // ),

        child: Column(
          children: [
            //     final PdfGridRow headerRow = grid.headers.add(1)[0];

            //     headerRow.cells[0].value = "SINO";
            //      headerRow.cells[1].value = "Description";
            //        headerRow.cells[2].value = "product code";
            //      headerRow.cells[3].value = "Quantity";
            //      headerRow.cells[4].value = "Unit";
            //  headerRow.cells[5].value = "Price";
            //      headerRow.cells[6].value = "Total";
  

            DataTable(
              columnSpacing: 10.0,
              dividerThickness: 2,
              headingRowColor: MaterialStateColor.resolveWith(
                  (states) => Color.fromARGB(255, 54, 98, 98)),
              dataRowMaxHeight: 50,
              headingRowHeight: 60,
              horizontalMargin: 10,
              columns: [
                // DataColumn(
                //   label: _buildTableCell('SINO'),
                //   tooltip: 'Serial Number',
                // ),
                DataColumn(
                  label: _buildTableCell('Description',),
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
                      DataCell(_buildTableCell(jsonDecode(cartItems[i])['productName'])),
                                        DataCell(_buildTableCell(jsonDecode(cartItems[i])['productCode'])),

                      DataCell(_buildTableCell('${jsonDecode(cartItems[i])['quantity']}')),
                      DataCell(_buildTableCell('unit')),
                      DataCell(
                        _buildTableCell('\$${jsonDecode(cartItems[i])['price']}',
                            fontWeight: FontWeight.bold),
                      ),
                      DataCell(_buildTableCell(
                          '\$${(jsonDecode(cartItems[i])['price'] * jsonDecode(cartItems[i])['quantity']).toStringAsFixed(2)}')),
                    ],
                  ),
                // Total Amount Row
                DataRow(
                  color: MaterialStateColor.resolveWith(
                      (states) => const Color.fromARGB(0, 208, 9, 9)),
                  cells: [
                    DataCell(_buildTableCell('')),
                    DataCell(_buildTableCell('')),
                    DataCell(_buildTableCell('')),
                    DataCell(_buildTableCell('')),
                    DataCell(
                      _buildTableCell(
                          'Total Amount:', fontWeight: FontWeight.bold),
                    ),
                    DataCell(_buildTableCell(
                        '\$${totalPrice.toStringAsFixed(2)}',
                        fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
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
        style: TextStyle(fontWeight: fontWeight,),
        textAlign: TextAlign.center,
      ),
    );
  }
  //Draws the invoice header
  PdfLayoutResult drawHeader(PdfPage page, Size pageSize, PdfGrid grid) {
    //Draw rectangle
    page.graphics.drawRectangle(
        brush: PdfSolidBrush(PdfColor(91, 126, 215)),
        bounds: Rect.fromLTWH(0, 0, pageSize.width - 115, 90));
    //Draw string
    page.graphics.drawString(
        'INVOICE', PdfStandardFont(PdfFontFamily.helvetica, 30),
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(25, 0, pageSize.width - 115, 90),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));

    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 90),
        brush: PdfSolidBrush(PdfColor(65, 104, 205)));

    page.graphics.drawString('\$${totalPrice.toStringAsFixed(2)}',
        PdfStandardFont(PdfFontFamily.helvetica, 18),
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 100),
        brush: PdfBrushes.white,
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.middle));

    final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 9);
    //Draw string
    page.graphics.drawString('Amount', contentFont,
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.bottom));
    //Create data foramt and convert it to text.
    final DateFormat format = DateFormat.yMMMMd('en_US');
    final String invoiceNumber =
        'Invoice Number: 2058557939\r\n\r\nDate: ${format.format(DateTime.now())}';
    final Size contentSize = contentFont.measureString(invoiceNumber);
    // ignore: leading_newlines_in_multiline_strings
    const String address = '''Bill To: \r\n\r\nAbraham Swearegin, 
        \r\n\r\nUnited States, California, San Mateo, 
        \r\n\r\n9920 BridgePointe Parkway, \r\n\r\n9365550136''';

    PdfTextElement(text: invoiceNumber, font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(pageSize.width - (contentSize.width + 30), 120,
            contentSize.width + 30, pageSize.height - 120));

    return PdfTextElement(text: address, font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(30, 120,
            pageSize.width - (contentSize.width + 30), pageSize.height - 120))!;
  }

}