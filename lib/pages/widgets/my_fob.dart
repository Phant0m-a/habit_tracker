import 'package:flutter/material.dart';

class MyFob extends StatelessWidget {
  final Function()? onPressed;
  const MyFob({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: Icon(Icons.add),
    );
  }
}
