import 'package:time_budget/proxy/base_proxy.dart';
import 'package:time_budget/proxy/factory/proxy_factory.dart';
import 'package:time_budget/requests/events/event_list_request.dart';

class FetchEventsForCategoryService {
  final IProxy _proxy = ProxyFactory.proxy;

  Future fetchEventForCategory(
      int categoryId, DateTime startTime, DateTime endTime) async {
    final request = EventListRequest(
      categoryID: categoryId,
      startAt: startTime.millisecondsSinceEpoch ~/ 1000,
      endAt: endTime.millisecondsSinceEpoch ~/ 1000,
    );
    return await _proxy.fetchEventsForCategory(request);
  }
}
