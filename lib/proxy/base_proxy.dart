abstract class IProxy {
  Future login(String username, String password);
  Future signUp(String username, String password, String email);
  Future getReportForTimePeriod(DateTime startTime, DateTime endTime);
  Future deleteEvent(String eventId);
}
