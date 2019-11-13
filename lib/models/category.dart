import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:time_budget/models/event.dart';

class Category {
  final int id;
  final String name;
  int amountOfTime;
  List<Event> events = [];
  final Color color;

  Category({
    @required this.id,
    @required this.name,
    this.amountOfTime,
    this.events,
    @required this.color,
  });

  factory Category.categoryFromMetrics(int id, int time, int color) {
    switch (id) {
      case 1:
        return Category(
          id: id,
          name: 'Sleep',
          amountOfTime: time,
          color: Color(color),
        );
      case 2:
        return Category(
          id: id,
          name: 'Work',
          amountOfTime: time,
          color: Color(color),
        );
      case 3:
        return Category(
          id: id,
          name: 'School',
          amountOfTime: time,
          color: Color(color),
        );
      case 4:
        return Category(
          id: id,
          name: 'Eat',
          color: Color(color),
        );
      case 5:
        return Category(
          id: id,
          name: 'Health/Wellness',
          amountOfTime: time,
          color: Color(color),
        );
      case 6:
        return Category(
          id: id,
          name: 'Amusement',
          amountOfTime: time,
          color: Color(color),
        );
      default:
        return Category(
          id: id,
          name: 'Sleep',
          amountOfTime: time,
          color: Color(color),
        );
    }
  }

  bool operator ==(o) {
    if (o == null) return false;
    if (o == this) return true;

    return o is Category &&
        this.id == o.id &&
        this.name == o.name &&
        this.amountOfTime == o.amountOfTime &&
        this.color == o.color;
  }

  int get hashCode =>
      31 * this.id.hashCode +
      this.name.hashCode +
      this.amountOfTime +
      this.color.hashCode;

  DateTime timeForEventsToDateTime() {
    return DateTime(0, 0, 0, 0, 0, totalTimeForEventsToSeconds());
  }

  DateTime amountOfTimeToDateTime() {
    return DateTime(0, 0, 0, 0, 0, amountOfTime);
  }

  int totalTimeForEventsToSeconds() {
    final timeSpentInSeconds =
        this.events.fold(0, (t, e) => t + e.end.difference(e.start).inSeconds);
    return timeSpentInSeconds;
  }
}
