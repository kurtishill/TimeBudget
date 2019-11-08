import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:time_budget/models/event.dart';

class Category {
  final int id;
  final String name;
  final int amountOfTime;
  final List<Event> events;
  final Color color;

  Category({
    @required this.id,
    @required this.name,
    this.amountOfTime,
    this.events,
    @required this.color,
  });

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
