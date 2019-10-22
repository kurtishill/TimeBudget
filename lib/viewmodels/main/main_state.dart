import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:time_budget/models/category.dart' as tbCategory;

abstract class MainState extends Equatable {
  const MainState();

  @override
  List<Object> get props => [];
}

class InitialMainState extends MainState {}

class LoadingMainState extends MainState {}

class LoadedMainState extends MainState {
  final DateTime date;
  final List<tbCategory.Category> categories;

  LoadedMainState({
    @required this.date,
    this.categories,
  });

  @override
  List<Object> get props => [date, categories];
}
