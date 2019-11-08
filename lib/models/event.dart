import 'package:flutter/foundation.dart';

class Event {
  final int id;
  final String name;
  final String description;
  final DateTime start;
  final DateTime end;

  Event({
    @required this.id,
    @required this.name,
    this.description,
    @required this.start,
    @required this.end,
  });

  double calculatePercentageForTimeWithinADay() {
    final range = end.difference(start);
    final percentage = range.inSeconds / 86400;
    return percentage;
  }

  DateTime getTotalTimeAsDateTime() {
    final seconds = end.difference(start).inSeconds;
    return DateTime(0, 0, 0, 0, 0, seconds);
  }
}
