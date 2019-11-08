import 'dart:convert';

abstract class Encodable {
  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson();
}
