// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:habit_tracker/pages/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  //initalize hive
  await Hive.initFlutter();
  //open a box
  await Hive.openBox('Habit_Tracker_Database');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      
      home: HomePage(),
      theme: ThemeData(
          primarySwatch: Colors.green,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.green[500],
              splashColor: Colors.green,
              foregroundColor: Colors.green[900])),
    );
  }
}
