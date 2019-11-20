import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:time_budget/models/event.dart';

abstract class CalendarState extends Equatable {
  const CalendarState();
}

class InitialCalendarState extends CalendarState {
  @override
  List<Object> get props => [];
}

class ReportUpdatedCalendarState extends CalendarState {
  final List<DateTime> range;
  final List<Event> events;

  ReportUpdatedCalendarState({
    @required this.range,
    @required this.events,
  });

  @override
  List<Object> get props => [range, events];
}
