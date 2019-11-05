import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:time_budget/facade/base_server_facade.dart';
import 'package:time_budget/facade/server_facade.dart';
import '../bloc.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final IServerFacade _serverFacade = ServerFacade();

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

      // make call to facade right here
      // get and set new categories
      final categories = await _serverFacade.getReportForTimePeriod(
          event.startTime, event.endTime);

      final totalSecondsForTimePeriod =
          categories.fold(0, (t, c) => t + c.amountOfTime);

      yield LoadedMainState(
        startTime: event.startTime,
        endTime: event.endTime,
        categories: categories,
        totalSeconds: totalSecondsForTimePeriod,
      );
    }
  }
}
