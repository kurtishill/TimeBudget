import 'package:time_budget/facade/base_server_facade.dart';
import 'package:time_budget/facade/services/get_info_for_date_service.dart';
import 'package:time_budget/facade/services/login_service.dart';
import 'package:time_budget/facade/services/signup_service.dart';

class ServerFacade implements IServerFacade {
  GetInfoForDateService _getInfoForDateService;
  LoginService _loginService;
  SignUpService _signUpService;

  ServerFacade() {
    _getInfoForDateService = GetInfoForDateService();
    _loginService = LoginService();
    _signUpService = SignUpService();
  }

  @override
  Future login(String username, String password) {
    return _loginService.login(username, password);
  }

  @override
  Future signUp(String username, String password, String email) {
    return _signUpService.signUp(username, password, email);
  }

  @override
  Future getInfoForDate(DateTime date) async {
    await _getInfoForDateService.getInfoForDate(date);
  }
}
