import 'package:time_budget/models/event.dart';
import 'package:time_budget/proxy/base_proxy.dart';
import 'package:time_budget/proxy/factory/proxy_factory.dart';
import 'package:time_budget/requests/events/event_list_request.dart';
import 'package:time_budget/state/app_state.dart';

class FetchEventsForCategoryService {
  final IProxy _proxy = ProxyFactory.proxy;

  Future fetchEventForCategory(
    int categoryId,
    DateTime startTime,
    DateTime endTime,
    String token,
  ) async {
    final appState = AppState();

    // if (appState.report.metrics[categoryId].events.isNotEmpty) {
    //   appState.updateEvents(
    //     categoryId,
    //     appState.report.metrics[categoryId].events,
    //   );
    // }

    final request = EventListRequest(
      categoryID: categoryId,
      startAt: startTime.millisecondsSinceEpoch ~/ 1000,
      endAt: endTime.millisecondsSinceEpoch ~/ 1000,
    );
    final response = await _proxy.fetchEventsForCategory(request, token);

    if (response != null) {
      List<Event> events = [];

      response.events.forEach((eventResponse) {
        final start = DateTime(0, 0, 0, 0, 0, eventResponse.startAt);
        final end = DateTime(0, 0, 0, 0, 0, eventResponse.endAt);
        final event = Event(
          id: eventResponse.eventID,
          name: eventResponse.description,
          start: start,
          end: end,
        );

        events.add(event);
      });

      appState.updateEvents(categoryId, events);
    }

    appState.updateEvents(
      categoryId,
      appState.report.metrics[categoryId].events,
    );
  }
}
