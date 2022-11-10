// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class EnterNewHabitBox extends StatelessWidget {
  final controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const EnterNewHabitBox(
      {super.key,
      this.controller,
      required this.onSave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: TextField(
        controller: controller,
        style: TextStyle(color: Colors.grey[700]),
        textAlign: TextAlign.center,
        cursorColor: Colors.orange,
        decoration: InputDecoration(
          hintText: 'Enter new habit',
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orange),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orange),
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
          color: Colors.orange[300],
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
