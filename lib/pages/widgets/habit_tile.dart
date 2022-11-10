// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class HabitTile extends StatelessWidget {
  final String habitName;
  final bool isCompleted;
  final Function(bool?)? onChanged;
  const HabitTile(
      {super.key,
      required this.habitName,
      required this.isCompleted,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Colors.grey[100]),
        child: Row(
          children: [
            //checkbox
            Checkbox(
                value: isCompleted,
                onChanged: onChanged),
            // habit naem
            Text(habitName),
          ],
        ),
      ),
    );
  }
}
