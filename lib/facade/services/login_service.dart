import 'package:time_budget/models/user.dart';
import 'package:time_budget/proxy/base_proxy.dart';
import 'package:time_budget/proxy/factory/proxy_factory.dart';
import 'package:time_budget/requests/auth/login_request.dart';

class LoginService {
  final IProxy _proxy = ProxyFactory.proxy;

  Future login(String username, String password) async {
    final request = LoginRequest(
      username: username,
      password: password,
    );

    final response = await _proxy.login(request);

    if (response != null) {
      return User(
        email: response.email,
        token: response.token,
        username: response.username,
      );
    }
    return null;
  }
}
