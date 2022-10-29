import 'dart:developer';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:ocr_voice_app/Screens/homepage.dart';

class RecognizePage extends StatefulWidget {
  final String? path;
  const RecognizePage({Key? key, this.path}) : super(key: key);

  @override
  State<RecognizePage> createState() => _RecognizePageState();
}

class _RecognizePageState extends State<RecognizePage> {
  bool _isBusy = false;

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    final InputImage inputImage = InputImage.fromFilePath(widget.path!);

    processImage(inputImage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Colors.grey[400],
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
                 Navigator.push(
                   context,
               CupertinoPageRoute(
               builder: (_) => const HomePage(
                           ),
                      ),
                    );
            },
            icon: const Icon(Icons.arrow_back),
          ),
          actions: [
         IconButton(
          onPressed: () {
          FlutterClipboard.copy(controller.text);
          Fluttertoast.showToast(msg: 'Text copied');
         },
         icon: const Icon(
          Icons.content_copy,
          color: Colors.white,
             ),
             iconSize: 25,
            ),

          IconButton(
            onPressed: () {
              
            },
          icon: Icon(Icons.save,
        
             color: Colors.blue,
           ),
           iconSize: 25,
          ),
          ],
          backgroundColor: Colors.black,
          title: const Text("Extracted Text",
           style: TextStyle(color: Colors.red,
           fontSize: 17
        
           ),
            ),
          ),
        body: _isBusy == true
            ?  Center(
                child: CircularProgressIndicator(
                  strokeWidth: 6,
                  color: Theme.of(context).primaryColor,
                ),
              )
            : Container(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  maxLines: MediaQuery.of(context).size.height.toInt(),
                  controller: controller,
                  decoration:
                      const InputDecoration(hintText: "Text goes here..."),
                ),
              ));
  }

  void processImage(InputImage image) async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

    setState(() {
      _isBusy = true;
    });

    log(image.filePath!);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(image);

    controller.text = recognizedText.text;

    ///End busy state
    setState(() {
      _isBusy = false;
    });
  }
}