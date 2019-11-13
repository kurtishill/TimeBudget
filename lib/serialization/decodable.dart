import 'dart:convert';

import 'package:time_budget/responses/auth/auth_response.dart';
import 'package:time_budget/responses/basic_response.dart';
import 'package:time_budget/responses/report/get_metrics_response.dart';

abstract class Decodable {
  Decodable fromRawJson(String str) => fromJson(json.decode(str));
  Decodable fromJson(Map<String, dynamic> json);

  /// factory methods for creating specific Decodable objects
  static final _constructors = {
    AuthResponse: () => AuthResponse(),
    GetMetricsResponse: () => GetMetricsResponse(),
    BasicResponse: () => BasicResponse(),
  };

  static Decodable create(Type type) {
    return _constructors[type]();
  }
}
