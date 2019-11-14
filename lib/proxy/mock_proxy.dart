import 'package:time_budget/proxy/base_proxy.dart';
import 'package:time_budget/requests/auth/login_request.dart';
import 'package:time_budget/requests/auth/register_request.dart';
import 'package:time_budget/requests/events/create_event_request.dart';
import 'package:time_budget/requests/events/delete_event_request.dart';
import 'package:time_budget/requests/events/event_list_request.dart';
import 'package:time_budget/requests/report/get_metrics_request.dart';
import 'package:time_budget/responses/auth/auth_response.dart';
import 'package:time_budget/responses/basic_response.dart';
import 'package:time_budget/responses/events/create_event_response.dart';
import 'package:time_budget/responses/events/event_list_response.dart';
import 'package:time_budget/responses/report/active_category.dart';
import 'package:time_budget/responses/report/get_active_categories_response.dart';
import 'package:time_budget/responses/report/get_metrics_response.dart';

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
      report: {1: 8.2, 2: 0, 3: 3.7, 4: 0, 5: 0, 6: 0},
      // report: [
      //   MetricResponse(id: 1, time: 8.2, color: 0xff325a89),
      //   MetricResponse(id: 3, time: 3.7, color: 0xff87e2d6),
      // ],
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

  @override
  Future<CreateEventResponse> createEvent(
      CreateEventRequest request, String token) async {
    await Future.delayed(Duration(seconds: 1));
    return CreateEventResponse(
      description: 'Event A',
      eventID: 1,
      startAt:
          DateTime(0, 0, 0, 0, 0, request.startAt).millisecondsSinceEpoch ~/
              1000,
      endAt:
          DateTime(0, 0, 0, 0, 0, request.endAt).millisecondsSinceEpoch ~/ 1000,
    );
  }

  @override
  Future<GetActiveCategoriesResponse> getActiveCategories(String token) async {
    await Future.delayed(Duration(seconds: 1));
    return GetActiveCategoriesResponse(
      categories: [
        ActiveCategory(
          categoryID: 1,
          description: 'Sleep',
          deletedAt: 6,
          color: 0xFF4CAF50,
        ),
        ActiveCategory(
          categoryID: 2,
          description: 'Work',
          deletedAt: 6,
          color: 0xFFF44336,
        ),
        ActiveCategory(
          categoryID: 3,
          description: 'School',
          deletedAt: 6,
          color: 0xFF2196F3,
        ),
        ActiveCategory(
          categoryID: 4,
          description: 'Eat',
          deletedAt: 6,
          color: 0xFFFF9800,
        ),
        ActiveCategory(
          categoryID: 5,
          description: 'Health/Wellness',
          deletedAt: 6,
          color: 0xFF9C27B0,
        ),
        ActiveCategory(
          categoryID: 6,
          description: 'Amusement',
          deletedAt: 6,
          color: 0xFF00BCD4,
        ),
      ],
    );
  }
}
