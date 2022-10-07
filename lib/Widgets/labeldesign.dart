import 'package:flutter/material.dart';
 
 Widget labelDesign(Color color, String text) {
      return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 6),
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: color, blurRadius: 2, spreadRadius: 2)],
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 15),
      ),
    );
  }