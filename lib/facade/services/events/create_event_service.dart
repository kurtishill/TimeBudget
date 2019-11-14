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

    if (response != null) {
      List<Event> events = AppState().events(categoryId);

      final start = DateTime(0, 0, 0, 0, 0, response.startAt);
      final end = DateTime(0, 0, 0, 0, 0, response.endAt);
      events.add(
        Event(
          id: response.eventID,
          name: response.description,
          start: start,
          end: end,
        ),
      );

      AppState().updateEvents(categoryId, events);
    }
  }
}
