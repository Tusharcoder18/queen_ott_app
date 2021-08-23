import 'package:flutter/material.dart';
import 'package:native_pdf_view/native_pdf_view.dart';

/// This page is for the Terms of Use
/// native_pdf_view is used here
/// the pdf is stored as toc.pdf in assets folder of the project
class LegalFilePage extends StatefulWidget {
  @override
  _LegalFilePageState createState() => _LegalFilePageState();
}

class _LegalFilePageState extends State<LegalFilePage> {
  final paragraphStyle = TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 14.0,
  );

  final pdfController = PdfController(
    document: PdfDocument.openAsset('assets/tos.pdf'), // Add the legal file here.
  );

  Widget pdfView() => PdfView(
        controller: pdfController,
        scrollDirection: Axis.vertical,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Legal File to be added'),
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: pdfView(),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    pdfController.dispose();
    super.dispose();
  }
}
