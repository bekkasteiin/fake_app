import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hse/core/model/sheet/SettlenetSheet.dart';
import 'package:native_pdf_view/native_pdf_view.dart';

class PaymentPdfWebView extends StatefulWidget {
  String fileId;
  SettlenetSheet e;
  Uint8List bytes;

  PaymentPdfWebView(this.fileId, this.e, this.bytes);

  @override
  _PaymentPdfWebViewState createState() => _PaymentPdfWebViewState();
}

class _PaymentPdfWebViewState extends State<PaymentPdfWebView> {
  int _actualPageNumber = 1, _allPagesCount = 0;
  bool isSampleDoc = true;
  PdfController _pdfController;

  @override
  void initState() {
    _pdfController = PdfController(
      document: PdfDocument.openData(widget.bytes),
    );
    super.initState();
  }

  @override
  void dispose() {
    _pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.navigate_before),
              onPressed: () {
                _pdfController.previousPage(
                  curve: Curves.ease,
                  duration: Duration(milliseconds: 100),
                );
              },
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                '$_actualPageNumber/$_allPagesCount',
                style: TextStyle(fontSize: 22),
              ),
            ),
            IconButton(
              icon: Icon(Icons.navigate_next),
              onPressed: () {
                _pdfController.nextPage(
                  curve: Curves.ease,
                  duration: Duration(milliseconds: 100),
                );
              },
            ),
          ],
        ),
        body: PdfView(
          documentLoader: Center(child: CircularProgressIndicator()),
          pageLoader: Center(child: CircularProgressIndicator()),
          controller: _pdfController,
          onDocumentLoaded: (document) {
            setState(() {
              _actualPageNumber = 1;
              _allPagesCount = document.pagesCount;
            });
          },
          onPageChanged: (page) {
            setState(() {
              _actualPageNumber = page;
            });
          },
        ),
      );
}
