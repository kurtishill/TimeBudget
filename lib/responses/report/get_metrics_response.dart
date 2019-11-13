import 'package:time_budget/responses/report/metric_response.dart';
import 'package:time_budget/serialization/decodable.dart';

class GetMetricsResponse extends Decodable {
  final List<MetricResponse> report;

  GetMetricsResponse({
    this.report,
  });

  @override
  Decodable fromJson(Map<String, dynamic> json) => GetMetricsResponse(
        report: json['report'],
      );
}
