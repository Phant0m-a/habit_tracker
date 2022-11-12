// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:habit_tracker/main.dart';

class HabitTile extends StatelessWidget {
  final String habitName;
  final bool isCompleted;
  final Function(BuildContext)? settingsTapped;
  final Function(BuildContext)? deleteTapped;
  final Function(bool?)? onChanged;
  const HabitTile(
      {super.key,
      required this.settingsTapped,
      required this.deleteTapped,
      required this.habitName,
      required this.isCompleted,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            //edit
            SlidableAction(
              borderRadius: BorderRadius.circular(12),
              onPressed: settingsTapped,
              backgroundColor: Colors.green.shade800,
              icon: Icons.edit,
            ),

            //delete
            SlidableAction(
              borderRadius: BorderRadius.circular(12),
              onPressed: deleteTapped,
              backgroundColor: Colors.redAccent.shade400,
              icon: Icons.delete,
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            // color: Colors.grey[100],
            color: isCompleted == true ? Colors.green[400] : Colors.grey[100],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //checkbox
                    Checkbox(value: isCompleted, onChanged: onChanged),
                    // habit name

                    Container(
                      width: 200,
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        habitName,
                        style: TextStyle(
                          color:
                              isCompleted == true ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //icon right
              Container(
                padding: EdgeInsets.only(left: 5),
                child: Icon(
                  Icons.arrow_back,
                  color: isCompleted == true ? Colors.white : Colors.grey[400],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
