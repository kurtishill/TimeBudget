// To parse this JSON data, do
//
//     final authResponse = authResponseFromJson(jsonString);

import 'package:time_budget/serialization/decodable.dart';

class AuthResponse extends Decodable {
  final String username;
  final String email;
  final String token;

  AuthResponse({
    this.username,
    this.email,
    this.token,
  });

  @override
  AuthResponse fromJson(Map<String, dynamic> json) => AuthResponse(
        username: json["username"],
        email: json["email"],
        token: json["token"],
      );
}
