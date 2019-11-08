// To parse this JSON data, do
//
//     final deleteEventRequest = deleteEventRequestFromJson(jsonString);

import 'package:time_budget/serialization/encodable.dart';

class DeleteEventRequest extends Encodable {
  final String eventID;

  DeleteEventRequest({
    this.eventID,
  });

  @override
  Map<String, dynamic> toJson() => {
        "eventID": eventID,
      };
}
