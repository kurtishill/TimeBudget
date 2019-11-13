import 'package:time_budget/proxy/base_proxy.dart';
import 'package:time_budget/proxy/factory/proxy_factory.dart';
import 'package:time_budget/requests/report/get_metrics_request.dart';

class GetReportForTimePeriodService {
  final IProxy _proxy = ProxyFactory.proxy;

  Future getReportForTimePeriod(DateTime startTime, DateTime endTime) async {
    final request = GetMetricsRequest(
      startAt: startTime.millisecondsSinceEpoch ~/ 1000,
      endAt: endTime.millisecondsSinceEpoch ~/ 1000,
    );
    final list = await _proxy.getMetricsForTimePeriod(request);

    // TODO process the list and get the report information out of it

    return list;
  }
}
