import 'package:time_budget/serialization/encodable.dart';

class GetMetricsRequest extends Encodable {
  final int startAt;
  final int endAt;

  GetMetricsRequest({
    this.startAt,
    this.endAt,
  });

  @override
  Map<String, dynamic> toJson() => {
        "startAt": startAt,
        "endAt": endAt,
      };
}
