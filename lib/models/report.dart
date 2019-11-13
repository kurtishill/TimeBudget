import 'package:flutter/foundation.dart';
import 'package:time_budget/models/category.dart' as cat;

class Report {
  final Map<int, cat.Category> metrics;

  Report({
    @required this.metrics,
  });

  bool operator ==(o) => o is Report && this.metrics == o.metrics;

  int get hashCode => 31 * this.metrics.hashCode;

  cat.Category operator [](int id) => metrics[id];
}
