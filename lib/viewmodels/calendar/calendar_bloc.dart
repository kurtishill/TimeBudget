import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:time_budget/facade/server_facade.dart';
import 'package:time_budget/models/event.dart';
import 'package:time_budget/state/app_state.dart';
import '../bloc.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final _appState = AppState();
  final _serverFacade = ServerFacade();

  CalendarBloc() {
    _appState.onReportChanged.listen((report) {
      final start = report.startTime;
      final end = report.endTime;

      List<DateTime> range = [];
      for (int i = 0; i <= end.difference(start).inDays; i++) {
        range.add(start.add(Duration(days: i)));
      }

      List<Event> events = [];
      report.metrics.forEach((k, v) => events.addAll(v.events));

      this.add(NewRangeLoadedCalendarEvent(range: range, events: events));
    });
  }

  @override
  CalendarState get initialState => InitialCalendarState();

  @override
  Stream<CalendarState> mapEventToState(
    CalendarEvent event,
  ) async* {
    if (event is SetNewRangeCalendarEvent) {
      if (event.start.compareTo(_appState.report.startTime) != 0 ||
          event.end.compareTo(_appState.report.endTime) != 0) {
        await _serverFacade.getMetricsForTimePeriod(event.start, event.end);
      }
      await Future.wait(
        _appState.report.metrics.keys.toList().map<Future>(
          (categoryId) async {
            if (_appState.report.metrics[categoryId].amountOfTime > 0) {
              return await _serverFacade.fetchEventsForCategory(
                categoryId,
                event.start,
                event.end,
              );
            }
          },
        ),
      );
    } else if (event is NewRangeLoadedCalendarEvent) {
      yield ReportUpdatedCalendarState(
        range: event.range,
        events: event.events,
      );
    }
  }
}
