import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:time_budget/models/report.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();
}

class ChangeTimePeriodMainEvent extends MainEvent {
  final DateTime startTime;
  final DateTime endTime;

  ChangeTimePeriodMainEvent({@required this.startTime, @required this.endTime});

  @override
  List<Object> get props => [startTime, endTime];
}

class ReportUpdatedMainEvent extends MainEvent {
  final Report report;

  ReportUpdatedMainEvent({@required this.report});

  @override
  List<Object> get props => [report];
}
