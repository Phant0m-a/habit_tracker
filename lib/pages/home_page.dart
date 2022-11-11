// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:habit_tracker/pages/widgets/my_alert_box.dart';
import 'package:habit_tracker/pages/widgets/habit_tile.dart';
import 'package:habit_tracker/pages/widgets/my_fob.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
// list of habits
  List Habits = [
    // [ habits, habitcompleted]
    ["Flutter Practice", false],
    ["Stroll 1 mile", false],
    ["Do Widget of the Day", false]
  ];

//bool to control if habit was completed
  // bool habitCompleted = false;

// checkbox was tapped
  void checkboxTapped(bool? value, int index) {
    setState(() {
      Habits[index][1] = value!;
    });
  }

  //new-habit -text-controller
  final _newHabitController = TextEditingController();

  //show dialog box after pressing FOB
  void createNewHabit() {
    //show alert dialog
    showDialog(
        context: context,
        builder: ((context) {
          return MyAlertBox(
            hintText: 'Enter new habit',
            onSave: saveNewHabit,
            onCancel: cancelDialog,
            controller: _newHabitController,
          );
        }));
  }

  //save new habit
  void saveNewHabit() {
    setState(() {
      if (_newHabitController.text.isNotEmpty) {
        //save to list
        Habits.add([_newHabitController.text, false]);
      }
    });
    _newHabitController.clear();
    Navigator.of(context).pop();
  }

  //save new habit
  void cancelDialog() {
    _newHabitController.clear();
    Navigator.of(context).pop();
  }

// open habit settings to edit
  void openHabitSettings(int index) {
    showDialog(
        context: context,
        builder: ((context) {
          return MyAlertBox(
            hintText: Habits[index][0].toString(),
            onSave: () => saveExistingHabit(index),
            onCancel: cancelDialog,
            controller: _newHabitController,
          );
        }));
  }

  // sve existing habit
  void saveExistingHabit(int index) {
    setState(() {
      Habits[index][0] = _newHabitController.text;
    });
    _newHabitController.clear();
    Navigator.of(context).pop();
  }

  deleteHabit(int index) {
    setState(() {
      Habits.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      floatingActionButton: MyFob(onPressed: createNewHabit),

      body: ListView.builder(
          itemCount: Habits.length,
          itemBuilder: (context, index) {
            return HabitTile(
              settingsTapped: (context) => openHabitSettings(index),
              deleteTapped: (context) => deleteHabit(index),
              habitName: Habits[index][0],
              isCompleted: Habits[index][1],
              onChanged: (value) => checkboxTapped(value, index),
            );
          }),
      // ignore: prefer_const_literals_to_create_immutables
      // body: ListView(
      //   children: [
      //   HabitTile(
      //     habitName: 'Flutter Practice',
      //     isCompleted: habitCompleted,
      //     onChanged: (value) => checkboxTapped(value),
      //   ),
      //   HabitTile(
      //     habitName: 'Stroll one mile',
      //     isCompleted: true,
      //   ),
      //   HabitTile(
      //     habitName: 'Pray 2 time',
      //     isCompleted: true,
      //   ),
      //   HabitTile(
      //     habitName: 'Study',
      //     isCompleted: true,
      //   ),
      // ]),
    );
  }
}
