import 'package:time_budget/serialization/encodable.dart';

class RegisterRequest extends Encodable {
  final String username;
  final String password;
  final String email;

  RegisterRequest({
    this.username,
    this.password,
    this.email,
  });

  @override
  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "email": email,
      };
}
