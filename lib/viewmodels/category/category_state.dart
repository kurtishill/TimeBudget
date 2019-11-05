import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:time_budget/models/event.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();
}

class InitialCategoryState extends CategoryState {
  @override
  List<Object> get props => null;
}

class LoadingCategoryState extends CategoryState {
  @override
  List<Object> get props => null;
}

class EventDeletedCategoryState extends CategoryState {
  final bool success;

  EventDeletedCategoryState({@required this.success});

  @override
  List<Object> get props => [success];
}

class EventsLoadedCategoryState extends CategoryState {
  final List<Event> events;

  EventsLoadedCategoryState({@required this.events});

  @override
  List<Object> get props => [events];
}
