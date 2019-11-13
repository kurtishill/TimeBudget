import 'package:time_budget/serialization/encodable.dart';

class EventListRequest extends Encodable {
  final int categoryID;
  final int startAt;
  final int endAt;

  EventListRequest({
    this.categoryID,
    this.startAt,
    this.endAt,
  });

  @override
  Map<String, dynamic> toJson() => {
        "categoryID": categoryID,
        "startAt": startAt,
        "endAt": endAt,
      };
}
