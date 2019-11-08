import 'package:time_budget/proxy/base_proxy.dart';
import 'package:time_budget/proxy/factory/proxy_factory.dart';
import 'package:time_budget/requests/auth/register_request.dart';

class SignUpService {
  final IProxy _proxy = ProxyFactory.proxy;

  Future signUp(String username, String password, String email) async {
    final request = RegisterRequest(
      username: username,
      password: password,
      email: email,
    );

    // TODO set user info in AppState or something
    return _proxy.signUp(request);
  }
}
