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

  bool operator ==(o) =>
      o is Event &&
      this.id == o.id &&
      this.name == o.name &&
      this.description == o.description &&
      this.start == o.start &&
      this.end == o.end;

  int get hashCode =>
      31 * this.id +
      this.name.hashCode +
      this.start.hashCode +
      this.end.hashCode;

  double calculatePercentageForTimeWithinADay() {
    final range = end.difference(start);
    final percentage = range.inSeconds / 86400;
    return percentage;
  }

  DateTime getTotalTimeAsDateTime() {
    final seconds = end.difference(start).inSeconds;
    return DateTime(0, 0, 0, 0, 0, seconds);
  }

  int get timeInSeconds => end.difference(start).inSeconds;
}
