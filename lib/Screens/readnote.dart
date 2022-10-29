import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../provider/read.provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
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


  @override
  Widget build(BuildContext context) {
    final speak = Provider.of<SpeakProvider>(context);
    return Scaffold(
      appBar: AppBar(
        
        elevation: 0,
        backgroundColor: Colors.black,
        title: const Text('Read Note',
           style: TextStyle(
            color: Colors.red,
            fontSize: 17,
            ),
        ),
        actions: [
          IconButton(
            iconSize: 2,
            color: Colors.red,
            onPressed: (){
            controller.clear();
            
          },
           icon:const Icon(CupertinoIcons.delete)
           ),
          IconButton(
            iconSize: 25,
            color: Colors.white,
            onPressed:() {
              speak.stop();
             //Provider.of<SpeakModel>(context).stop();
            } ,
            icon: const Icon(CupertinoIcons.stop)
            ),
           IconButton(
            color: Colors.blue,
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  speak.speak(text: controller.text.trim(),
                  );
                }
                Fluttertoast.showToast(msg: 'playing text');
              },
              icon: const Icon(
                CupertinoIcons.mic,
                size: 25,
              )
              ),
        ],
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
          decoration: const InputDecoration(
            border: InputBorder.none,
            label:  Text('Enter text to read...')
            ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        
        backgroundColor: Theme.of(context).primaryColor,
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
            } 
               
               );  
          } else {
            
         return Fluttertoast.showToast(msg: 'Invalid Pdf file');
          
          }
          });
        },
        label: const Text('pick pdf file',
        style: TextStyle(
          color: Colors.red
          ),
          )
        ),
    );

  }
}