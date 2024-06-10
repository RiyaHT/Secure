import 'dart:io';

import 'package:flutter/material.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfPreviewWidget extends StatefulWidget {
  @override
  _PdfPreviewWidgetState createState() => _PdfPreviewWidgetState();
}

class _PdfPreviewWidgetState extends State<PdfPreviewWidget> {
  File? _pdfFile;

  Future<void> _pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg'],
    );

    if (result != null) {
      setState(() {
        _pdfFile = File(result.files.single.path!);
        print(_pdfFile);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Preview'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _pickPDF,
              child: Text('Pick PDF'),
            ),
            SizedBox(height: 20),
            _pdfFile != null
                ? Expanded(
                    child: PDFView(
                      filePath: _pdfFile!.path,
                      enableSwipe: true,
                      swipeHorizontal: true,
                      autoSpacing: false,
                      pageSnap: true,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
