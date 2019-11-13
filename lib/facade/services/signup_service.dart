import 'package:time_budget/models/user.dart';
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

    final response = await _proxy.signUp(request);

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
