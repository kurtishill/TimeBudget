import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_budget/state/app_state.dart';
import 'package:time_budget/utils/date.dart';
import 'package:time_budget/viewmodels/bloc.dart';
import 'package:time_budget/widgets/tb_calendar.dart';

enum SelectionMode { DAY, RANGE }

class CalendarView extends StatefulWidget {
  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  CalendarBloc _calendarBloc;
  bool _switch = false;
  String _selectionText;
  Color _highlightColor;

  @override
  void didChangeDependencies() {
    _calendarBloc = BlocProvider.of<CalendarBloc>(context);
    _calendarBloc.add(
      SetNewRangeCalendarEvent(
        start: AppState().report.startTime,
        end: AppState().report.endTime,
      ),
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _calendarBloc,
      builder: (context, state) {
        List<DateTime> timePeriod = [];
        if (state is ReportUpdatedCalendarState) {
          timePeriod = state.range;
          _switch = timePeriod.length > 1 ? true : false;
          _selectionText = 'Select ${_switch ? "range" : "day"}';
          _highlightColor =
              _switch ? Colors.blue : Theme.of(context).accentColor;
        }
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TBCalendar(
                timePeriod: timePeriod,
                highlightColor: _highlightColor,
                onDateSelected: _onDateSelected,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Spacer(),
                  Text(
                    _selectionText,
                    style: TextStyle(
                      color: _highlightColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Switch(
                    value: _switch,
                    inactiveThumbColor: Theme.of(context).accentColor,
                    inactiveTrackColor:
                        Theme.of(context).accentColor.withOpacity(0.5),
                    activeColor: Colors.blue,
                    onChanged: (value) {
                      if (!value) {
                        if (state is ReportUpdatedCalendarState) {
                          final first = state.range.first;
                          _calendarBloc.add(
                            SetNewRangeCalendarEvent(
                              start: first,
                              end: DateTime(
                                  first.year, first.month, first.day, 23, 59),
                            ),
                          );
                        }
                      } else {
                        if (state is ReportUpdatedCalendarState) {
                          final first = state.range.first;
                          final end = first
                              .add(Duration(days: 1, hours: 23, minutes: 59));
                          _calendarBloc.add(
                            SetNewRangeCalendarEvent(
                              start: first,
                              end: end,
                            ),
                          );
                        }
                      }
                    },
                  ),
                ],
              ),

              // Column(
              //   children: state is ReportUpdatedCalendarState
              //       ? state.range.map((date) {
              //           return Column(
              //             children: <Widget>[
              //               Text(DateUtils.toyMMMdString(date)),
              //             ],
              //           );
              //         })
              //       : [],
              // )
            ],
          ),
        );
      },
    );
  }

  void _onDateSelected(DateTime start, DateTime end) {
    _calendarBloc.add(SetNewRangeCalendarEvent(start: start, end: end));
  }
}
