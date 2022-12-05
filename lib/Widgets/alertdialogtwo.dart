import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ocr_voice_app/Utilis/image_crooper_page.dart';

import '../Screens/recongnization_page.dart';
import '../Utilis/image_picker_class.dart';
   

class AlertDialogTwo extends StatefulWidget {
  const AlertDialogTwo({super.key});

  @override
  State<AlertDialogTwo> createState() => _AlertDialogTwoState();
}

class _AlertDialogTwoState extends State<AlertDialogTwo> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(20.0)
              ),

          title: const Text("Do you want to access gallery?"),
          content: const Text("Phone Gallery 🖼️"),

          actions: <Widget>[


            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: MaterialButton(
                shape: const StadiumBorder(),
                minWidth: 100,
                color: Colors.blue,
                child: const Text("Yes"),
                onPressed: () {
                    
                       pickImage(source: ImageSource.gallery).then((value) {
                          if(value != '') {
                        imageCropperView(value, context).then((value) => {
                           if (value != '') {
                            Navigator.pushReplacement(
                            context,
                            CupertinoPageRoute(
                            builder: (_) => RecognizePage(
                             
                             path: value,
                           
                           ),
                      ),
                            )
                           }

                        });
                           
                  }
                   }
                  );               
                
                 },

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

