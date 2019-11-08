import 'package:time_budget/models/event.dart';
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

  @override
  Future deleteEvent(String eventId) async {
    return await Future.value(true);
  }

  @override
  Future fetchEventsForCategory(
    String categoryId,
    DateTime startTime,
    DateTime endTime,
  ) async {
    await Future.delayed(Duration(seconds: 1));
    return <Event>[
      Event(
        id: '',
        name: 'Event A',
        start: DateTime.now(),
        end: DateTime.now().add(
          Duration(hours: 7),
        ),
      ),
      Event(
        id: '',
        name: 'Event B',
        start: DateTime.now(),
        end: DateTime.now().add(
          Duration(hours: 3, minutes: 47),
        ),
      ),
    ];
  }
}
