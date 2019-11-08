// To parse this JSON data, do
//
//     final loginRequest = loginRequestFromJson(jsonString);

import 'package:time_budget/serialization/encodable.dart';

class LoginRequest extends Encodable {
  final String username;
  final String password;

  LoginRequest({
    this.username,
    this.password,
  });

  @override
  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
      };
}
