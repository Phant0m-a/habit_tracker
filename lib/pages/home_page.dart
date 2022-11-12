// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:habit_tracker/data/habit_database.dart';
import 'package:habit_tracker/pages/widgets/monthly_summery.dart';
import 'package:habit_tracker/pages/widgets/my_alert_box.dart';
import 'package:habit_tracker/pages/widgets/habit_tile.dart';
import 'package:habit_tracker/pages/widgets/my_fob.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
// list of habits
  // List Habits = [
  //   // [ habits, habitcompleted]
  //   ["Flutter Practice", false],
  //   ["Stroll 1 mile", false],
  //   ["Do Widget of the Day", false]
  // ];

  //instance of habits
  HabitDatabase db = HabitDatabase();
  final _mybox = Hive.box('Habit_Tracker_Database');

  @override
  void initState() {
    // if first time opening the app the create the defualt list,
    if (_mybox.get('CURRENT_HABIT_LIST') == null) {
      db.createDefaultData();
    }

    //else load up the data of the user
    else {
      db.loadData();
    }

    //update our db
    db.updateDatabase();

    super.initState();
  }

//bool to control if habit was completed
  // bool habitCompleted = false;

// checkbox was tapped
  void checkboxTapped(bool? value, int index) {
    setState(() {
      db.Habits[index][1] = value!;
    });
    //update our db
    db.updateDatabase();
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
            hint: 'Enter new habit',
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
        db.Habits.add([_newHabitController.text, false]);
        print(_newHabitController.text);
      }
    });
    _newHabitController.clear();
    Navigator.of(context).pop();

    //update our db
    db.updateDatabase();
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
            onSave: () => saveExistingHabit(index),
            onCancel: cancelDialog,
            controller: _newHabitController,
            hint: db.Habits[index][0]
          );
        }));
  }

  // sve existing habit
  void saveExistingHabit(int index) {
    setState(() {
      db.Habits[index][0] = _newHabitController.text;
    });
    _newHabitController.clear();
    Navigator.of(context).pop();
    //update our db
    db.updateDatabase();
  }

  deleteHabit(int index) {
    setState(() {
      db.Habits.removeAt(index);
    });
    //update our db
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appbar
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Habit tracker',
          style: TextStyle(
            color: Colors.green[300],
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.menu),
          color: Colors.black,
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            color: Colors.black,
            onPressed: () {},
          ),
        ],
      ),

      backgroundColor: Colors.grey[300],
      floatingActionButton: MyFob(onPressed: createNewHabit),

      body: ListView(children: [
        //monthly heatmap
        MonthlySummary(
          startDate: _mybox.get('START_DATE'),
          datasets: db.heatMapDataset,
        ),

        // habits
        ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: db.Habits.length,
            itemBuilder: (context, index) {
              return HabitTile(
                settingsTapped: (context) => openHabitSettings(index),
                deleteTapped: (context) => deleteHabit(index),
                habitName: db.Habits[index][0],
                isCompleted: db.Habits[index][1],
                onChanged: (value) => checkboxTapped(value, index),
              );
            })
      ]),
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
