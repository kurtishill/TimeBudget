import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:time_budget/facade/base_server_facade.dart';
import 'package:time_budget/facade/server_facade.dart';
import '../bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final IServerFacade _serverFacade = ServerFacade();

  @override
  CategoryState get initialState => InitialCategoryState();

  @override
  Stream<CategoryState> mapEventToState(
    CategoryEvent event,
  ) async* {
    if (event is DeleteEventCategoryEvent) {
      await _serverFacade.deleteEvent(event.eventId);
    }
  }
}
