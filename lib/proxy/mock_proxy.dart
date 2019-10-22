import 'package:time_budget/proxy/base_proxy.dart';

class MockProxy implements IProxy {
  @override
  Future getInfoForDate(DateTime date) async {
    await Future<void>.delayed(Duration(seconds: 2));
  }
}
