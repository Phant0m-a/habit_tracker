// reference our box
import 'package:habit_tracker/dateTime/date_time.dart';
import 'package:hive_flutter/hive_flutter.dart';

final _myBox = Hive.box('Habit_Tracker_Database');

class HabitDatabase {
  List Habits = [];
  Map<DateTime, int> heatMapDataset = {};

  //default data for first timer
  void createDefaultData() {
    Habits = [
      // [ habits, habitcompleted]
      ["Welcome to Habit Tracker!", false],
      ["Press + to add habit", false],
      ["slide habit tile from right to left to open options", false],
      ["Edit or delete your hobby", false],
      ["Enjoy!", false],
    ];

    _myBox.put('START_DATE', todaysDateFormatted());
  }

  //load data from the db if already exists
  void loadData() {
    // if it's new day, get habit list from database
    if (_myBox.get(todaysDateFormatted()) == null) {
      Habits = _myBox.get('CURRENT_HABIT_LIST');
      // set all habit completed t0 false since its a new day!
      for (var i = 0; i < Habits.length; i++) {
        Habits[i][1] = false;
      }
    }

    // if its not a new day, load todays list
    else {
      Habits = _myBox.get(todaysDateFormatted());
    }
  }

  // update the data
  void updateDatabase() {
    //update todays entry
    _myBox.put(todaysDateFormatted(), Habits);

    // update universal habit list in case its changed (new habit, edit habit, delete habit):cases
    _myBox.put('CURRENT_HABIT_LIST', Habits);

    // calculate habit complete percentage for each day!
    calculateHabitPercentages();

    //load headt map
    loadHeatMap();
  }

  void loadHeatMap() {
    DateTime startDate = createDateTimeObject(_myBox.get('START_DATE'));

    //count the number of days to load
    int daysInBetween = DateTime.now().difference(startDate).inDays;

    //
    for (var i = 0; i < daysInBetween + 1; i++) {
      String yyyymmdd =
          convertDateTimeToString(startDate.add(Duration(days: i)));

      double strengthAsPercent =
          double.parse(_myBox.get('PERCENTAGE_SUMMARY_$yyyymmdd') ?? '0.0');

      //split the datetime up like below to avoid worrying about year hour day

      //year get
      int year = startDate.add(Duration(days: i)).year;

      //month get
      int month = startDate.add(Duration(days: i)).month;

      //day get
      int day = startDate.add(Duration(days: i)).day;

      final percentForEachDay = <DateTime, int>{
        DateTime(year, month, day): (10 * strengthAsPercent).toInt(),
      };

      heatMapDataset.addEntries(percentForEachDay.entries);
      print(heatMapDataset);
    }
  }

  void calculateHabitPercentages() {
    int countCompleted = 0;
    for (var i = 0; i < Habits.length; i++) {
      if (Habits[i][1] == true) {
        countCompleted++;
      }
    }
    String percentage = Habits.isEmpty
        ? '0.0'
        : (countCompleted / Habits.length).toStringAsFixed(1);

    // put in summery PERCENTAGE_SUMMARY_DATEYYYYMMDD
    //more count more dark color!!
    _myBox.put('PERCENTAGE_SUMMARY_${todaysDateFormatted()}', percentage);
  }
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
