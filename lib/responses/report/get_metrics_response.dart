import 'package:time_budget/serialization/decodable.dart';

class GetMetricsResponse extends Decodable {
  final Map<int, double> report;

  GetMetricsResponse({
    this.report,
  });

  @override
  Decodable fromJson(Map<String, dynamic> json) => GetMetricsResponse(
        report: json['report'],
      );
}
