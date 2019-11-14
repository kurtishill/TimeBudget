import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:time_budget/models/event.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();
}

class DeleteEventCategoryEvent extends CategoryEvent {
  final int categoryId;
  final int eventId;

  DeleteEventCategoryEvent({
    @required this.categoryId,
    @required this.eventId,
  });

  @override
  List<Object> get props => [eventId];
}

class FetchEventsCategoryEvent extends CategoryEvent {
  final int categoryId;
  final DateTime startTime;
  final DateTime endTime;

  FetchEventsCategoryEvent({
    @required this.categoryId,
    @required this.startTime,
    @required this.endTime,
  });

  @override
  List<Object> get props => [categoryId, startTime, endTime];
}

class UpdateEventCategoryEvent extends CategoryEvent {
  final List<Event> events;

  UpdateEventCategoryEvent({@required this.events});

  @override
  List<Object> get props => [events];
}
