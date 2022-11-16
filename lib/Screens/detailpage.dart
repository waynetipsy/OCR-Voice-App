import 'package:flutter/material.dart';

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
        title: Text('Detail Page'),
      ),
     body: SafeArea(
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration.collapsed(
                hintText:'Title'
                ),
                style: TextStyle(fontSize: 30.0),
                initialValue: widget.note
            )
          ],
        )
        )
      ),
    );
    
  }
}