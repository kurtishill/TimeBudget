import 'package:time_budget/models/event.dart';
import 'package:time_budget/proxy/base_proxy.dart';
import 'package:time_budget/proxy/factory/proxy_factory.dart';
import 'package:time_budget/requests/events/create_event_request.dart';
import 'package:time_budget/state/app_state.dart';

class CreateEventService {
  final IProxy _proxy = ProxyFactory.proxy;

  Future createEvent(
    int categoryId,
    String description,
    DateTime startTime,
    DateTime endTime,
    String token,
  ) async {
    final start = startTime.millisecondsSinceEpoch ~/ 1000;
    final end = endTime.millisecondsSinceEpoch ~/ 1000;

    final request = CreateEventRequest(
      categoryID: categoryId,
      description: description,
      startAt: start,
      endAt: end,
    );

    final response = await _proxy.createEvent(request, token);

    final appState = AppState();

    if (response != null &&
        (start >= appState.report.start || end <= appState.report.end)) {
      List<Event> events = AppState().events(categoryId);

      int eventStart = response.startAt;
      if (start <= appState.report.start) {
        eventStart = appState.report.start;
      }

      int eventEnd = response.endAt;
      if (end >= appState.report.end) {
        eventEnd = appState.report.end;
      }

      final eventStartDateTime = DateTime(0, 0, 0, 0, 0, eventStart);
      final eventEndDateTime = DateTime(0, 0, 0, 0, 0, eventEnd);
      events.add(
        Event(
          id: response.eventID,
          name: response.description,
          start: eventStartDateTime,
          end: eventEndDateTime,
        ),
      );

      appState.updateEvents(categoryId, events);
    }
  }
}
