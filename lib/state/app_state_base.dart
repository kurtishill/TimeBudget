import 'package:time_budget/models/event.dart';
import 'package:time_budget/models/report.dart';
import 'package:time_budget/models/user.dart';

abstract class AppStateBase {
  Stream<User> get onUserChanged;
  void authenticate(User user);
  String get token;
  void logout();

  Stream<Report> onReportChanged;
  void updateReport(Report report);
  Report get report;

  Stream<List<Event>> onEventsChanged(int categoryId);
  void updateEvents(int categoryId, List<Event> events);
  List<Event> events(int id);

  void dispose();
}
