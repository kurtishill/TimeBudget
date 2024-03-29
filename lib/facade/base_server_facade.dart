abstract class IServerFacade {
  Future login(String username, String password);
  Future signUp(String username, String password, String email);
  Future getMetricsForTimePeriod(DateTime startTime, DateTime endTime);
  Future deleteEvent(int categoryId, int eventId);
  Future fetchEventsForCategory(
    int categoryId,
    DateTime startTime,
    DateTime endTime,
  );
  Future createEvent(
    int categoryId,
    String description,
    DateTime startTime,
    DateTime endTime,
  );
  Future get activeCategories;
}
