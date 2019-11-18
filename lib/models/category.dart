import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:time_budget/models/event.dart';
import 'package:time_budget/state/app_state.dart';

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

  factory Category.categoryFromMetrics(int id, int time) {
    String name;
    switch (id) {
      case 1:
        name = 'Amusement';
        break;
      case 2:
        name = 'School';
        break;
      case 3:
        name = 'Sleep';
        break;
      case 4:
        name = 'Work';
        break;
      case 5:
        name = 'Eat';
        break;
      case 6:
        name = 'Health';
        break;
      default:
        name = '';
    }

    return Category(
      id: id,
      name: name,
      amountOfTime: time,
      color:
          AppState().availableCategories?.firstWhere((c) => c.id == id)?.color,
    );
  }

  bool operator ==(o) {
    if (o == null) return false;
    if (o == this) return true;

    return o is Category &&
        this.id == o.id &&
        this.name == o.name &&
        this.amountOfTime == o.amountOfTime &&
        this.events == o.events &&
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
