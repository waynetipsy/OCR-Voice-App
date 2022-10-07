import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../Utilis/pick_document.dart';
import 'package:pdf_text/pdf_text.dart';

class ReadNote extends StatefulWidget {
  const ReadNote({Key? key}) : super(key: key);

  @override
  State<ReadNote> createState() => _ReadNoteState();
}

class _ReadNoteState extends State<ReadNote> {

  TextEditingController controller = TextEditingController();

   FlutterTts flutterTts = FlutterTts();

   void speak(String? text)async{
    await flutterTts.setLanguage("en-US");
    await flutterTts.setVolume(1.0);

   }

   void stop() async{
    await flutterTts.stop();
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Read Note'),
        actions: [
          IconButton(onPressed: (){},
           icon:const Icon(Icons.delete)
           ),
          IconButton(
            onPressed:() {
              //stop
              stop();
            } ,
            icon: const Icon(Icons.stop)
            ),
           IconButton(
            onPressed: (){
              //start
          if (controller.text.isNotEmpty) {
             speak(controller.text.trim());
          }
            },
             icon: const Icon(Icons.mic)
             )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: TextFormField(
          maxLines: MediaQuery.of(context).size.height.toInt(),
          controller: controller,
          decoration: const InputDecoration(
            border: InputBorder.none,
            label:  Text('Enter text to read...')
            ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.black,
        onPressed: () {
          pickDocument().then((value)async {
            if (value != ''){
              //Get the file and decode using pdf_text
              PDFDoc doc = await PDFDoc.fromPath(value);
              final text = await doc.text;
              controller.text = text;
            }
          });
        },
        label: const Text('pick pdf file')
        ),
    );
  }
}