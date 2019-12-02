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

    final startAt = startTime.millisecondsSinceEpoch ~/ 1000;
    final endAt = endTime.millisecondsSinceEpoch ~/ 1000;

    final request = EventListRequest(
      categoryID: categoryId,
      startAt: startAt,
      endAt: endAt,
    );
    final response = await _proxy.fetchEventsForCategory(request, token);

    if (response != null) {
      List<Event> events = [];

      response.events.forEach((eventResponse) {
        final start =
            DateTime.fromMillisecondsSinceEpoch(eventResponse.startAt * 1000);
        final end =
            DateTime.fromMillisecondsSinceEpoch(eventResponse.endAt * 1000);

        final event = Event(
          id: eventResponse.eventID,
          name: eventResponse.description,
          start: eventResponse.startAt < startAt
              ? DateTime.fromMillisecondsSinceEpoch(startAt * 1000)
              : start,
          end: eventResponse.endAt > endAt
              ? DateTime.fromMillisecondsSinceEpoch(endAt * 1000)
              : end,
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
