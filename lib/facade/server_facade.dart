import 'package:time_budget/facade/base_server_facade.dart';
import 'package:time_budget/facade/services/events/create_event_service.dart';
import 'package:time_budget/facade/services/events/delete_event_service.dart';
import 'package:time_budget/facade/services/events/fetch_events_for_category_service.dart';
import 'package:time_budget/facade/services/report/get_active_categories_service.dart';
import 'package:time_budget/facade/services/report/get_metrics_for_time_period.dart';
import 'package:time_budget/facade/services/auth/login_service.dart';
import 'package:time_budget/facade/services/auth/signup_service.dart';
import 'package:time_budget/state/app_state.dart';
import 'package:time_budget/state/app_state_base.dart';

class ServerFacade implements IServerFacade {
  GetMetricsForTimePeriodService _getMetricsForTimePeriodService;
  LoginService _loginService;
  SignUpService _signUpService;
  DeleteEventService _deleteEventService;
  FetchEventsForCategoryService _fetchEventsForCategoryService;
  CreateEventService _createEventService;
  GetActiveCategoriesService _getActiveCategoriesService;

  AppStateBase _appState = AppState();

  /// singleton boilerplate
  static final IServerFacade _instance = ServerFacade._internal();

  factory ServerFacade() {
    return _instance;
  }

  ServerFacade._internal() {
    _getMetricsForTimePeriodService = GetMetricsForTimePeriodService();
    _loginService = LoginService();
    _signUpService = SignUpService();
    _deleteEventService = DeleteEventService();
    _fetchEventsForCategoryService = FetchEventsForCategoryService();
    _createEventService = CreateEventService();
    _getActiveCategoriesService = GetActiveCategoriesService();
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
  Future getMetricsForTimePeriod(DateTime startTime, DateTime endTime) async {
    return await _getMetricsForTimePeriodService.getMetricsForTimePeriod(
        startTime, endTime, _appState.token);
  }

  @override
  Future deleteEvent(int categoryId, int eventId) async {
    return await _deleteEventService.deleteEvent(
        categoryId, eventId, _appState.token);
  }

  @override
  Future fetchEventsForCategory(
    int categoryId,
    DateTime startTime,
    DateTime endTime,
  ) async {
    return await _fetchEventsForCategoryService.fetchEventForCategory(
      categoryId,
      startTime,
      endTime,
      _appState.token,
    );
  }

  @override
  Future createEvent(
    int categoryId,
    String description,
    DateTime startTime,
    DateTime endTime,
  ) async {
    return await _createEventService.createEvent(
      categoryId,
      description,
      startTime,
      endTime,
      _appState.token,
    );
  }

  @override
  Future get activeCategories async =>
      await _getActiveCategoriesService.getActiveCategories(_appState.token);
}
