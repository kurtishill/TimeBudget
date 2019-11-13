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

      await _serverFacade.getMetricsForTimePeriod(
        event.startTime,
        event.endTime,
      );
    } else if (event is ReportUpdatedMainEvent) {
      final report = event.report;

      final totalSecondsForTimePeriod = report.metrics.values.fold(
        0,
        (t, c) => t + c.amountOfTime,
      );

      final s = state as TimeMainState;

      yield LoadedMainState(
        startTime: s.startTime,
        endTime: s.endTime,
        categories: report.metrics.values.toList(),
        totalSeconds: totalSecondsForTimePeriod,
      );
    }
    else if (event is AddNewEventMainEvent) {

    }
  }
}
