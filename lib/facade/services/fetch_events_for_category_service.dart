import 'package:time_budget/proxy/base_proxy.dart';
import 'package:time_budget/proxy/factory/proxy_factory.dart';

class FetchEventsForCategoryService {
  final IProxy _proxy = ProxyFactory.proxy;

  Future fetchEventForCategory(
      String categoryId, DateTime startTime, DateTime endTime) async {
    return await _proxy.fetchEventsForCategory(categoryId, startTime, endTime);
  }
}
