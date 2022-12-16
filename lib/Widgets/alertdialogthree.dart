import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';


class AlertDialogThree extends StatefulWidget {
  const AlertDialogThree({super.key});

  @override
  State<AlertDialogThree> createState() => _AlertDialogThreeState();
}

class _AlertDialogThreeState extends State<AlertDialogThree> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(20.0)
              ),

          title:  Text("Do you want to close this App?",
          style: GoogleFonts.lato(fontSize: 22)
          ),
          content:  Text("Text Genie📱",
          style: GoogleFonts.lato(fontSize: 14),
          ),

          actions: <Widget>[


            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: MaterialButton(
                shape: const StadiumBorder(),
                minWidth: 100,
                color: Colors.blue,
                child: const Text("Yes"),
                onPressed: () {
                     SystemNavigator.pop();    
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
      }
  }

