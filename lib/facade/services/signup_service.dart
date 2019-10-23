import 'package:time_budget/proxy/base_proxy.dart';
import 'package:time_budget/proxy/factory/proxy_factory.dart';

class SignUpService {
  final IProxy _proxy = ProxyFactory.proxy;

  Future signUp(String username, String password, String email) async {
    return _proxy.signUp(username, password, email);
  }
}
