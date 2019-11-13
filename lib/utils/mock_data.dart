import 'package:flutter/material.dart';
import 'package:time_budget/models/category.dart';
import 'package:time_budget/models/event.dart';

class MockData {
  static final MockData _instance = MockData._internal();

  factory MockData() {
    return _instance;
  }

  MockData._internal();

  List<Category> getCategoriesForDay() {
    return [
      Category(
        id: 0,
        color: Colors.pink,
        name: 'Exercise',
        amountOfTime: 6 * 60 * 60,
        events: [
          Event(
            id: 0,
            name: 'Walking',
            start: DateTime.now().subtract(Duration(hours: 5)),
            end: DateTime.now().add(
              Duration(hours: 1),
            ),
          ),
        ],
      ),
      Category(
        id: 0,
        color: Colors.blue,
        name: 'Recreation',
        amountOfTime: 6 * 60 * 60,
        events: [
          Event(
            id: 0,
            name: 'Eating Out',
            start: DateTime.now().subtract(Duration(hours: 5)),
            end: DateTime.now().add(
              Duration(hours: 1),
            ),
          ),
        ],
      ),
      Category(
        id: 0,
        color: Colors.red,
        name: 'School',
        amountOfTime: 6 * 60 * 60,
        events: [
          Event(
            id: 0,
            name: 'Class',
            start: DateTime.now().subtract(Duration(hours: 5)),
            end: DateTime.now().add(
              Duration(hours: 1),
            ),
          ),
        ],
      ),
      // Category(
      //   id: 0,
      //   color: Colors.purple,
      //   name: 'Sleep',
      //   amountOfTime: 6 * 60 * 60 - 60,
      //   events: [
      //     Event(
      //       id: 0,
      //       name: 'Sleeping',
      //       start: DateTime.now().subtract(Duration(hours: 5)),
      //       end: DateTime.now().add(
      //         Duration(hours: 1),
      //       ),
      //     ),
      //   ],
      // ),
    ];
  }

  List<Category> getCategoriesForTwoDays() {
    return [
      Category(
        id: 0,
        color: Colors.pink,
        name: 'Exercise',
        amountOfTime: 6 * 60 * 60,
        events: [],
      ),
      Category(
        id: 0,
        color: Colors.blue,
        name: 'Recreation',
        amountOfTime: 6 * 60 * 60,
        events: [],
      ),
      Category(
        id: 0,
        color: Colors.red,
        name: 'School',
        amountOfTime: 6 * 60 * 60,
        events: [],
      ),
      Category(
        id: 0,
        color: Colors.purple,
        name: 'Sleep',
        amountOfTime: 6 * 60 * 60,
        events: [],
      ),
      Category(
        id: 0,
        color: Colors.brown,
        name: 'Misc 1',
        amountOfTime: 6 * 60 * 60,
        events: [],
      ),
      Category(
        id: 0,
        color: Colors.cyan,
        name: 'Misc 2',
        amountOfTime: 6 * 60 * 60,
        events: [],
      ),
      Category(
        id: 0,
        color: Colors.yellow,
        name: 'Misc 3',
        amountOfTime: 6 * 60 * 60,
        events: [],
      ),
      Category(
        id: 0,
        color: Colors.teal,
        name: 'Misc 4',
        amountOfTime: 6 * 60 * 60 - 60,
        events: [],
      ),
    ];
  }
}
