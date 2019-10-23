import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

enum ThemeEvent { toggle }

class ThemeBloc extends Bloc<ThemeEvent, ThemeData> {
  bool brightness = true;

  var theme = ThemeData(
    primarySwatch: Colors.green,
    primaryColorLight: Colors.green[200],
    accentColor: Colors.orange,
    brightness: Brightness.light,
  );

  @override
  ThemeData get initialState => theme;

  @override
  Stream<ThemeData> mapEventToState(
    ThemeEvent event,
  ) async* {
    switch (event) {
      case ThemeEvent.toggle:
        this.brightness = !this.brightness;

        this.theme = ThemeData(
          primarySwatch: Colors.green,
          primaryColorLight: Colors.green[200],
          accentColor: Colors.orange,
          brightness: this.brightness ? Brightness.light : Brightness.dark,
        );

        yield this.theme;
        break;
    }
  }
}
