import 'package:time_budget/serialization/decodable.dart';

class GetMetricsResponse extends Decodable {
  final Map<int, double> report;

  GetMetricsResponse({
    this.report,
  });

  @override
  Decodable fromJson(Map<String, dynamic> json) {
    Map<int, double> r = {};

    json['report'].forEach((String id, dynamic time) {
      r[int.parse(id)] = time as double;
    });

    return GetMetricsResponse(report: r);
  }
}
