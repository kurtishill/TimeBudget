import 'package:time_budget/proxy/base_proxy.dart';
import 'package:time_budget/proxy/factory/proxy_factory.dart';

class LoginService {
  final IProxy _proxy = ProxyFactory.proxy;

  Future login(String username, String password) async {
    return await _proxy.login(username, password);
  }
}
