import 'package:time_budget/proxy/base_proxy.dart';

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
  Future getInfoForDate(DateTime date) async {
    await Future<void>.delayed(Duration(seconds: 2));
  }
}
