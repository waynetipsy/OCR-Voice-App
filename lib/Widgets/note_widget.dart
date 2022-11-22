import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../Model/data_model.dart';
import '../Screens/recongnization_page.dart';

class NoteWidget extends StatefulWidget {
  final Note note;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  const NoteWidget({
    super.key,
    required this.note,
    required this.onTap,
     required this.onLongPress,
  });

  @override
  State<NoteWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {


  List<Color> colors = [
  
    Colors.white
  ];

  final _random = Random();

  int index = 0;

  void changeIndex() {
    setState(() => index = _random.nextInt(3));
  }

  //Color[index]


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: widget.onLongPress,
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 6),
        child: Card(
        
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.note.title,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text( '',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold
                   ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  child: Divider(
                    color: Colors.black,
                    thickness: 1,
                  ),
                ),
                Text(widget.note.description,
                    style: const TextStyle(
                      
                        fontSize: 15, 
                        fontWeight: FontWeight.bold))
              ],
            ),
          ),
        ),
      ),
    );
  }
}