import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:time_budget/facade/base_server_facade.dart';
import 'package:time_budget/facade/server_facade.dart';
import 'package:time_budget/state/app_state.dart';
import 'package:time_budget/state/app_state_base.dart';
import '../bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final IServerFacade _serverFacade = ServerFacade();
  final AppStateBase _appState = AppState();

  CategoryBloc(int categoryId) {
    _appState.onEventsChanged(categoryId).listen((events) {
      this.add(UpdateEventCategoryEvent(events: events));
    });
  }

  @override
  CategoryState get initialState => InitialCategoryState();

  @override
  Stream<CategoryState> mapEventToState(
    CategoryEvent event,
  ) async* {
    if (event is DeleteEventCategoryEvent) {
      yield InitialCategoryState();
      await _serverFacade.deleteEvent(
        event.categoryId,
        event.eventId,
      );
    } else if (event is FetchEventsCategoryEvent) {
      yield LoadingCategoryState();

      await _serverFacade.fetchEventsForCategory(
        event.categoryId,
        event.startTime,
        event.endTime,
      );
    } else if (event is UpdateEventCategoryEvent) {
      yield EventsLoadedCategoryState(events: event.events);
    }
  }
}
