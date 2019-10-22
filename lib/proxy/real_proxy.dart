import 'package:flutter/foundation.dart';
import 'package:time_budget/proxy/base_proxy.dart';

class RealProxy implements IProxy {
  final String ip;
  final String port;

  RealProxy({
    @required this.ip,
    @required this.port,
  });

  @override
  Future getInfoForDate(DateTime date) async {
    // TODO: implement getInfoForTimePeriod
  }
}
