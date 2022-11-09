// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class HabitTile extends StatelessWidget {
  const HabitTile({super.key});

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
            Checkbox(value: true, onChanged: ((value) {})),
            // habit naem
            Text('Flutter hour'),
          ],
        ),
      ),
    );
  }
}
