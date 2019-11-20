import 'dart:math';

import 'package:flutter/material.dart';
import 'package:time_budget/models/event.dart';
import 'package:time_budget/utils/date.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final double height;

  EventCard({@required this.event, this.height = 90});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.accents[Random().nextInt(Colors.accents.length)]
            .withOpacity(0.5),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              event.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              '${DateUtils.toClockTime(event.start)} - ${DateUtils.toClockTime(event.end)}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
