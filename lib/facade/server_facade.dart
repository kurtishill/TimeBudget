import 'package:time_budget/facade/base_server_facade.dart';
import 'package:time_budget/facade/services/get_report_for_time_period.dart';
import 'package:time_budget/facade/services/login_service.dart';
import 'package:time_budget/facade/services/signup_service.dart';

class ServerFacade implements IServerFacade {
  GetReportForTimePeriodService _getReportForTimePeriodService;
  LoginService _loginService;
  SignUpService _signUpService;

  ServerFacade() {
    _getReportForTimePeriodService = GetReportForTimePeriodService();
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
  Future getReportForTimePeriod(DateTime startTime, DateTime endTime) async {
    return await _getReportForTimePeriodService.getReportForTimePeriod(
        startTime, endTime);
  }
}
