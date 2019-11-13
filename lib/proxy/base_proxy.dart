import 'package:time_budget/requests/auth/login_request.dart';
import 'package:time_budget/requests/auth/register_request.dart';
import 'package:time_budget/requests/events/delete_event_request.dart';
import 'package:time_budget/requests/events/event_list_request.dart';
import 'package:time_budget/requests/report/get_metrics_request.dart';
import 'package:time_budget/responses/auth/auth_response.dart';
import 'package:time_budget/responses/basic_response.dart';
import 'package:time_budget/responses/events/event_list_response.dart';
import 'package:time_budget/responses/report/get_metrics_response.dart';

abstract class IProxy {
  /// Logs a user in
  /// Returns an AuthResponse (String username, String email, String token)
  Future<AuthResponse> login(LoginRequest request);

  /// Signs a user up
  /// Returns an AuthResponse (String username, String email, String token)
  Future<AuthResponse> signUp(RegisterRequest request);

  /// Gets the metrics for a given time period
  /// Returns a GetMetricsResponse (Map<int, double> report)
  Future<GetMetricsResponse> getMetricsForTimePeriod(GetMetricsRequest request, String token);

  /// Deletes a given event
  /// Returns a BasicResponse (bool success)
  Future<BasicResponse> deleteEvent(DeleteEventRequest request, String token);

  /// Gets the events for a specific category
  /// Returns an EventListResponse (List<EventResponse> events)
  Future<EventListResponse> fetchEventsForCategory(EventListRequest request, String token);
}
