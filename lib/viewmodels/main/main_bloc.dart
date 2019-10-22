import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:time_budget/facade/base_server_facade.dart';
import 'package:time_budget/facade/server_facade.dart';
import 'package:time_budget/models/category.dart';
import 'package:time_budget/models/event.dart';
import '../bloc.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final IServerFacade serverFacade = ServerFacade();

  List<Category> categories = [
    Category(
      id: '',
      color: Colors.pink,
      name: 'Exercise',
      events: [
        Event(
          id: '',
          name: 'Walking',
          start: DateTime.now().subtract(Duration(hours: 5)),
          end: DateTime.now().add(
            Duration(hours: 1),
          ),
        ),
      ],
    ),
    Category(
      id: '',
      color: Colors.blue,
      name: 'Recreation',
      events: [
        Event(
          id: '',
          name: 'Eating Out',
          start: DateTime.now().subtract(Duration(hours: 5)),
          end: DateTime.now().add(
            Duration(hours: 1),
          ),
        ),
      ],
    ),
    Category(
      id: '',
      color: Colors.red,
      name: 'School',
      events: [
        Event(
          id: '',
          name: 'Class',
          start: DateTime.now().subtract(Duration(hours: 5)),
          end: DateTime.now().add(
            Duration(hours: 1),
          ),
        ),
      ],
    ),
    Category(
      id: '',
      color: Colors.purple,
      name: 'Sleep',
      events: [
        Event(
          id: '',
          name: 'Sleeping',
          start: DateTime.now().subtract(Duration(hours: 5)),
          end: DateTime.now().add(
            Duration(hours: 1),
          ),
        ),
      ],
    ),
  ];

  @override
  MainState get initialState => InitialMainState();

  @override
  Stream<MainState> mapEventToState(
    MainEvent event,
  ) async* {
    if (event is ChangeDateMainEvent) {
      yield LoadingMainState();

      // make call to facade right here
      // get and set new categories
      await this.serverFacade.getInfoForDate(event.newDate);

      yield LoadedMainState(date: event.newDate, categories: this.categories);
    }
  }
}
