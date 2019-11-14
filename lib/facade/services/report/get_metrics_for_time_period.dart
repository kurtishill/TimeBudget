import 'package:time_budget/models/category.dart';
import 'package:time_budget/models/report.dart';
import 'package:time_budget/proxy/base_proxy.dart';
import 'package:time_budget/proxy/factory/proxy_factory.dart';
import 'package:time_budget/requests/report/get_metrics_request.dart';
import 'package:time_budget/state/app_state.dart';

class GetMetricsForTimePeriodService {
  final IProxy _proxy = ProxyFactory.proxy;

  Future getMetricsForTimePeriod(
      DateTime startTime, DateTime endTime, String token) async {
    final request = GetMetricsRequest(
      startAt: startTime.millisecondsSinceEpoch ~/ 1000,
      endAt: endTime.millisecondsSinceEpoch ~/ 1000,
    );

    final response = await _proxy.getMetricsForTimePeriod(request, token);

    if (response != null) {
      Map<int, Category> metrics = {};
      response.report.forEach((id, time) {
        final timeInSeconds = (time * 3600).round();
        final category = Category.categoryFromMetrics(
          id,
          timeInSeconds,
        );
        category.events = [];

        metrics[id] = category;
      });

      AppState().updateReport(
        Report(metrics: metrics),
      );
    }

    return null;
  }
}
