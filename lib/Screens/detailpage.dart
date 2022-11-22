import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ocr_voice_app/Model/data_model.dart';

import '../Model/database.dart';

class DetailPage extends StatefulWidget {
  final note;
  const DetailPage({super.key, this.note});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Detail Page',
        style: TextStyle(
          color: Colors.red,
          fontSize: 17
          ),
        ),
        actions: [
          IconButton(
            onPressed: (){
         FlutterClipboard.copy(widget.note.description);
         Fluttertoast.showToast(msg: 'Text copied');
            }, 
          icon: Icon(
            Icons.content_copy,
            
            ),
            iconSize: 24,
          ),
          IconButton(
            onPressed: () {
            
            Fluttertoast.showToast(msg: 'Text deleted');
            Navigator.pop(context);
            },
            icon: Icon(Icons.delete,
            color: Colors.red,
              ),
              iconSize: 24,
            )
        ],
      ),
     body: SingleChildScrollView(
       child: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text("${widget.note.title}",
             style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold
             ),
             ),
             SizedBox(height: 20,),
            Text("${widget.note.description}",
              style: TextStyle(
                fontSize: 15.0,

                ),
            ),
          ],
        ),
       ),
     )
    );
    
  }
}