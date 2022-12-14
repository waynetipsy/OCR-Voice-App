// ignore_for_file: unused_local_variable

import 'dart:io';
import 'dart:typed_data';

import 'package:bulleted_list/bulleted_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfMarker extends StatefulWidget {
  const PdfMarker({super.key});

  @override
  State<PdfMarker> createState() => _PdfMarkerState();
}

class _PdfMarkerState extends State<PdfMarker> {

  File? file;
  ImagePicker image = ImagePicker();
  getImage() async {
    var img = await image.pickImage(source: ImageSource.gallery);
  
  setState(() {
      file = File(img!.path);
    });
  }

  getImagecam() async {
    var img = await image.pickImage(source: ImageSource.camera);

    setState(() {
      file = File(img!.path);
    });
  }

   Future<Uint8List> _generatePdf(PdfPageFormat format, file) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = await PdfGoogleFonts.nunitoExtraLight();
    
    final showimage = pw.MemoryImage(file.readAsBytesSync());

    pdf.addPage(
      pw.Page(
      
        pageFormat: format,
        build: (context) {
          return pw.Center(
            child: pw.Image(showimage, fit: pw.BoxFit.contain),
            
          );
        },
        
      ),
    );

    return pdf.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        appBar: AppBar(
          backgroundColor: Colors.black,
          title:  Text("Pdf Creator",
          style: GoogleFonts.lato(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 17
            ),
          ),
          actions: [
            IconButton(
              onPressed: getImage,
              icon: const Icon(
                Icons.image,
                color: Colors.white,
                size: 25,
                ),
            ),
            IconButton(
              onPressed: getImagecam,
              icon: const Icon(Icons.camera,
              size: 25,
              color: Colors.blue,
              ),
            ),
          ],
        ),
        body: file == null
            ? ExpansionTile(
              title: Text('How to create PDF file'),
              children: [
                Container(
                  color: Colors.black,
                  height: 200,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        BulletedList(
                          bulletColor: Colors.blue,
                          listItems: [
                            'Convert your image to PDF file.',
                            'Use first icon on app bar for gallery.',
                            'Use second icon on app bar for camera.',
                            'Download PDF file, print or share via socials.'
                          ]
                        
                          )
                      ],
                    )
                    ),
                )
              ],
              )
            : PdfPreview(
                build: (format) => _generatePdf(format, file),
              ),
    );
  }
}
