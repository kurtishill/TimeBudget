import 'package:time_budget/models/event.dart';
import 'package:time_budget/proxy/base_proxy.dart';
import 'package:time_budget/requests/auth/login_request.dart';
import 'package:time_budget/requests/auth/register_request.dart';
import 'package:time_budget/requests/events/delete_event_request.dart';
import 'package:time_budget/requests/events/event_list_request.dart';
import 'package:time_budget/requests/report/get_metrics_request.dart';
import 'package:time_budget/responses/auth/auth_response.dart';
import 'package:time_budget/responses/basic_response.dart';
import 'package:time_budget/responses/events/event_list_response.dart';
import 'package:time_budget/responses/report/get_metrics_response.dart';
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
  Future<GetMetricsResponse> getMetricsForTimePeriod(
      GetMetricsRequest request) async {
    await Future<void>.delayed(Duration(seconds: 2));
    DateTime startAt = DateTime(0, 0, 0, 0, 0, request.startAt);
    DateTime endAt = DateTime(0, 0, 0, 0, 0, request.endAt);

    return GetMetricsResponse(
      report: {0: 2, 1: 3, 2: 6},
    );

    // if (endAt.difference(startAt).inHours > 24) {
    //   return MockData().getCategoriesForTwoDays();
    // } else if (endAt.difference(startAt).inDays < 24) {
    //   return MockData().getCategoriesForDay();
    // }
  }

  @override
  Future<BasicResponse> deleteEvent(DeleteEventRequest request) async {
    return await Future.value(BasicResponse(success: true));
  }

  @override
  Future<EventListResponse> fetchEventsForCategory(
      EventListRequest request) async {
    await Future.delayed(Duration(seconds: 1));
    return EventListResponse(events: []);
    // return <Event>[
    //   Event(
    //     id: 0,
    //     name: 'Event A',
    //     start: DateTime.now(),
    //     end: DateTime.now().add(
    //       Duration(hours: 7),
    //     ),
    //   ),
    //   Event(
    //     id: 0,
    //     name: 'Event B',
    //     start: DateTime.now(),
    //     end: DateTime.now().add(
    //       Duration(hours: 3, minutes: 47),
    //     ),
    //   ),
    // ];
  }
}
