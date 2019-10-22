import 'package:time_budget/proxy/base_proxy.dart';
import 'package:time_budget/proxy/factory/proxy_factory.dart';

class GetInfoForDateService {
  final IProxy proxy = ProxyFactory.proxy;

  Future getInfoForDate(DateTime date) async {
    await proxy.getInfoForDate(date);
  }
}
