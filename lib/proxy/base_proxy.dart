import 'package:time_budget/requests/auth/login_request.dart';
import 'package:time_budget/requests/auth/register_request.dart';
import 'package:time_budget/requests/report/get_metrics_request.dart';
import 'package:time_budget/responses/auth_response.dart';

abstract class IProxy {

  Future<AuthResponse> login(LoginRequest request);
  Future<AuthResponse> signUp(RegisterRequest request);
  Future getMetricsForTimePeriod(GetMetricsRequest request);
  Future deleteEvent(String eventId);
  Future fetchEventsForCategory(
    String categoryId,
    DateTime startTime,
    DateTime endTime,
  );
}
