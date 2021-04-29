import 'package:flutter/material.dart';
import 'package:native_pdf_renderer/native_pdf_renderer.dart';
import 'package:native_pdf_view/native_pdf_view.dart';

class TermsOfUse extends StatefulWidget {
  @override
  _TermsOfUseState createState() => _TermsOfUseState();
}

class _TermsOfUseState extends State<TermsOfUse> {
  final paragraphStyle = TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 14.0,
  );
  
  final pdfController = PdfController(document: PdfDocument.openAsset('assets/toc.pdf'),);

  Widget pdfView() => PdfView(controller: pdfController, scrollDirection: Axis.vertical,);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms Of Use'),
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
