import 'package:flutter/foundation.dart';

class User {
  final String username;
  final String token;
  final String email;

  User({
    @required this.username,
    @required this.token,
    @required this.email,
  });
}
