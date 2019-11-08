import 'package:time_budget/proxy/base_proxy.dart';
import 'package:time_budget/requests/auth/login_request.dart';
import 'package:time_budget/requests/auth/register_request.dart';
import 'package:time_budget/requests/report/get_metrics_request.dart';
import 'package:time_budget/responses/auth_response.dart';
import 'package:time_budget/utils/mock_data.dart';

class MockProxy implements IProxy {
  @override
  Future<AuthResponse> login(LoginRequest request) async {
    await Future<void>.delayed(Duration(seconds: 2));
    return AuthResponse(email: '', token: '', username: '');
  }

  @override
  Future<AuthResponse> signUp(RegisterRequest request) async {
    await Future<void>.delayed(Duration(seconds: 2));
    return AuthResponse(email: '', token: '', username: '');
  }

  @override
  Future getMetricsForTimePeriod(GetMetricsRequest request) async {
    await Future<void>.delayed(Duration(seconds: 2));
    DateTime startAt = DateTime(0, 0, 0, 0, 0, request.startAt);
    DateTime endAt = DateTime(0, 0, 0, 0, 0, request.endAt);

    if (endAt.difference(startAt).inHours > 24) {
      return MockData().getCategoriesForTwoDays();
    } else if (endAt.difference(startAt).inDays < 24) {
      return MockData().getCategoriesForDay();
    }
  }
}
