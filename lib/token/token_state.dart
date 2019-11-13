
abstract class TokenStateBase {
  String token;
  
  String get getToken => token;

  void setToken(String newToken){
    token = newToken;
  }
}


class TokenState extends TokenStateBase {
  static final TokenState _instance = TokenState._internal();
  
  factory TokenState(){
    return _instance;
  }
   
   TokenState._internal(){
     token = '';
   }
}