import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();
}

class DeleteEventCategoryEvent extends CategoryEvent {
  final String eventId;

  DeleteEventCategoryEvent({@required this.eventId});

  @override
  List<Object> get props => [eventId];
}

class FetchEventsCategoryEvent extends CategoryEvent {
  final String categoryId;
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
