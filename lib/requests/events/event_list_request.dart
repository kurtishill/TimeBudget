// To parse this JSON data, do
//
//     final eventListRequest = eventListRequestFromJson(jsonString);

import 'package:time_budget/serialization/encodable.dart';

class EventListRequest extends Encodable {
  final String categoryID;
  final String startAt;
  final String endAt;

  EventListRequest({
    this.categoryID,
    this.startAt,
    this.endAt,
  });

  @override
  Map<String, dynamic> toJson() => {
        "categoryID": categoryID,
        "startAt": startAt,
        "endAt": endAt,
      };
}
