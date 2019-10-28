import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:time_budget/models/event.dart';
import 'package:time_budget/utils/date.dart';

class EventListItem extends StatelessWidget {
  final Event event;

  EventListItem(this.event);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(event.name),
      subtitle: Text(event.description ?? ''),
      trailing: Text(
        DateUtils.eventToHoursAndMinutes(
            event.start, event.end, event.getTotalTimeAsDateTime()),
      ),
    );
  }
}
