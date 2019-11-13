import 'package:time_budget/serialization/decodable.dart';

class EventResponse extends Decodable {
  final int eventID;
  final String description;
  final int startAt;
  final int endAt;

  EventResponse({
    this.eventID,
    this.description,
    this.startAt,
    this.endAt,
  });

  @override
  Decodable fromJson(Map<String, dynamic> json) => EventResponse(
        eventID: json['eventID'],
        description: json['description'],
        startAt: json['startAt'],
        endAt: json['endAt'],
      );
}
