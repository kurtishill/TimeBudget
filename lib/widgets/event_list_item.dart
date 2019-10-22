import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:time_budget/models/event.dart';

class EventListItem extends StatelessWidget {
  final Event event;

  EventListItem(this.event);

  @override
  Widget build(BuildContext context) {
    final hasHours = event.end.difference(event.start).inHours > 0;
    final hasMinutes = event.end.difference(event.start).inMinutes % 60 > 0;

    DateFormat dateFormat;
    if (hasHours && hasMinutes) {
      dateFormat = DateFormat("h 'hours' m 'minutes'");
    } else if (hasHours) {
      dateFormat = DateFormat("h 'hours'");
    } else {
      dateFormat = DateFormat("m 'minutes'");
    }

    return ListTile(
      title: Text(event.name),
      subtitle: Text(event.description ?? ''),
      trailing: Text(
        dateFormat.format(event.getTotalTimeAsDateTime()),
      ),
    );
  }
}
