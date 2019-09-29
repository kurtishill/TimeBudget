import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(TimeBudgetApp());

class TimeBudgetApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [],
      child: MaterialApp(
        title: 'Time Budget',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Container(),
      ),
    );
  }
}
