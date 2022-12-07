// ignore_for_file: unused_label

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
  final String? path;

  const RecognizePage({ this.path, Key? key,}) : super(key: key);
  

  @override
  State<RecognizePage> createState() => _RecognizePageState();

}

class _RecognizePageState extends State<RecognizePage> {
  bool _isBusy = false;
  DBHelper? dbHelper;
  late Future<List<NoteModel>> dataList;

   TextEditingController controller = TextEditingController();
  TextEditingController topic = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  

  @override
  void initState() {
    super.initState();
    final InputImage inputImage = InputImage.fromFilePath(widget.path!);
    processImage(inputImage);
    dbHelper = DBHelper();
    loadData();
     }   
 
 loadData() async{
   dataList = dbHelper!.getDataList();
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
               builder: (_) =>  HomePage(
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
             iconSize: 24,
            ),

        IconButton(
          onPressed: ()async {
          if(_formKey.currentState!.validate()) {
           final title = topic.value.text;
                   final description = controller.value.text;

                 if(title.isEmpty || description.isEmpty){
                    return;
                     }

           dbHelper!.insert(NoteModel(
            title: topic.text,
            desc: controller.text,
            dateandtime: DateFormat('yMd')
            .add_jm()
            .format(DateTime.now())
            .toString()
           ));     
         
           Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => SavedText()),
                  );
                  Fluttertoast.showToast(msg: 'Text saved');
          }
        },
        icon: Icon(Icons.save,
        color: Colors.blue,
        
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
            :  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Form(
                   key: _formKey,
                  child:TextFormField(
                  
                  validator: (value) {
                     if (value == null || value.isEmpty) {
                       return 'Please enter title';
                       }
                         return null;
                               },
                      //onSaved: (input) => controller.text = input!,
                   // initialValue: controller.text, 
                 // key: UniqueKey(),
                  keyboardType: TextInputType.text,
                  controller: topic,
                  //enabled: widget.deleteNote == null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      
                    ),
                    labelText: 'Enter title',
                    hintText: 'Your title',
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 0.75,
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  maxLines: 1,
                ),
              ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: TextFormField(
                  key: UniqueKey(),
                
                  keyboardType: TextInputType.text,
                  controller: controller,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: 
                      BorderSide(color: Colors.white)
                    ),
                    labelText: 'Extracted text',
                    hintText: 'Your body',
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 0.75,
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  maxLines: 22,
                ),
              ),
            ]
          ))),
          
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