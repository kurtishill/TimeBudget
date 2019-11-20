import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:time_budget/facade/base_server_facade.dart';
import 'package:time_budget/facade/server_facade.dart';
import 'package:time_budget/state/app_state.dart';
import 'package:time_budget/state/app_state_base.dart';
import '../bloc.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final IServerFacade _serverFacade = ServerFacade();
  final AppStateBase _appState = AppState();

  MainBloc() {
    _appState.onReportChanged.listen((report) {
      this.add(ReportUpdatedMainEvent(report: report));
    });
  }

  @override
  MainState get initialState => InitialMainState();

  @override
  Stream<MainState> mapEventToState(
    MainEvent event,
  ) async* {
    if (event is ChangeTimePeriodMainEvent) {
      yield LoadingMainState(
        startTime: event.startTime,
        endTime: event.endTime,
      );

      if (_appState.availableCategories.isEmpty) {
        await _serverFacade.activeCategories;
      }

      await _serverFacade.getMetricsForTimePeriod(
        event.startTime,
        event.endTime,
      );

      await Future.wait(
        _appState.report.metrics.keys.toList().map<Future>(
          (categoryId) async {
            if (_appState.report.metrics[categoryId].amountOfTime > 0) {
              return await _serverFacade.fetchEventsForCategory(
                categoryId,
                event.startTime,
                event.endTime,
              );
            }
          },
        ),
      );
    } else if (event is ReportUpdatedMainEvent) {
      final report = event.report;

      final totalSecondsForTimePeriod = report.metrics.values.fold(
        0,
        (t, c) => t + c.amountOfTime,
      );

      yield InitialMainState();

      yield LoadedMainState(
        startTime: report.startTime,
        endTime: report.endTime,
        categories: report.metrics.values.toList(),
        totalSeconds: totalSecondsForTimePeriod,
      );
    } else if (event is AddNewEventMainEvent) {
      await _serverFacade.createEvent(
        event.categoryId,
        event.newEvent.name,
        event.newEvent.start,
        event.newEvent.end,
      );
    }
  }
}
