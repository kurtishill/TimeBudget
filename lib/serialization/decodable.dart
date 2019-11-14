import 'dart:convert';

import 'package:time_budget/responses/auth/auth_response.dart';
import 'package:time_budget/responses/basic_response.dart';
import 'package:time_budget/responses/events/create_event_response.dart';
import 'package:time_budget/responses/events/event_list_response.dart';
import 'package:time_budget/responses/report/get_active_categories_response.dart';
import 'package:time_budget/responses/report/get_metrics_response.dart';

abstract class Decodable {
  Decodable fromRawJson(String str) => fromJson(json.decode(str));
  Decodable fromJson(Map<String, dynamic> json);

  /// factory methods for creating specific Decodable objects
  static final _constructors = {
    AuthResponse: () => AuthResponse(),
    GetMetricsResponse: () => GetMetricsResponse(),
    BasicResponse: () => BasicResponse(),
    GetActiveCategoriesResponse: () => GetActiveCategoriesResponse(),
    CreateEventResponse: () => CreateEventResponse(),
    EventListResponse: () => EventListResponse(),
  };

  static Decodable create(Type type) {
    return _constructors[type]();
  }
}
