import 'dart:developer';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:intl/intl.dart';
import 'package:ocr_voice_app/Model/data_model.dart';
import '../Model/database.dart';
import 'package:ocr_voice_app/Screens/homepage.dart';
import 'package:ocr_voice_app/Screens/savedtext.dart';

class RecognizePage extends StatefulWidget {
  final Note? note;
  final String? path;
  const RecognizePage({ this.path, this.note, Key? key}) : super(key: key);


  @override
  State<RecognizePage> createState() => _RecognizePageState();

}

class _RecognizePageState extends State<RecognizePage> {
  bool _isBusy = false;

   TextEditingController controller = TextEditingController();
  TextEditingController topic = TextEditingController();
  

  @override
  void initState() {
    super.initState();
    final InputImage inputImage = InputImage.fromFilePath(widget.path!);
    processImage(inputImage);

     }

     

 getDetails() {
   if(widget.note != null) {
      controller.text = widget.note!.title;
      topic.text = widget.note!.description;
      }
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

          ],
          backgroundColor: Colors.black,
          title: Text(  
           "Extracted Text",
           style: TextStyle(color: Colors.red,
           fontSize: 17)
            ),
          ),
        body: _isBusy == true
            ?  Center(
                child: CircularProgressIndicator(
                  strokeWidth: 6,
                  color: Theme.of(context).primaryColor,
                ),
              )
            : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: TextFormField(
                  
                  //validator: (input) => 
                 //input!.trim().isEmpty ? 'Please enter title': null,
                   //   onSaved: (input) => controller.text = input!,
                  //   initialValue: controller.text,
                    
                 // key: UniqueKey(),
                  keyboardType: TextInputType.text,
                  controller: topic,
                  //enabled: widget.deleteNote == null,
                  decoration: InputDecoration(
                    labelText: 'Enter title',
                    hintText: 'Your title',
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 0.75,
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  maxLines: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: TextFormField(
                  key: UniqueKey(),
                
                  keyboardType: TextInputType.text,
                  controller: controller,
                  decoration: InputDecoration(
                    labelText: 'Extracted text',
                    hintText: 'Your body',
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 0.75,
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  maxLines: 22,
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor,),
                  onPressed: () async {
                   
                   final title = topic.value.text;
                   final description = controller.value.text;
                  // DateTime now = DateTime.now();
                    //final DateFormat formattedDate = DateFormat('yyyy-MM-dd – kk:mm: a');
                  // final String formatted = formattedDate.format(now);

                 if(title.isEmpty || description.isEmpty){
                    return;
                     }
            
             Note model = 
             Note(id: widget.note?.id, title: title, description: description);
               if(widget.note == null) {
                await DatabaseHelper.addNote(model);
               
               }
                 Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => SavedText()),
                  );
                  },
                  child: Text('save'
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
         
              );
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