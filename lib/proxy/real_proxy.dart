import 'package:flutter/foundation.dart';
import 'package:time_budget/proxy/base_proxy.dart';
import 'package:time_budget/proxy/request.dart';
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
import 'package:time_budget/responses/report/get_active_categories_response.dart';
import 'package:time_budget/responses/report/get_metrics_response.dart';

class RealProxy implements IProxy {
  final String ip;
  final String port;

  RealProxy({
    @required this.ip,
    @required this.port,
  });

  @override
  Future<AuthResponse> login(LoginRequest request) async {
    await Future.delayed(Duration(seconds: 1));
    return await Request.send<LoginRequest, AuthResponse>(
      'http://${this.ip}:${this.port}/user/login',
      'post',
      requestBody: request,
    );
  }

  @override
  Future<AuthResponse> signUp(RegisterRequest request) async {
    await Future.delayed(Duration(seconds: 1));
    return await Request.send<RegisterRequest, AuthResponse>(
      'http://${this.ip}:${this.port}/user/register',
      'post',
      requestBody: request,
    );
  }

  @override
  Future<GetMetricsResponse> getMetricsForTimePeriod(
      GetMetricsRequest request, String token) async {
    return await Request.send<GetMetricsRequest, GetMetricsResponse>(
      'http://${this.ip}:${this.port}/report/get_time_metrics_all',
      'post',
      requestBody: request,
      headers: {'Authentication': token},
    );
  }

  @override
  Future<BasicResponse> deleteEvent(
      DeleteEventRequest request, String token) async {
    return await Request.send<DeleteEventRequest, BasicResponse>(
      'http://${this.ip}:${this.port}/event/delete',
      'post',
      requestBody: request,
      headers: {'Authentication': token},
    );
  }

  @override
  Future<EventListResponse> fetchEventsForCategory(
      EventListRequest request, String token) async {
    return await Request.send<EventListRequest, EventListResponse>(
      'http://${this.ip}:${this.port}/event/get_list',
      'post',
      requestBody: request,
      headers: {'Authentication': token},
    );
  }

  @override
  Future<CreateEventResponse> createEvent(
      CreateEventRequest request, String token) async {
    return await Request.send<CreateEventRequest, CreateEventResponse>(
      'http://${this.ip}:${this.port}/event/create',
      'post',
      requestBody: request,
      headers: {'Authentication': token},
    );
  }

  @override
  Future<GetActiveCategoriesResponse> getActiveCategories(String token) async {
    return await Request.send(
      'http://${this.ip}:${this.port}/categories/get_all_active',
      'get',
      headers: {'Authentication': token},
    );
  }
}
