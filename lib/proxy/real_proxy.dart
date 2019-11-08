import 'package:flutter/foundation.dart';
import 'package:time_budget/proxy/base_proxy.dart';
import 'package:time_budget/proxy/request.dart';
import 'package:time_budget/requests/auth/login_request.dart';
import 'package:time_budget/requests/auth/register_request.dart';
import 'package:time_budget/requests/report/get_metrics_request.dart';
import 'package:time_budget/responses/auth_response.dart';

class RealProxy implements IProxy {
  final String ip;
  final String port;

  RealProxy({
    @required this.ip,
    @required this.port,
  });

  @override
  Future<AuthResponse> login(LoginRequest request) async {
    return await Request.send<LoginRequest, AuthResponse>(
      'http://${this.ip}:${this.port}/user/login',
      'post',
      request,
    );
  }

  @override
  Future<AuthResponse> signUp(RegisterRequest request) async {
    return await Request.send<RegisterRequest, AuthResponse>(
      'http://${this.ip}:${this.port}/user/register',
      'post',
      request,
    );
  }

  @override
  Future getMetricsForTimePeriod(GetMetricsRequest request) async {
    // return await Request.send<GetMetricsRequest, >(
    //   'http://${this.ip}:${this.port}/report/get_time_metrics_all',
    //   'post',
    //   request,
    //   headers: {'Authentication': token},
    // );
  }
}
