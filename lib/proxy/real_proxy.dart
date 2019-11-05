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
  Future login(String username, String password) {
    // TODO: implement login
    return null;
  }

  @override
  Future signUp(String username, String password, String email) {
    // TODO: implement signUp
    return null;
  }

  @override
  Future getReportForTimePeriod(DateTime startTime, DateTime endTime) async {
    // TODO: implement getInfoForTimePeriod
  }

  @override
  Future deleteEvent(String eventId) {
    // TODO: implement deleteEvent
    return null;
  }

  @override
  Future fetchEventsForCategory(
      String categoryId, DateTime startTime, DateTime endTime) {
    // TODO: implement fetchEventsForCategory
    return null;
  }
}
