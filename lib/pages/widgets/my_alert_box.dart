// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MyAlertBox extends StatelessWidget {
  final controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final String hint;

  const MyAlertBox(
      {super.key,
      this.controller,
      required this.onSave,
      required this.onCancel,
      required this.hint});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: TextField(
        controller: controller,
        // style: TextStyle(color: Colors.grey[700]),
        style: TextStyle(color: Colors.grey[700]),
        textAlign: TextAlign.center,
        // cursorColor: Colors.orange,
        cursorColor: Colors.green,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.green[300]),
          enabledBorder: OutlineInputBorder(
            // borderSide: BorderSide(color: Colors.orange),
            borderSide: BorderSide(color: Colors.green),
          ),
          focusedBorder: OutlineInputBorder(
            // borderSide: BorderSide(color: Colors.orange),
            borderSide: BorderSide(color: Colors.green),
          ),
        ),
      ),
      backgroundColor: Colors.grey[100],
      actions: [
        //cancel
        MaterialButton(
          color: Colors.grey[900],
          onPressed: onCancel,
          child: Text(
            'Cancel',
            style: TextStyle(color: Colors.white),
          ),
        ),

        //save
        MaterialButton(
          // color: Colors.grey[900],
          // color: Colors.orange[300],
          color: Colors.green[300],
          onPressed: onSave,
          child: Text(
            'Save',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
