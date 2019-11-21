import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_budget/models/event.dart';
import 'package:time_budget/state/app_state.dart';
import 'package:time_budget/utils/date.dart';
import 'package:time_budget/viewmodels/bloc.dart';
import 'package:time_budget/widgets/event_card.dart';
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

  final _timeSlotSize = 80.0;
  int _dontDrawLineCounter = 0;

  /// a little hacky
  /// issue with flutter and overflowing stack widgets
  bool _canDecrement = false;

  Timer _timer;

  @override
  void initState() {
    _setTimer();
    super.initState();
  }

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
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Widget _buildSelectionSwitch(CalendarState state) {
    return Switch(
      value: _switch,
      inactiveThumbColor: Theme.of(context).accentColor,
      inactiveTrackColor: Theme.of(context).accentColor.withOpacity(0.5),
      activeColor: Colors.blue,
      onChanged: (value) {
        if (!value) {
          if (state is ReportUpdatedCalendarState) {
            final first = state.range.first;
            _calendarBloc.add(
              SetNewRangeCalendarEvent(
                start: first,
                end: DateTime(first.year, first.month, first.day, 23, 59),
              ),
            );
          }
        } else {
          if (state is ReportUpdatedCalendarState) {
            final first = state.range.first;
            final end = first.add(Duration(days: 1, hours: 23, minutes: 59));
            _calendarBloc.add(
              SetNewRangeCalendarEvent(
                start: first,
                end: end,
              ),
            );
          }
        }
      },
    );
  }

  Widget _buildTimeOfDayLine() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: (DateTime.now().minute / 60) * _timeSlotSize,
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: 65,
              child: Text(
                DateUtils.toClockTime(DateTime.now()),
                style: TextStyle(
                  color: Colors.pink,
                ),
              ),
            ),
            Expanded(
              child: Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  Container(
                    height: 1,
                    color: Colors.pink,
                  ),
                  Positioned(
                    left: 0,
                    bottom: -4,
                    child: Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.pink,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTimeSlots(DateTime date, int hour, {bool drawLine = true}) {
    return SizedBox(
      height: _timeSlotSize,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 3.0),
                child: SizedBox(
                  width: 65,
                  child: Text(
                    DateUtils.toClockTime(
                      DateTime(
                        date.year,
                        date.month,
                        date.day,
                        hour,
                      ),
                    ),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              if (drawLine)
                Expanded(
                  child: Container(
                    height: 1,
                    color: Colors.grey[300],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEvent(Event event) {
    double height =
        (((event.end.difference(event.start).inMinutes / 60) * _timeSlotSize))
            .toDouble();
    if (event.start.hour > event.end.hour) {
      height += 35;
    }
    return Padding(
      padding: const EdgeInsets.only(left: 68.0),
      child: EventCard(
        event: event,
        height: height,
      ),
    );
  }

  Widget _buildEventList(List<DateTime> range, List<Event> events) {
    final map = Map.fromIterable(events,
        key: (e) =>
            DateTime(e.start.year, e.start.month, e.start.day, e.start.hour),
        value: (e) => e);
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: range.length,
      itemBuilder: (context, i) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            DateUtils.toyMMMdString(range[i]),
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Stack(
            children: <Widget>[
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 24,
                itemBuilder: (context, j) {
                  final date = range[i];
                  final hours = List<int>.generate(24, (int index) => index);
                  final Event event = map[DateTime(
                    date.year,
                    date.month,
                    date.day,
                    hours[j],
                  )];

                  double topOffset;
                  if (event != null) {
                    topOffset = ((event.start.minute / 60) * _timeSlotSize) + 8;

                    _dontDrawLineCounter =
                        event.end.difference(event.start).inHours;
                    _canDecrement = false;
                  } else {
                    if (_canDecrement) {
                      _dontDrawLineCounter = _dontDrawLineCounter > 0
                          ? _dontDrawLineCounter - 1
                          : 0;
                    }
                    _canDecrement = true;
                  }

                  return Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
                      _buildTimeSlots(date, hours[j],
                          drawLine:
                              _canDecrement ? _dontDrawLineCounter == 0 : true),
                      if (event != null)
                        Positioned(
                          top: topOffset,
                          right: 0,
                          left: 0,
                          child: _buildEvent(event),
                        ),
                      if (DateTime.now().year == date.year &&
                          DateTime.now().month == date.month &&
                          DateTime.now().day == date.day &&
                          hours[j] == DateTime.now().hour)
                        _buildTimeOfDayLine(),
                    ],
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: _buildSelectionSwitch(state),
                  ),
                ],
              ),
              if (state is ReportUpdatedCalendarState)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: _buildEventList(state.range, state.events),
                ),
            ],
          ),
        );
      },
    );
  }

  void _onDateSelected(DateTime start, DateTime end) {
    _calendarBloc.add(SetNewRangeCalendarEvent(start: start, end: end));
  }

  void _updateTimeOfDayLine() {
    setState(() {});
    _setTimer();
  }

  void _setTimer() {
    final now = DateTime.now();
    final oneMinuteFromNow = DateTime.now().add(Duration(minutes: 1));
    final startOfNextMinuteDateTime = DateTime(
      oneMinuteFromNow.year,
      oneMinuteFromNow.month,
      oneMinuteFromNow.day,
      oneMinuteFromNow.hour,
      oneMinuteFromNow.minute,
      0,
    );
    double startOfNextMinute =
        startOfNextMinuteDateTime.difference(now).inSeconds + 0.0;
    if (startOfNextMinute == 0.0) {
      startOfNextMinute += 60.0;
    }
    print('set timer for $startOfNextMinute seconds');
    _timer = Timer(
      Duration(milliseconds: (startOfNextMinute * 1000).toInt()),
      _updateTimeOfDayLine,
    );
  }
}
