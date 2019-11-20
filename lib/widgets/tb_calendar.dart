import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:time_budget/views/calendar.dart';

class TBCalendar extends StatefulWidget {
  final List<DateTime> timePeriod;
  final Color highlightColor;
  final Function(DateTime, DateTime) onDateSelected;

  TBCalendar({
    @required this.timePeriod,
    @required this.highlightColor,
    @required this.onDateSelected,
  });

  @override
  _TBCalendarState createState() => _TBCalendarState();
}

class _TBCalendarState extends State<TBCalendar> {
  EventList<Event> _markedDatesMap = EventList<Event>(events: {});
  SelectionMode _selectionMode;

  @override
  void didChangeDependencies() {
    _selectionMode =
        widget.timePeriod.length > 1 ? SelectionMode.RANGE : SelectionMode.DAY;
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(TBCalendar oldWidget) {
    _selectionMode =
        widget.timePeriod.length > 1 ? SelectionMode.RANGE : SelectionMode.DAY;
    super.didUpdateWidget(oldWidget);
  }

  EventList<Event> _buildMarkedDateMap() {
    _markedDatesMap.clear();
    widget.timePeriod.forEach(
      (date) {
        Color primaryColor = widget.highlightColor;
        Color color = primaryColor.withOpacity(0.5);
        if (date.compareTo(widget.timePeriod.first) == 0 ||
            date.compareTo(widget.timePeriod.last) == 0) {
          color = primaryColor;
        }
        _markedDatesMap.add(
          date,
          Event(
            date: date,
            title: '${date.day}',
            icon: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              child: Center(
                child: Text(
                  '${date.day}',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    return _markedDatesMap;
  }

  @override
  Widget build(BuildContext context) {
    return CalendarCarousel(
      dayPadding: 0,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      height: 420,
      isScrollable: false,
      headerTextStyle: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 20,
      ),
      weekdayTextStyle: TextStyle(
        color: Theme.of(context).primaryColor,
      ),
      leftButtonIcon: Icon(
        Icons.chevron_left,
        color: Theme.of(context).primaryColor,
      ),
      rightButtonIcon: Icon(
        Icons.chevron_right,
        color: Theme.of(context).primaryColor,
      ),
      weekendTextStyle: TextStyle(
        color: Colors.black,
      ),
      inactiveWeekendTextStyle: TextStyle(
        color: Colors.grey,
      ),
      selectedDayButtonColor: Theme.of(context).accentColor,
      todayButtonColor: Colors.transparent,
      todayTextStyle: TextStyle(color: Colors.black),
      markedDateShowIcon: true,
      markedDatesMap: _buildMarkedDateMap(),
      markedDateIconBuilder: (Event event) => event.icon,
      onDayPressed: (date, _) => _onDayPressed(date),
    );
  }

  void _onDayPressed(DateTime date) {
    if (!_markedDatesMap.events.containsKey(date) &&
        _selectionMode == SelectionMode.DAY) {
      widget.onDateSelected(
        date,
        DateTime(date.year, date.month, date.day, 23, 59),
      );
    } else if (_selectionMode == SelectionMode.RANGE) {
      final first = _markedDatesMap.events.keys.first;
      final last = _markedDatesMap.events.keys.last;

      if (date.compareTo(first) < 0) {
        widget.onDateSelected(date, last);
      } else if ((date.compareTo(first) > 0 && date.compareTo(last) < 0) &&
          date.difference(first).abs() < date.difference(last).abs()) {
        widget.onDateSelected(date, last);
      } else {
        widget.onDateSelected(
          first,
          DateTime(date.year, date.month, date.day, 23, 59),
        );
      }
    }
  }
}
