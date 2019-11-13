import 'package:flutter/foundation.dart';
import 'package:time_budget/serialization/decodable.dart';

class MetricResponse extends Decodable {
  final int id;
  final double time;
  final int color;

  MetricResponse({
    @required this.id,
    @required this.time,
    @required this.color,
  });

  @override
  Decodable fromJson(Map<String, dynamic> json) => MetricResponse(
        id: json['id'],
        time: json['time'],
        color: json['color'],
      );
}
