import 'package:flutter/material.dart';
import 'package:ocr_voice_app/Screens/detailpage.dart';
import 'package:ocr_voice_app/Screens/recongnization_page.dart';
import '../Widgets/note_widget.dart';
import  '../Model/data_model.dart';
import 'package:ocr_voice_app/Model/database.dart';

class SavedText extends StatefulWidget {
   SavedText({Key? key}) : super(key: key);


  @override
  State<SavedText> createState() => _SavedTextState();
}

class _SavedTextState extends State<SavedText> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Save Text',
        style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
          fontSize: 17,
          ),
        ),
      ),
      body:  FutureBuilder<List<Note>?>(
        future: DatabaseHelper.getAllNote(),
        builder: (context, AsyncSnapshot<List<Note>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(),);
          } else if(snapshot.hasError) {
         return Center(child: Text(snapshot.error.toString()));
          } else if (snapshot.hasData) {
            if(snapshot.data != null) {
          return ListView.builder(
            itemBuilder: (context, index) => NoteWidget(
              note: snapshot.data![index],
              onTap: () async{
                 await Navigator.push(context, MaterialPageRoute(
                  builder: (context) => DetailPage(
                    note: snapshot.data![index],
                    ))
                 );
                 setState(() {
                   
                 });
              },
              onLongpress: () async{
              showDialog(
                context: context, 
              builder: (context) {
               return  AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(20.0)
              ),

          title: const Text("Are you sure you want to delete text?"),
          content: const Text("Extracted text 📱"),

          actions: <Widget>[


            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: MaterialButton(
                shape: const StadiumBorder(),
                minWidth: 100,
                color: Colors.blue,
                child: const Text("Yes"),
                onPressed: () async{
                 await DatabaseHelper.deleteNote(
                 snapshot.data![index]
                 ); 
                 Navigator.pop(context);
                setState(() {
                   
                });    
                  }
              ),
            ),

            MaterialButton(
              shape: const StadiumBorder(),
              minWidth: 100,
              color: Colors.red,
              child: const Text("cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

          ],
        );
              } );
              }
              ),
              itemCount: snapshot.data!.length,
             );
            }
            return Center(
              child: Text('No saved text'),
            );
          }
        return SizedBox.shrink();
        },
        
      ),
      );
  }
  
}