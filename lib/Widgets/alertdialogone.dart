import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Screens/recongnization_page.dart';
import '../Utilis/image_picker_class.dart';
   

class AlertDialogOne extends StatefulWidget {
  const AlertDialogOne({super.key});

  @override
  State<AlertDialogOne> createState() => _AlertDialogOneState();
}

class _AlertDialogOneState extends State<AlertDialogOne> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      
          shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(20.0)
              ),

          title: const Text("Do you want to access camera?"),
          content: const Text("Phone Camera 📷"),

          actions: <Widget>[


            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: MaterialButton(
                shape: const StadiumBorder(),
                minWidth: 100,
                color: Colors.blue,
                child: const Text("Yes"),
                onPressed: () {
                    
                       pickImage(source: ImageSource.camera).then((value) {
                          if(value != '') {
                        
                           Navigator.pushReplacement(
                            context,
                            CupertinoPageRoute(
                            builder: (_) => RecognizePage(
                             path: value,
                           
                           ),
                      ),
                    );
                  }
                       });                },
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
      }
  }

