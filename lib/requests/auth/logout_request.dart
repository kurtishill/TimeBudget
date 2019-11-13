import 'package:time_budget/serialization/encodable.dart';

class LogoutRequest extends Encodable {
  final String username;

  LogoutRequest({
    this.username,
  });

  @override
  Map<String, dynamic> toJson() => {
        "username": username,
      };
}
