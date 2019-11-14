import 'package:flutter/foundation.dart';
import 'package:time_budget/models/category.dart' as cat;
import 'package:time_budget/models/event.dart';

class Report {
  final int start;
  final int end;
  final Map<int, cat.Category> metrics;

  Report({
    @required this.start,
    @required this.end,
    @required this.metrics,
  });

  bool operator ==(o) => o is Report && this.metrics == o.metrics;

  int get hashCode => 31 * this.metrics.hashCode;

  cat.Category operator [](int id) => metrics[id];

  void setEvents(int categoryId, List<Event> events) {
    int totalTime = events.fold(0, (t, c) => t + c.timeInSeconds);
    metrics[categoryId].amountOfTime = totalTime;
  }
}
