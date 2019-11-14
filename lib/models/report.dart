import 'package:flutter/foundation.dart';
import 'package:time_budget/models/category.dart' as cat;
import 'package:time_budget/models/event.dart';

class Report {
  final Map<int, cat.Category> metrics;

  Report({
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
