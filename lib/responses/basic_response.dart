import 'package:time_budget/serialization/decodable.dart';

class BasicResponse extends Decodable {
  final bool success;

  BasicResponse({this.success});

  @override
  Decodable fromJson(Map<String, dynamic> json) => BasicResponse(
        success: json['success'],
      );
}
