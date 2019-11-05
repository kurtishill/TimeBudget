import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();
}

class DeleteEventCategoryEvent extends CategoryEvent {
  final String eventId;

  DeleteEventCategoryEvent({@required this.eventId});

  @override
  List<Object> get props => null;
}
