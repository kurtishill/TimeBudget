import 'package:time_budget/proxy/base_proxy.dart';
import 'package:time_budget/proxy/factory/proxy_factory.dart';
import 'package:time_budget/requests/events/delete_event_request.dart';

class DeleteEventService {
  final IProxy _proxy = ProxyFactory.proxy;

  Future deleteEvent(int eventId, String token) async {
    final request = DeleteEventRequest(eventID: eventId);
    return await _proxy.deleteEvent(request, token);
  }
}
