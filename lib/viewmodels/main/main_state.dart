import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:time_budget/models/category.dart' as tbCategory;

abstract class MainState extends Equatable {
  const MainState();

  @override
  List<Object> get props => [];
}

class InitialMainState extends MainState {}

class TimeMainState extends MainState {
  final DateTime startTime;
  final DateTime endTime;

  TimeMainState({
    @required this.startTime,
    @required this.endTime,
  });

  @override
  List<Object> get props => [startTime, endTime];
}

class LoadingMainState extends TimeMainState {
  final DateTime startTime;
  final DateTime endTime;

  LoadingMainState({
    @required this.startTime,
    @required this.endTime,
  });

  @override
  List<Object> get props => [startTime, endTime];
}

class LoadedMainState extends TimeMainState {
  final DateTime startTime;
  final DateTime endTime;
  final List<tbCategory.Category> categories;
  final int totalSeconds;

  LoadedMainState({
    @required this.startTime,
    @required this.endTime,
    this.categories,
    this.totalSeconds,
  }) : super(startTime: startTime, endTime: endTime);

  @override
  List<Object> get props => [startTime, endTime, categories];
}
