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
import 'package:time_budget/responses/report/metric_response.dart';

class MockProxy implements IProxy {
  @override
  Future<AuthResponse> login(LoginRequest request) async {
    await Future<void>.delayed(Duration(seconds: 2));
    return AuthResponse(email: '', token: 'abc', username: '');
  }

  @override
  Future<AuthResponse> signUp(RegisterRequest request) async {
    await Future<void>.delayed(Duration(seconds: 2));
    return AuthResponse(email: '', token: 'abc', username: '');
  }

  @override
  Future<GetMetricsResponse> getMetricsForTimePeriod(
      GetMetricsRequest request, String token) async {
    await Future<void>.delayed(Duration(seconds: 2));

    return GetMetricsResponse(
      report: [
        MetricResponse(id: 1, time: 8.2, color: 0xff325a89),
        MetricResponse(id: 3, time: 3.7, color: 0xff87e2d6),
      ],
    );
  }

  @override
  Future<BasicResponse> deleteEvent(
      DeleteEventRequest request, String token) async {
    return await Future.value(BasicResponse(success: true));
  }

  @override
  Future<EventListResponse> fetchEventsForCategory(
      EventListRequest request, String token) async {
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
