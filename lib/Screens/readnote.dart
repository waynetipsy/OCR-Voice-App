import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Utilis/pick_document.dart';
import 'package:pdf_text/pdf_text.dart';

class ReadNote extends StatefulWidget {
  const ReadNote({Key? key}) : super(key: key);

  @override
  State<ReadNote> createState() => _ReadNoteState();
}

class _ReadNoteState extends State<ReadNote> {
   bool _isBusy = false;

  TextEditingController controller = TextEditingController();

   FlutterTts tts = FlutterTts();

   Future speak({String? text}) async{
    await tts.setLanguage("en-US");
    await tts.setSpeechRate(0.5);
    await tts.setPitch(1);

    try {
      await tts.speak(text!);
    } catch (e) {
      debugPrint(e.toString()); 
    }
   }

   void stop() async{
    await tts.stop();
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        
        elevation: 0,
        backgroundColor: Colors.black,
        title: const Text('Read Note',
           style: TextStyle(color: Colors.red),
        ),
        actions: [
          IconButton(
            iconSize: 30,
            color: Colors.red,
            onPressed: (){
            controller.clear();
            
          },
           icon:const Icon(Icons.delete)
           ),
          IconButton(
            iconSize: 30,
            color: Colors.white,
            onPressed:() {
              //stop
              stop();
            } ,
            icon: const Icon(Icons.stop)
            ),
           IconButton(
            color: Colors.blue,
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  speak(text: controller.text.trim(),
                  );
                }
                Fluttertoast.showToast(msg: 'playing text');
              },
              icon: const Icon(
                Icons.mic,
                size: 30,
              )
              ),
        ],
      ),
      body: _isBusy == true
         ? const Center(
          child: CircularProgressIndicator(
            strokeWidth: 6,
            color: Colors.black,
          ),
        )
      
     : Container(
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
          pickDocument().then((value) async {
            debugPrint(value);

          setState(() {
           _isBusy = true;
            });
  
            if (value != '') {
              //Get the file and decode using pdf_text
              PDFDoc doc = await PDFDoc.fromPath(value);
            
             final text = await doc.text;

              controller.text = text;

               setState(() {
              _isBusy = false;
               });  
            }
          });
        },
        label: const Text('pick pdf file')
        ),
    );

  }
}