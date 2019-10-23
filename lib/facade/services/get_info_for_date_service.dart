import 'package:time_budget/proxy/base_proxy.dart';
import 'package:time_budget/proxy/factory/proxy_factory.dart';

class GetInfoForDateService {
  final IProxy _proxy = ProxyFactory.proxy;

  Future getInfoForDate(DateTime date) async {
    await _proxy.getInfoForDate(date);
  }
}
