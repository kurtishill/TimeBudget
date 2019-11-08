import 'package:time_budget/proxy/base_proxy.dart';
import 'package:time_budget/proxy/factory/proxy_factory.dart';

class DeleteEventService {
  final IProxy _proxy = ProxyFactory.proxy;

  Future deleteEvent(String eventId) async {
    return await _proxy.deleteEvent(eventId);
  }
}
