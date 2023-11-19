import 'dart:convert';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
//Local imports
import '../save_file_mobile.dart' if (dart.library.html) 'save_file_web.dart';

class PdfService {
  Future<void> generateInvoice(
      List cartItems, String current_address, last_address) async {
    //Create a PDF document.
    final PdfDocument document = PdfDocument();
    //Add page to the PDF
    final PdfPage page = document.pages.add();
    //Get page client size
    final Size pageSize = page.getClientSize();
    //Draw rectangle
    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
        pen: PdfPen(PdfColor(142, 170, 219)));
    //Generate PDF grid.
    final PdfGrid grid = getGrid(cartItems);
    //Draw the header section by creating text element
    PdfLayoutResult result =
    drawHeader(page, pageSize, grid, current_address, last_address);
    //Draw grid
    drawGrid(page, grid, result);
    //Add invoice footer
    drawFooter(grid, result, page, document);
    //Save the PDF document
    final List<int> bytes = document.saveSync();
    //Dispose the document.
    document.dispose();
    //Save and launch the file.
    await saveAndLaunchFile(bytes, 'Invoice.pdf');
  }
}

//Draws the invoice header
PdfLayoutResult drawHeader(PdfPage page, Size pageSize, PdfGrid grid,
    String current_address, last_address) {
      int invoiceCounter = 1;
  //Draw rectangle
  page.graphics.drawRectangle(
      brush: PdfSolidBrush(PdfColor(68, 114, 196)),
      bounds: Rect.fromLTWH(0, 0, pageSize.width - 115, 90));
  //Draw string
  page.graphics.drawString(
      'INVOICE', PdfStandardFont(PdfFontFamily.helvetica, 30),
      brush: PdfBrushes.white,
      bounds: Rect.fromLTWH(25, 0, pageSize.width - 115, 90),
      format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));

  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 90),
      brush: PdfSolidBrush(PdfColor(68, 114, 196)));

  page.graphics.drawString(r'$' + getGrandTotal(grid).toString(),
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
      'Invoice Number: 1234567890\r\n\r\nDate: ${format.format(DateTime.now())}';
  final Size contentSize = contentFont.measureString(invoiceNumber);

  // ignore: leading_newlines_in_multiline_strings
  // String address = current_address;

  PdfTextElement(text: invoiceNumber, font: contentFont).draw(
      page: page,
      bounds: Rect.fromLTWH(pageSize.width - (contentSize.width + 30), 120,
          contentSize.width + 30, pageSize.height - 120));

  return PdfTextElement(
          text:
              ' ${last_address['COMPANY NAME']} \n${last_address['Contact Number']}\n${last_address['Street Address']}\n${last_address['city']} ',
          font: contentFont)
      .draw(
          page: page,
          bounds: Rect.fromLTWH(
              30,
              120,
              pageSize.width - (contentSize.width + 30),
              pageSize.height - 120))!;
}

//Draws the grid
void drawGrid(PdfPage page, PdfGrid grid, PdfLayoutResult result) {
  result = grid.draw(
      page: page, bounds: Rect.fromLTWH(0, result.bounds.bottom + 40, 0, 0))!;
}

//Draw the invoice footer data.
PdfLayoutResult drawFooter(
    PdfGrid grid, PdfLayoutResult result, PdfPage page, PdfDocument document) {
  for (int i = 0; i < document.pages.count; i++) {
    if (i == document.pages.count - 1) {
      return PdfTextElement(
              text: '''800 Interchange Blvd.\r\n\r\nSuite 2501, Austin,
          TX 78721\r\n\r\nAny Questions? sales@deltanationals.com''',
              font: PdfStandardFont(PdfFontFamily.timesRoman, 11))
          .draw(page: document.pages[i], bounds: Rect.fromLTWH(20, 670, 0, 0))!;
    }
  }
  return PdfTextElement(text: "").draw()!;
}

//Create PDF grid and return
PdfGrid getGrid(List cartItems) {
  final PdfGrid grid = PdfGrid();
  grid.columns.add(count: 7);

  final PdfGridRow headerRow = grid.headers.add(1)[0];
  headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(68, 114, 196));
  headerRow.style.textBrush = PdfBrushes.white;
  headerRow.cells[0].value = "SINO";
  headerRow.cells[1].value = "Description";
  headerRow.cells[2].value = "Product Code";
  headerRow.cells[3].value = "Quantity";
  headerRow.cells[4].value = "Unit";
  headerRow.cells[5].value = "Price";
  headerRow.cells[6].value = "Total";
  headerRow.height = 35;
  for (int i = 0; i < headerRow.cells.count; i++) {
    headerRow.cells[i].style.stringFormat = PdfStringFormat(
        alignment: PdfTextAlignment.center,
        lineAlignment: PdfVerticalAlignment.middle);
  }

  double grandTotal = 0;

  for (int i = 0; i < cartItems.length; i++) {
    final item = jsonDecode(cartItems[i]);
    final PdfGridRow row = grid.rows.add();
    row.cells[0].value = (i + 1).toString();
    row.cells[1].value = item['productName'];
    row.cells[2].value = item['productCode'];
    row.cells[3].value = item['quantity'].toString();
    row.cells[4].value = "Unit";
    row.cells[5].value = item['price'].toStringAsFixed(2);
    row.cells[6].value = (item['price'] * item['quantity']).toStringAsFixed(2);
    row.height = 30;
    for (int j = 0; j < row.cells.count; j++) {
      row.cells[j].style.stringFormat = PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle);
    }
    grandTotal += double.parse(row.cells[6].value.toString());
  }

  final PdfGridRow grandTotalRow = grid.rows.add();
  grandTotalRow.cells[0].value = '';
  grandTotalRow.cells[1].value = '';
  grandTotalRow.cells[2].value = '';
  grandTotalRow.cells[3].value = '';
  grandTotalRow.cells[4].value = '';
  grandTotalRow.cells[5].value = 'Net before VAT :';
  grandTotalRow.cells[6].value = grandTotal.toStringAsFixed(2);
  grandTotalRow.height = 30;
  for (int i = 0; i < grandTotalRow.cells.count; i++) {
    grandTotalRow.cells[i].style.stringFormat = PdfStringFormat(
        alignment: PdfTextAlignment.center,
        lineAlignment: PdfVerticalAlignment.middle);
  }

  final PdfGridRow vatRow = grid.rows.add();
  vatRow.cells[0].value = '';
  vatRow.cells[1].value = '';
  vatRow.cells[2].value = '';
  vatRow.cells[3].value = '';
  vatRow.cells[4].value = '';
  vatRow.cells[5].value = 'VAT (15%) :';
  vatRow.cells[6].value = (grandTotal * 0.15).toStringAsFixed(2);
  vatRow.height = 30;
  for (int i = 0; i < vatRow.cells.count; i++) {
    vatRow.cells[i].style.stringFormat = PdfStringFormat(
        alignment: PdfTextAlignment.center,
        lineAlignment: PdfVerticalAlignment.middle);
  }

  final PdfGridRow totalRow = grid.rows.add();
  totalRow.cells[0].value = '';
  totalRow.cells[1].value = '';
  totalRow.cells[2].value = '';
  totalRow.cells[3].value = '';
  totalRow.cells[4].value = '';
  totalRow.cells[5].value = 'Grand Total :';
  totalRow.cells[6].value =
      (grandTotal + (grandTotal * 0.15)).toStringAsFixed(2);
  totalRow.height = 30;
  for (int i = 0; i < totalRow.cells.count; i++) {
    totalRow.cells[i].style.stringFormat = PdfStringFormat(
        alignment: PdfTextAlignment.center,
        lineAlignment: PdfVerticalAlignment.middle);
  }

  grid.applyBuiltInStyle(PdfGridBuiltInStyle.listTable4Accent5);
  grid.columns[1].width = 200;

  return grid;
}

//Get the total amount.
String getGrandTotal(PdfGrid grid) {
  double total = 0;
  for (int i = 0; i < grid.rows.count - 3; i++) {
    final String value =
        grid.rows[i].cells[grid.columns.count - 1].value as String;
    total += double.parse(value);
  }
  return (total + total * 0.15).toStringAsFixed(2);
}
