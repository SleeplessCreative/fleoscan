import 'dart:async';

import 'package:fleoscan/datamodels/flight_data.dart';
import 'package:fleoscan/datamodels/save_pdf_properties.dart';
import 'package:fleoscan/services/pdf_module/pdf_item_properties.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

PdfPageFormat format = PdfPageFormat.a4;
PdfPoint size = PdfPoint(format.width, format.height);

PdfColor headerColor;
PdfColor oddRowColor;
PdfColor evenRowColor;

Future<pw.Document> generatePage(SavePdfProperties savePdfProperties) async {
  final pw.Document doc =
      pw.Document(title: 'Data Penerbangan', author: 'Fleoscan');

  final PdfImage angkasaPuraImage = PdfImage.file(
    doc.document,
    bytes: (await rootBundle.load('assets/pdf/AP.png')).buffer.asUint8List(),
  );
  final PdfImage airlineImage = PdfImage.file(
    doc.document,
    bytes: (await rootBundle.load('assets/pdf/${savePdfProperties.code}.png'))
        .buffer
        .asUint8List(),
  );

  PdfItemProperties tableColor = new PdfItemProperties();
  headerColor = tableColor.getHeaderColor(savePdfProperties.code);
  oddRowColor = tableColor.getOddRowColor();
  evenRowColor = tableColor.getEvenRowColor();

  final pw.PageTheme pageTheme = await _myPageTheme();

  doc.addPage(pw.Page(
      pageTheme: pageTheme,
      build: (pw.Context context) {
        return pw.Column(children: <pw.Widget>[
          pw.Container(
            child: _fleoHeader(airlineImage, angkasaPuraImage),
          ),
          pw.Container(
            margin: pw.EdgeInsets.symmetric(vertical: 0.15 * PdfPageFormat.cm),
            child: _headerLine(),
          ),
          pw.Container(
            margin: pw.EdgeInsets.symmetric(vertical: 3.0),
            child: _fleoDetails(
              savePdfProperties.origin,
              savePdfProperties.destination,
              savePdfProperties.flightNumber,
              savePdfProperties.cabinClass,
              savePdfProperties.flightDate,
            ),
          ),
          pw.Container(
            margin: pw.EdgeInsets.symmetric(vertical: 3.0),
            child: _fleoTable(savePdfProperties.data),
          ),
        ]);
      }));
  return doc;
}

Future<pw.PageTheme> _myPageTheme() async {
  return pw.PageTheme(
    pageFormat: format.applyMargin(
        left: 2.0 * PdfPageFormat.cm,
        top: 1.25 * PdfPageFormat.cm,
        right: 2.0 * PdfPageFormat.cm,
        bottom: 2.0 * PdfPageFormat.cm),
    theme: pw.ThemeData.withFont(
      base: pw.Font.ttf(await rootBundle.load('fonts/pdf/Roboto-Regular.ttf')),
      bold: pw.Font.ttf(await rootBundle.load('fonts/pdf/Roboto-Bold.ttf')),
    ),
  );
}

pw.Widget _fleoHeader(PdfImage leftImage, PdfImage rightImage) {
  return pw.Container(
      child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: <pw.Widget>[
        pw.Expanded(
          child: pw.SizedBox(
            height: 2.0 * PdfPageFormat.cm,
            child: pw.Image(leftImage),
          ),
        ),
        pw.Expanded(
          child: pw.SizedBox(
            height: 2.0 * PdfPageFormat.cm,
            child: pw.Image(rightImage),
          ),
        ),
      ]));
}

pw.Widget _headerLine() {
  return pw.SizedBox(
    width: format.width,
    height: 0.05 * PdfPageFormat.cm,
    child: pw.DecoratedBox(
      decoration: pw.BoxDecoration(
        color: PdfColors.black,
      ),
    ),
  );
}

pw.Widget _fleoDetails(String origin, String destination, String flightNumber,
    String cabinClass, String flightDate) {
  return pw.Row(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: <pw.Widget>[
      pw.Column(children: <pw.Widget>[
        _fleoDetailsItem('ASAL', origin),
        _fleoDetailsItem('TUJUAN', destination),
        _fleoDetailsItem('FLIGHT', flightNumber),
      ]),
      pw.Column(children: <pw.Widget>[
        _fleoDetailsItem('KELAS', cabinClass),
        _fleoDetailsItem('TANGGAL', flightDate),
      ]),
    ],
  );
}

pw.Widget _fleoDetailsItem(String leftString, String rightString) {
  return pw.Container(
      margin: pw.EdgeInsets.symmetric(vertical: 1.2),
      child: pw.Row(
        children: <pw.Widget>[
          pw.Container(
            width: size.x * 0.5 * 0.23,
            child: pw.Text(leftString),
          ),
          pw.Container(
            width: size.x * 0.5 * 0.05,
            child: pw.Text(':'),
          ),
          pw.Container(
            width: size.x * 0.5 * 0.6,
            child: pw.Text(rightString),
          ),
        ],
      ));
}

pw.Widget _fleoTable(List<FlightData> data) {
  int num = 0;
  const tableHeaders = ['NO', 'NAMA', 'KODE BOOKING', 'SEAT', 'SEQ'];

  return pw.Table.fromTextArray(
    border: pw.TableBorder(
      color: PdfColors.white,
      width: 1.2,
    ),
    headerHeight: 30,
    headerStyle: pw.TextStyle(
      color: PdfColors.black,
      fontSize: 12,
      fontWeight: pw.FontWeight.bold,
    ),
    headerPadding: pw.EdgeInsets.all(0),
    headerAlignment: pw.Alignment.center,
    cellAlignments: {
      0: pw.Alignment.center,
      2: pw.Alignment.center,
      3: pw.Alignment.center,
      4: pw.Alignment.center,
    },
    headers: List<String>.generate(
      tableHeaders.length,
      (col) => tableHeaders[col],
    ),
    cellHeight: 20,
    cellPadding: pw.EdgeInsets.symmetric(horizontal: 10.0),
    cellAlignment: pw.Alignment.centerLeft,
    headerDecoration: pw.BoxDecoration(
      borderRadius: 2,
      color: headerColor,
    ),
    cellStyle: const pw.TextStyle(
      color: PdfColors.black,
      fontSize: 11,
    ),
    columnWidths: {
      0: pw.FractionColumnWidth(1.0 * PdfPageFormat.cm),
      1: pw.FractionColumnWidth(5.5 * PdfPageFormat.cm),
      2: pw.FractionColumnWidth(4.5 * PdfPageFormat.cm),
      3: pw.FractionColumnWidth(2.5 * PdfPageFormat.cm),
      4: pw.FractionColumnWidth(2.5 * PdfPageFormat.cm),
    },
    oddRowDecoration: pw.BoxDecoration(
      color: oddRowColor,
    ),
    rowDecoration: pw.BoxDecoration(
      color: evenRowColor,
    ),
    data: List<List<String>>.generate(
      data.length,
      (row) => List<String>.generate(
        tableHeaders.length,
        (col) {
          if (col == 0) {
            ++num;
            return num.toString();
          }
          return data[row].getIndex(col);
        },
      ),
    ),
  );
}
