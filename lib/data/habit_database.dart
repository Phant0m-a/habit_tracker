// reference our box
import 'package:hive_flutter/hive_flutter.dart';

final _myBox = Hive.box('Habit_Tracker_Database');

class HabitDatabase {
  List Habits = [];

  //default data for first timer
  void createDefaultData() {
    Habits = [
      // [ habits, habitcompleted]
      ["Flutter Practice", false],
      ["Stroll 1 mile", false],
      ["Drink Water", false],
      ["Do Widget of the Day", false],
    ];
  }

  //load data from the db if already exists
  void loadData() {}

  // update the data
  void updateDatabase() {}
}


// if user is opening the app for the first time 
 // show him default data

 //if not 
  //then load his already written data from db

// update user data


// user can basically do 4 things in this app

//1.check off any completed habit
//2.edit any habit
//3.delete habit
//4.add new habit
