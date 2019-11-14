import 'package:time_budget/proxy/base_proxy.dart';
import 'package:time_budget/proxy/factory/proxy_factory.dart';
import 'package:time_budget/requests/events/delete_event_request.dart';
import 'package:time_budget/state/app_state.dart';

class DeleteEventService {
  final IProxy _proxy = ProxyFactory.proxy;

  Future deleteEvent(int categoryId, int eventId, String token) async {
    final request = DeleteEventRequest(eventID: eventId);
    final response = await _proxy.deleteEvent(request, token);

    if (response.success) {
      final newEvents = AppState().events(categoryId);
      newEvents.removeWhere((e) => e.id == eventId);
      AppState().updateEvents(categoryId, newEvents);
    }
  }
}
