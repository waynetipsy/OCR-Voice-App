import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:ocr_voice_app/Screens/readnote.dart';
import '../Styles/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Widgets/labeldesign.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Colors.black,
      ),
      floatingActionButton: 
        SpeedDial(
         animatedIcon: AnimatedIcons.menu_close,
         backgroundColor: Colors.black,
         icon: Icons.home,
         overlayColor: Colors.black,
         overlayOpacity: 0.4,
         spacing: 20,
         spaceBetweenChildren: 12,
         //closeManually: true,
         onOpen: () => showToast('Opened...'),
         onClose: () => showToast("Closed..."),
         children: [
          SpeedDialChild(
            child: const Icon(Icons.read_more_rounded),
            elevation: 30,
            labelWidget: labelDesign(Colors.green, 'Read Note'),
            backgroundColor: Colors.green,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ReadNote()));
            },
          
           ),
            SpeedDialChild(
            child: const Icon(Icons.voice_over_off),
            backgroundColor: Colors.amberAccent,
            onTap: () {
              
            },
            labelWidget: labelDesign(Colors.blue, 'Voice'),
            labelBackgroundColor: Colors.amber,
            
            )
          ],
        )
    );
  }
  Future showToast(String message) async{
  await Fluttertoast.cancel();

  Fluttertoast.showToast(msg: message, fontSize: 18);
  }
    
}