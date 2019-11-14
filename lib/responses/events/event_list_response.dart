import 'package:time_budget/responses/events/event_response.dart';
import 'package:time_budget/serialization/decodable.dart';

class EventListResponse extends Decodable {
  final List<dynamic> events;

  EventListResponse({
    this.events,
  });

  @override
  Decodable fromJson(Map<String, dynamic> json) {
    final response = EventListResponse(
      events: json['events'],
    );

    List<EventResponse> events = [];

    response.events.forEach((r) {
      events.add(EventResponse().fromJson(r));
    });

    return EventListResponse(events: events);
  }
}
