import 'package:time_budget/responses/events/event_response.dart';
import 'package:time_budget/serialization/decodable.dart';

class EventListResponse extends Decodable {
  final List<EventResponse> events;

  EventListResponse({
    this.events,
  });

  @override
  Decodable fromJson(Map<String, dynamic> json) => EventListResponse(
        events: json['events'],
      );
}
