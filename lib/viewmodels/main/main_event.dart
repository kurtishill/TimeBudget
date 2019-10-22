import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();
}

class ChangeDateMainEvent extends MainEvent {
  final DateTime newDate;

  ChangeDateMainEvent({@required this.newDate});

  @override
  List<Object> get props => [newDate];
}
