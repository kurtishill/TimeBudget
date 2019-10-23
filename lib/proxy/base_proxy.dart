abstract class IProxy {
  Future login(String username, String password);
  Future signUp(String username, String password, String email);
  Future getInfoForDate(DateTime date);
}
