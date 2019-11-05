import 'package:time_budget/proxy/base_proxy.dart';
import 'package:time_budget/utils/mock_data.dart';

class MockProxy implements IProxy {
  @override
  Future login(String username, String password) async {
    await Future<void>.delayed(Duration(seconds: 2));
    return 'token';
  }

  @override
  Future signUp(String username, String password, String email) async {
    await Future<void>.delayed(Duration(seconds: 2));
    return 'token';
  }

  @override
  Future getReportForTimePeriod(DateTime startTime, DateTime endTime) async {
    await Future<void>.delayed(Duration(seconds: 2));
    if (endTime.difference(startTime).inHours > 24) {
      return MockData().getCategoriesForTwoDays();
    } else if (endTime.difference(startTime).inDays < 24) {
      return MockData().getCategoriesForDay();
    }
  }

  @override
  Future deleteEvent(String eventId) async {
    return await Future.value(true);
  }
}
