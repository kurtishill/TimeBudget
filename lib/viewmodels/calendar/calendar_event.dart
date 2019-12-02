import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:time_budget/models/event.dart';

abstract class CalendarEvent extends Equatable {
  const CalendarEvent();
}

class SetNewRangeCalendarEvent extends CalendarEvent {
  final DateTime start;
  final DateTime end;

  SetNewRangeCalendarEvent({
    @required this.start,
    @required this.end,
  });

  @override
  List<Object> get props => [start, end];
}

class NewRangeLoadedCalendarEvent extends CalendarEvent {
  final List<DateTime> range;
  final List<Event> events;

  NewRangeLoadedCalendarEvent({
    @required this.range,
    @required this.events,
  });

  @override
  List<Object> get props => [range, events];
}
