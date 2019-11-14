import 'package:rxdart/rxdart.dart';
import 'package:time_budget/models/category.dart';
import 'package:time_budget/models/event.dart';
import 'package:time_budget/models/report.dart';
import 'package:time_budget/models/user.dart';

import 'app_state_base.dart';

class AppState extends AppStateBase {
  static final AppState _instance = AppState._internal();

  factory AppState() {
    return _instance;
  }

  AppState._internal();

  final _user = BehaviorSubject<User>();
  final _report = BehaviorSubject<Report>();

  List<Category> _availableCategories = [];

  Stream<User> get onUserChanged => _user.stream;

  void authenticate(User user) {
    _user.add(user);
  }

  String get token => _user.value.token;

  void logout() {
    _user.add(null);
  }

  Stream<Report> get onReportChanged => _report.stream;

  void updateReport(Report report) {
    _report.add(report);
  }

  Report get report => _report.value;

  Stream<List<Event>> onEventsChanged(int categoryId) =>
      _report.stream.map((r) => r.metrics[categoryId].events).distinct();

  void updateEvents(int categoryId, List<Event> events) {
    report.metrics[categoryId].events = events;
    report.setEvents(categoryId, events);
    updateReport(report);
  }

  List<Event> events(int id) => _report.value.metrics[id].events;

  List<Category> get availableCategories => _availableCategories;

  void setActiveCategories(List<Category> categories) {
    _availableCategories = categories;
  }

  void dispose() {
    _user.close();
    _report.close();
  }
}
