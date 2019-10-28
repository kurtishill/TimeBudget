import 'package:time_budget/proxy/base_proxy.dart';
import 'package:time_budget/proxy/factory/proxy_factory.dart';

class GetReportForTimePeriodService {
  final IProxy _proxy = ProxyFactory.proxy;

  Future getReportForTimePeriod(DateTime startTime, DateTime endTime) async {
    return await _proxy.getReportForTimePeriod(startTime, endTime);
  }
}
