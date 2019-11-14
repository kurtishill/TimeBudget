import 'package:time_budget/serialization/encodable.dart';

class CreateEventRequest extends Encodable {
  final String description;
  final int startAt;
  final int endAt;
  final int categoryID;

  CreateEventRequest({
    this.description,
    this.startAt,
    this.endAt,
    this.categoryID,
  });

  @override
  Map<String, dynamic> toJson() => {
        "description": description,
        "startAt": startAt,
        "endAt": endAt,
        "categoryID": categoryID,
      };
}
